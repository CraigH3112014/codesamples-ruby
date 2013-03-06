# # SendInvoice API
# Use the SendInvoice API operation to send an invoice to a payer, and notify the payer of the pending invoice.
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-invoice'

module Invoice
  class SendInvoice
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def send_invoice
      # ##Build request object
      @send_invoice_request = @api.build_send_invoice()
      @send_invoice_request.invoiceID = "INV2-LRB8-X58V-NGBV-T3EA"
      
      # ##Make API call & get response
      @send_invoice_response = @api.send_invoice(@send_invoice_request)
      
      # ##Access Response
      # ### Success Response

      if @send_invoice_response.responseEnvelope.ack == "Success"

        # ID of the created invoice.
        @api.logger.info("Invoice ID : " + @send_invoice_response.invoiceID)

        # ###Error Response
      else
        @api.logger.error(@send_invoice_response.error[0].message)
      end
      @send_invoice_response
    end
  end
end