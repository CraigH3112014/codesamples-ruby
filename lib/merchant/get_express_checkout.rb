# # GetExpressCheckoutDetails API
# The GetExpressCheckoutDetails API operation obtains information about an Express Checkout transaction.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class GetExpressCheckout
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def get_express_checkout

      # ##Build request object
      @get_express_checkout_details = @api.build_get_express_checkout_details({
        
        # A timestamped token, the value of which was returned by `SetExpressCheckout` response.
        :Token => "EC-4WP55188ET274430R" })
      
      # ##Make API call & get response
      @get_express_checkout_details_response = @api.get_express_checkout_details(@get_express_checkout_details)
      
      # ##Access Response
      # ###Success Response

      if @get_express_checkout_details_response.Ack == "Success"

        # Unique PayPal Customer Account identification number. This
        # value will be null unless you authorize the payment by
        # redirecting to PayPal after `SetExpressCheckout` call.
        @api.logger.info("Payer ID : " +  @get_express_checkout_details_response.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerID)

        # ###Error Response
      else
        @api.logger.error(@get_express_checkout_details_response.Errors[0].LongMessage)
      end
      @get_express_checkout_details_response
    end
  end
end