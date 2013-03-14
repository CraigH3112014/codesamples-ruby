# # RefundTransaction API
#  The RefundTransaction API operation issues a refund to the PayPal account holder associated with a transaction.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class RefundTransaction
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def refund_transaction

      # ##Build request object
      @refund_transaction = @api.build_refund_transaction({
        
        # Either the `transaction ID` or the `payer ID` must be specified.
        # PayerID is unique encrypted merchant identification number
        # For setting `payerId`,
        # `:PayerID => "A9BVYX8XCR9ZQ"`
    
        # Unique identifier of the transaction to be refunded.
        :TransactionID => "38E95181RJ9435235",
          
        #  Type of refund you are making. It is one of the following values:
        # 
        # * `Full` - Full refund (default).
        # * `Partial` - Partial refund.
        # * `ExternalDispute` - External dispute. (Value available since
        # version
        # 82.0)
        # * `Other` - Other type of refund. (Value available since version
        # 82.0)
        :RefundType => "Partial",
          
        # `Refund amount`, which contains
        # 
        # * `Currency Code`
        # * `Amount`
        # The amount is required if RefundType is Partial.
        # `Note:
        # If RefundType is Full, do not set the amount.`
        :Amount => {
          :currencyID => "USD",
          :value => "1" } })
      
      # ##Make API call & get response
      @refund_transaction_response = @api.refund_transaction(@refund_transaction)
      
      # ##Access Response
      # ###Success Response

      if @refund_transaction_response.Ack == "Success"

        # Unique identifier of the refund transaction
        @api.logger.info("Refund Transaction ID : " + @refund_transaction_response.RefundTransactionID)

        # ###Error Response
      else
        @api.logger.error(@refund_transaction_response.Errors[0].LongMessage)
      end
      @refund_transaction_response
    end
  end
end