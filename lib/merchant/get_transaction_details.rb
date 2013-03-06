# # GetTransactionDetails API
# The GetTransactionDetails API operation obtains information about a specific transaction.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class GetTransactionDetails
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def get_transaction_details

      # ##Build request object
      @get_transaction_details = @api.build_get_transaction_details({
        
        # Unique identifier of a transaction.
        # `Note:
        # The details for some kinds of transactions cannot be retrieved with
        # GetTransactionDetails. You cannot obtain details of bank transfer
        # withdrawals, for example.`
        :TransactionID => "7UT7960735190442H" })
      
      # ##Make API call & get response
      @get_transaction_details_response = @api.get_transaction_details(@get_transaction_details)
      
      # ##Access Response
      @get_transaction_details_response.Timestamp
      @get_transaction_details_response.Ack
      @get_transaction_details_response.CorrelationID
      @get_transaction_details_response.Version
      @get_transaction_details_response.Build
      @get_transaction_details_response.PaymentTransactionDetails
      # ###Success Response

      if @get_transaction_details_response.Ack == "Success"

        # Unique PayPal Customer Account identification number.
        @api.logger.info("Payer ID : " +  @get_transaction_details_response.PaymentTransactionDetails.PayerInfo.PayerID)

        # ###Error Response
      else
        @api.logger.error(@get_transaction_details_response.Errors[0].LongMessage)
      end
      @get_transaction_details_response
    end

  end
end