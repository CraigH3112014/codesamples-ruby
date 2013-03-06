# # CreateInvoice API
# Use the CreateInvoice API operation to create a new invoice. The call includes merchant, payer, and API caller information, in addition to invoice detail. The response to the call contains an invoice ID and URL.
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-invoice'

module Invoice
  class CreateInvoice
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def create_invoice

      # ##Build request object
      @create_invoice_request = @api.build_create_invoice()
      
      # Merchant email address.
      @create_invoice_request.invoice.merchantEmail = "jb-us-seller@paypal.com"
      
      # Payer email address.
      @create_invoice_request.invoice.payerEmail    = "sender@yahoo.com"
      
      # SKU or name of the item.
      @create_invoice_request.invoice.itemList.item[0].name      = "item1"
      
      # Item count
      @create_invoice_request.invoice.itemList.item[0].quantity  = 2.0
      
      # Price of the item, in the currency specified by the invoice.
      @create_invoice_request.invoice.itemList.item[0].unitPrice = 5.0
      
      # Currency used for all invoice item amounts and totals.
      @create_invoice_request.invoice.currencyCode  = "USD"
      
      # Terms by which the invoice payment is due. It is
      # one of the following values:
      # * DueOnReceipt - Payment is due when the payer receives the invoice.
      # * DueOnDateSpecified - Payment is due on the date specified in the
      # invoice.
      # * Net10 - Payment is due 10 days from the invoice date.
      # * Net15 - Payment is due 15 days from the invoice date.
      # * Net30 - Payment is due 30 days from the invoice date.
      # * Net45 - Payment is due 45 days from the invoice date.
      @create_invoice_request.invoice.paymentTerms  = "DueOnReceipt"
      
      # ##Make API call & get response
      @create_invoice_response = @api.create_invoice(@create_invoice_request)
      
      # ##Access Response
      # ### Success Response

      if @create_invoice_response.responseEnvelope.ack == "Success"
        # ID of the created invoice.
        @api.logger.info("Invoice ID : " + @create_invoice_response.invoiceID)

        # ###Error Response
      else
        @api.logger.error(@create_invoice_response.error[0].message)
      end
      @create_invoice_response
    end
  end
end