# # GetInvoiceDetails API
# Use the GetInvoiceDetails API operation to get detailed information about an invoice.
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/invoice-sdk/ruby)

require 'paypal-sdk-invoice'

module Invoice
  class GetInvoiceDetails
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def get_invoice_details
 
      # Build request object
      @get_invoice_details_request = @api.build_get_invoice_details()
      
      # ID of the invoice to retrieve.
      @get_invoice_details_request.invoiceID = "INV2-SLU9-BUA7-DKF4-SPDA"
      
      # Make API call & get response
      @get_invoice_details_response = @api.get_invoice_details(@get_invoice_details_request)
      
      # Access Response
      @get_invoice_details_response.responseEnvelope
      @get_invoice_details_response.invoice
    
      @get_invoice_details_response.invoiceURL
      # ### Success Response

      if @get_invoice_details_response.responseEnvelope.ack == "Success"

        # Status of the invoice searched.
        @api.logger.info("Status : " + @get_invoice_details_response.invoiceDetails.status)

        # ###Error Response
      else
        @api.logger.error(@get_invoice_details_response.error[0].message)
      end
      @get_invoice_details_response
    end
  end
end