# # DoReferenceTransaction API
# The DoReferenceTransaction API operation processes a payment from a buyer's account, which is identified by a previous transaction.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class DoReferenceTransaction
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_reference_transaction
      
      # ##Build request object
      @do_reference_transaction = @api.build_do_reference_transaction({
        :DoReferenceTransactionRequestDetails => {
          
          # A transaction ID from a previous purchase, such as a
          # credit card charge using the DoDirectPayment API, or a billing
          # agreement ID.
          :ReferenceID => "97U72738FY126561H",
            
          # How you want to obtain payment. It is one of
          # the following values:
          # 
          # * Authorization
          # * Sale
          # * Order
          # * None
          :PaymentAction => "Sale",
          
          # Information about the payment
          :PaymentDetails => {
            
            # The total cost of the transaction to the buyer. If shipping cost and
            # tax charges are known, include them in this value. If not, this value
            # should be the current subtotal of the order. 
            
            # If the transaction includes one or more one-time purchases, this field must be equal to
            # the sum of the purchases. Set this field to 0 if the transaction does
            # not include a one-time purchase such as when you set up a billing
            # agreement for a recurring payment that is not immediately charged.
            # When the field is set to 0, purchase-specific fields are ignored
            # 
            # * `Currency ID` - You must set the currencyID attribute to one of the
            # 3-character currency codes for any of the supported PayPal
            # currencies.
            # * `Amount`
            :OrderTotal => {
              :currencyID => "USD",
              :value => "5" },
              
            # Your URL for receiving Instant Payment Notification (IPN) about this transaction. If you do not specify this value in the request, the notification URL from your Merchant Profile is used, if one exists.
            :NotifyURL => "https://paypal-sdk-samples.herokuapp.com/merchant/ipn_notify" } } })
      
      # ##Make API call & get response
      @do_reference_transaction_response = @api.do_reference_transaction(@do_reference_transaction)
      
      # ##Access Response
      # ###Success Response
      if @do_reference_transaction_response.Ack == "Success"
        
        # The final amount charged, including any shipping and taxes from your Merchant Profile.
        @api.logger.info(@do_reference_transaction_response.DoReferenceTransactionResponseDetails.Amount.value + " " + @do_reference_transaction_response.DoReferenceTransactionResponseDetails.Amount.currencyID)
           
        # ###Error Response
      else
        @api.logger.error(@do_reference_transaction_response.Errors[0].LongMessage)
      end
        @do_reference_transaction_response
    end

  end
end