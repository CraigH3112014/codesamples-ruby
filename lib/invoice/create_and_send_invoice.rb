# # CreateAndSendInvoice API
# Use the CreateAndSendInvoice API operation to create and send an invoice.
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/invoice-sdk/ruby)

require 'paypal-sdk-invoice'

module Invoice
  class CreateAndSendInvoice
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def create_and_send_invoice

      # ##Build request object
      @create_and_send_invoice_request = @api.build_create_and_send_invoice()
      
      # Merchant email address.
      @create_and_send_invoice_request.invoice.merchantEmail = "jb-us-seller@paypal.com"
      
      # Payer email address.
      @create_and_send_invoice_request.invoice.payerEmail    = "sender@yahoo.com"
      
      # SKU or name of the item.
      @create_and_send_invoice_request.invoice.itemList.item[0].name      = "item1"
      
      # Item count
      @create_and_send_invoice_request.invoice.itemList.item[0].quantity  = 2.0
      
      # Price of the item, in the currency specified by the invoice.
      @create_and_send_invoice_request.invoice.itemList.item[0].unitPrice = 5.0
      
      # Currency used for all invoice item amounts and totals.
      @create_and_send_invoice_request.invoice.currencyCode  = "USD"
      
      # Terms by which the invoice payment is due. It is
      # one of the following values:
      # * DueOnReceipt - Payment is due when the payer receives the invoice.
      # * DueOnDateSpecified - Payment is due on the date specified in the
      # invoice.
      # * Net10 - Payment is due 10 days from the invoice date.
      # * Net15 - Payment is due 15 days from the invoice date.
      # * Net30 - Payment is due 30 days from the invoice date.
      # * Net45 - Payment is due 45 days from the invoice date.
      @create_and_send_invoice_request.invoice.paymentTerms  = "DueOnReceipt"
      
      # ##Make API call & get response
      @create_and_send_invoice_response = @api.create_and_send_invoice(@create_and_send_invoice_request)
      
      # ##Access Response
      # ### Success Response

      if @create_and_send_invoice_response.responseEnvelope.ack == "Success"
        # ID of the created invoice.
        @api.logger.info("Invoice ID : " + @create_and_send_invoice_response.invoiceID)

        # ###Error Response
      else
        @api.logger.error(@create_and_send_invoice_response.error[0].message)
      end
      @create_and_send_invoice_response
    end
  end
end