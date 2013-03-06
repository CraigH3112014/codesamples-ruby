# # DoVoid API
# Void an order or an authorization.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class DoVoid
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_void

      # ##Build request object
      @do_void = @api.build_do_void({
        
        # Original authorization ID specifying the
        # authorization to void or, to void an order, the order ID.
        # `Important:
        # If you are voiding a transaction that has been reauthorized, use the
        # ID from the original authorization, and not the reauthorization.`
        :AuthorizationID => "O-5HA991887B842362X" })
      
      # ##Make API call & get response
      @do_void_response = @api.do_void(@do_void)
      
      # ##Access Response
      # ###Success Response

      if @do_void_response.Ack == "Success"

        # Authorization identification number you specified in the request.
        @api.logger.info("Authorization ID : " + @do_void_response.AuthorizationID)

        # ###Error Response
      else
        @api.logger.error(@do_void_response.Errors[0].LongMessage)
      end
      @do_void_response
    end
  end
end