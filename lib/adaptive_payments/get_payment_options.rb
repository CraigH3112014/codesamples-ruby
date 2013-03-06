# # GetPaymentOptions API
# You use the GetPaymentOptions API operation to retrieve the payment options passed with the SetPaymentOptionsRequest.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class GetPaymentOptions
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def get_payment_options
      # ##Build request object
      @get_payment_options_request = @api.build_get_payment_options()

      # The pay key that identifies the payment for which you
      # want to set payment options. This is the pay key returned in the
      # PayResponse message. Action Type in PayRequest must be `CREATE`
      @get_payment_options_request.payKey = "AP-9B283753LH273411W"

      # ##Make API call & get response
      @get_payment_options_response = @api.get_payment_options(@get_payment_options_request)

      # ##Access Response
      # ### Success Response

      if @get_payment_options_response.responseEnvelope.ack == "Success"

        # Business Name you set in SetPaymentOptions
        @api.logger.info("Business Name : " +  @get_payment_options_response.displayOptions.businessName)

        # ###Error Response
      else
        @api.logger.error(@get_payment_options_response.error[0].message)
      end
      @get_payment_options_response
    end
  end

end