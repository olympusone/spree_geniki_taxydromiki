import { Controller } from '@hotwired/stimulus';
import { post } from '@rails/request.js';

export default class extends Controller {
  static values = {
    orderId: Number,
  };

  async createVoucher(event) {
    event.preventDefault();

    if (window.confirm('Are you sure?')) {
      const response = await post(
        `${Spree.adminPath}/geniki_taxydromiki/${this.orderIdValue}/create`,
        {
          responseKind: 'json',
        }
      );

      if (response.ok) {
        const { message } = await response.json;
        console.log('Voucher created successfully:', message);
      } else {
        const { error } = await response.json;
        console.error('Error creating voucher:', error);
      }
    }
  }

  async printVoucher(event) {
    event.preventDefault();

    if (window.confirm('Are you sure?')) {
      console.log('Printing', this.orderIdValue);

      // TODO
      // Implement the logic to print the voucher
      // This could involve fetching a printable version of the voucher and opening it in a new window or printing directly
    }
  }

  async cancelVoucher(event) {
    event.preventDefault();

    if (window.confirm('Are you sure?')) {
      console.log('Cancelling', this.orderIdValue);

      // TODO
      // Implement the logic to cancel the voucher
      // This could involve sending a request to the server to cancel the voucher and updating the UI accordingly
    }
  }

  async finalizeVoucher(event) {
    event.preventDefault();

    if (window.confirm('Are you sure?')) {
      console.log('Finalizing', this.orderIdValue);

      // TODO
      // Implement the logic to finalize the voucher
      // This could involve sending a request to the server to finalize the voucher and updating the UI accordingly
    }
  }
}
