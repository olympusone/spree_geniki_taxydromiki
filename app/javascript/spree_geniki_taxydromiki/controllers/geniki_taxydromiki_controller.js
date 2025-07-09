import { Controller } from '@hotwired/stimulus'
import { post } from '@rails/request.js'

export default class extends Controller {
  static values = {
    orderId: Number
  }

  connect() {
    console.log('Hello')
  }

  async createVoucher(event) {
    event.preventDefault()

    if (window.confirm('Are you sure?')) {
      console.log('Creating', this.orderIdValue)

      // TODO
      // post(this.adminAssetsPathValue, {
      //   body: JSON.stringify({
      //     asset: {
      //       type: this.assetClassValue,
      //       viewable_type: this.viewableTypeValue,
      //       viewable_id: this.viewableIdValue,
      //       attachment: response.signed_id
      //     }
      //   }),
      //   responseKind: 'turbo-stream'
      // })

      // const response = await post(`${Spree.adminPath}/action_text/video_embeds`, { body: JSON.stringify({ url: input.value }), responseKind: 'json' })

      // if (response.ok) {
      //   const { sgid, content } = await response.json
      // } else {
      //   const { error } = await response.json
      // }
    }
  }

  async printVoucher(event) {
    event.preventDefault()

    if (window.confirm('Are you sure?')) {
      console.log('Printing', this.orderIdValue)

      // TODO
      // Implement the logic to print the voucher
      // This could involve fetching a printable version of the voucher and opening it in a new window or printing directly
    }
  }

  async cancelVoucher(event) {
    event.preventDefault()

    if (window.confirm('Are you sure?')) {
      console.log('Cancelling', this.orderIdValue)

      // TODO
      // Implement the logic to cancel the voucher
      // This could involve sending a request to the server to cancel the voucher and updating the UI accordingly
    }
  }

  async finalizeVoucher(event) {
    event.preventDefault()

    if (window.confirm('Are you sure?')) {
      console.log('Finalizing', this.orderIdValue)

      // TODO
      // Implement the logic to finalize the voucher
      // This could involve sending a request to the server to finalize the voucher and updating the UI accordingly
    }
  }
}
