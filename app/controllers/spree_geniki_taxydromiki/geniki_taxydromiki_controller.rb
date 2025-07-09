class GenikiTaxydromikiController < Spree::StoreController
  # store_integration('geniki_taxydromiki')

  def create
    # TODO
    # create_job_result = create_response.body[:create_job_response][:create_job_result]
    render json: {
      ok: true
    }
  end

  def print
    # TODO
    # pdf_url = "https://testvoucher.taxydromiki.gr/JobServicesV2.asmx/GetVoucherPdf?authKey=#{auth_key}&voucherNo=#{voucher_number}&format=Flyer&extraInfoFormat=None"
    render json: {
      ok: true
    }
  end

  def cancel
    # TODO
    # client.call(:cancel_job, message: { sAuthKey: auth_key, nJobId: job_id, bCancel: true })
    render json: {
      ok: true
    }
  end

  def finalize
    # TODO: implement if we need to
    # 5. Finalize (End of day)
    # client.call(:close_pending_jobs_by_date, message: { sAuthKey: auth_key, dFr: from_time, dTo: to_time })
    render json: {
      ok: true
    }
  end
end
