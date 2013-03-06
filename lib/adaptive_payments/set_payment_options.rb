# # SetPaymentOptions API
# You use the SetPaymentOptions API operation to specify settings for a payment of the actionType `CREATE`. This actionType is specified in the PayRequest message.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class SetPaymentOptions
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def set_payment_options

      # ##Build request object
      @set_payment_options_request = @api.build_set_payment_options()

      # The pay key that identifies the payment for which you
      # want to set payment options. This is the pay key returned in the
      # PayResponse message. Action Type in PayRequest must be `CREATE`
      @set_payment_options_request.payKey = "AP-2K218264SC168632N"

      # You can set options as shown below:
      # 
      # The business name to display. The name cannot exceed 128 characters.
      # @set_payment_options_request.displayOptions.businessName = "Toy Shop"

      # ##Make API call & get response
      @set_payment_options_response = @api.set_payment_options(@set_payment_options_request)

      # ##Access Response
      # ### Success Response

      if @set_payment_options_response.responseEnvelope.ack == "Success"

        # ###Error Response
      else
        @api.logger.error(@set_payment_options_response.error[0].message)
      end
      @set_payment_options_response
    end

  end
end