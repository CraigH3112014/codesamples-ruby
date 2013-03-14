# # DoReauthorization API
# Authorize a payment.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class DoReauthorization
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_reauthorization

      # ##Build request object
      @do_reauthorization = @api.build_do_reauthorization({
        
        # Value of a previously authorized transaction identification number returned by PayPal.
        :AuthorizationID => "2MU54201HN875194K",
          
        # `Amount` to reauthorize
        :Amount => {
          :currencyID => "USD",
          :value => "2" } })
      
      # ##Make API call & get response
      @do_reauthorization_response = @api.do_reauthorization(@do_reauthorization)
      
      # ##Access Response
      # ###Success Response

      if @do_reauthorization_response.Ack == "Success"

        # Authorization identification number
        @api.logger.info("Authorization ID : " + @do_reauthorization_response.AuthorizationID)

        # ###Error Response
      else
        @api.logger.error(@do_reauthorization_response.Errors[0].LongMessage)
      end
      @do_reauthorization_response
    end
  end
end