require 'savon'

module GenikiTaxydromiki
  class SoapClient
    include Spree::IntegrationsConcern

    attr_reader :client

    def initialize
      integration = store_integration('geniki_taxydromiki')

      raise 'Integration not found' unless integration

      wsdl_url = integration.preferred_wsdl_url

      raise 'WSDL URL is required' unless wsdl_url

      @username = integration.preferred_username
      @password = integration.preferred_password
      @app_key = integration.preferred_app_key

      wsdl_url += '?wsdl' unless wsdl_url.downcase.end_with?('?wsdl')

      @client = Savon.client(wsdl: wsdl_url)
    end

    def call(method, message)
      retried = false

      begin
        response = client.call(
          method,
          message: {
            sAuthKey: auth_key,
            **message
          }
        )

        result = response.body.dig(
          :"#{method}_response",
          :"#{method}_result"
        )

        # Check if the result contain the authentication error
        if result.respond_to?(:result) && result[:result].to_i == 11
          unless retried
            Rails.cache.delete('geniki_taxydromiki_auth_key')

            retried = true

            raise RetryAuthKeyError
          end

          raise AuthenticationError, 'Auth key expired or invalid'
        end

        result
      rescue RetryAuthKeyError
        retry
      rescue Savon::Error => e
        raise SoapError, "SOAP call failed: #{e.message}"
      end
    end

    def authenticate!
      unless @username && @password && @app_key
        raise SoapError, 'Username, password, and app_key required for authentication'
      end

      response = client.call(
        :authenticate,
        message: {
          sUsrName: @username,
          sUsrPwd: @password,
          applicationKey: @app_key
        }
      )

      result = response.body[:authenticate_response][:authenticate_result]

      return result[:key] if result[:result].to_i.zero?

      raise AuthenticationError, "Authentication failed with code: #{result[:result]}"
    rescue Savon::Error => e
      raise AuthenticationError, "Authentication failed: #{e.message}"
    end

    def auth_key
      Rails.cache.fetch('geniki_taxydromiki_auth_key', expires_in: 6.hours) do
        authenticate!
      end
    end

    class SoapError < StandardError; end
    class AuthenticationError < StandardError; end
    class RetryAuthKeyError < StandardError; end
  end
end
