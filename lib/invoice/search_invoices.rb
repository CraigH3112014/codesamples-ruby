# # SearchInvoices API
# Use the SearchInvoice API operation to search an invoice.
# This sample code uses Invoice Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-invoice'

module Invoice
  class SearchInvoices
    def initialize()
      @api = PayPal::SDK::Invoice::API.new
    end

    def search_invoices

      # ##Build request object
      @search_invoices_request = @api.build_search_invoices()
      
      # Email address of invoice creator.
      @search_invoices_request.merchantEmail = "jb-us-seller@paypal.com"
      
      # Invoice amount search. It specifies the smallest amount to be
      # returned. If you pass a value for this field, you must also pass a
      # currencyCode value.
      @search_invoices_request.parameters.upperAmount  = 4.0
      
      # Currency used for lower and upper amounts. It is required when you
      # specify lowerAmount or upperAmount.
      @search_invoices_request.parameters.currencyCode = "USD"
      
      # Page number of result set, starting with 1.
      @search_invoices_request.page          = 1
      
      # Number of results per page, between 1 and 100.
      @search_invoices_request.pageSize      = 10
      
      # ##Make API call & get response
      @search_invoices_response = @api.search_invoices(@search_invoices_request)
      
      # ##Access Response
      # ### Success Response

      if @search_invoices_response.responseEnvelope.ack == "Success"

        # Number of invoices that matched the request.
        @api.logger.info("Count : " + @search_invoices_response.count.to_s)

        # ###Error Response
      else
        @api.logger.error(@search_invoices_response.error[0].message)
      end
      @search_invoices_response
    end
  end
end