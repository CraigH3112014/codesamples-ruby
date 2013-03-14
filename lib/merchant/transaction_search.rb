# # TransactionSearch API
# The TransactionSearch API searches transaction history for transactions
# that meet the specified criteria.
# `Note:
# The maximum number of transactions that can be returned from a
# TransactionSearch API call is 100.`
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class TransactionSearch
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def transaction_search

      # ##Build request object
      @transaction_search = @api.build_transaction_search({
        
        # The earliest transaction date at which to start the search.
        :StartDate => "2013-01-19T00:00:00+05:30" })
      
      # ##Make API call & get response
      @transaction_search_response = @api.transaction_search(@transaction_search)
      
      # ##Access Response
      # ###Success Response

      if @transaction_search_response.Ack == "Success"

        @transaction_search_response.PaymentTransactions.each do |transactions|
          # Merchant's transaction ID.
          @api.logger.info("Transaction ID : " + transactions.TransactionID)
        end
        # ###Error Response
      else
        @api.logger.error(@transaction_search_response.Errors[0].LongMessage)
      end
      @transaction_search_response
    end
  end
end