# # DoAuthorization API
# Authorize a payment.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class DoAuthorization
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_authorization

      # Build request object
      @do_authorization = @api.build_do_authorization({
        
        # Value of the order's transaction identification number returned by PayPal.
        :TransactionID => "O-6NK19832WS5289626",
          
        # Amount to authorize.
        :Amount => {
          :currencyID => "USD",
          :value => "2.00" } })
      
      # Make API call & get response
      @do_authorization_response = @api.do_authorization(@do_authorization)
      
      # Access Response
      # ###Success Response

      if @do_authorization_response.Ack == "Success"

        # Authorization identification number
        @api.logger.info("Transaction ID : " + @do_authorization_response.TransactionID)

        # ###Error Response
      else
        @api.logger.error(@do_authorization_response.Errors[0].LongMessage)
      end
      @do_authorization_response
    end
  end
end