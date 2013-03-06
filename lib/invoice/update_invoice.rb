# # UpdateInvoice API
# Use the UpdateInvoice API operation to update an invoice
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-invoice'

module Invoice
  class UpdateInvoice
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def update_invoice

      # ##Build request object
      @update_invoice_request = @api.build_update_invoice()
     
      # ID of the invoice to update.
      @update_invoice_request.invoiceID = "INV2-SLU9-BUA7-DKF4-SPDA"
      
      # Merchant email address.
      @update_invoice_request.invoice.merchantEmail = "jb-us-seller@paypal.com"
     
      # Payer email address.
      @update_invoice_request.invoice.payerEmail    = "sender@yahoo.com"
     
      # SKU or name of the item.
      @update_invoice_request.invoice.itemList.item[0].name      = "item1"
     
      # Item count
      @update_invoice_request.invoice.itemList.item[0].quantity  = 2.0
     
      # Price of the item, in the currency specified by the invoice.
      @update_invoice_request.invoice.itemList.item[0].unitPrice = 5.0
     
      # Currency used for all invoice item amounts and totals.
      @update_invoice_request.invoice.currencyCode  = "USD"
     
      # Terms by which the invoice payment is due. It is
      # one of the following values:
      # * DueOnReceipt - Payment is due when the payer receives the invoice.
      # * DueOnDateSpecified - Payment is due on the date specified in the
      # invoice.
      # * Net10 - Payment is due 10 days from the invoice date.
      # * Net15 - Payment is due 15 days from the invoice date.
      # * Net30 - Payment is due 30 days from the invoice date.
      # * Net45 - Payment is due 45 days from the invoice date.
      @update_invoice_request.invoice.paymentTerms  = "DueOnReceipt"
     
      # ##Make API call & get response
      @update_invoice_response = @api.update_invoice(@update_invoice_request)
     
      # ##Access Response
      # ### Success Response
 
      if @update_invoice_response.responseEnvelope.ack == "Success"
        # ID of the created invoice.
        @api.logger.info("Invoice ID : " + @update_invoice_response.invoiceID)
 
        # ###Error Response
      else
       @api.logger.error(@update_invoice_response.error[0].message)
      end
      @update_invoice_response
    end
  end
end