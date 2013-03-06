# # DoExpressCheckout API
# The DoExpressCheckoutPayment API operation completes an Express Checkout
# transaction. If you set up a billing agreement in your SetExpressCheckout
# API call, the billing agreement is created when you call the
# DoExpressCheckoutPayment API operation.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class DoExpressCheckout
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def  do_express_checkout

      # ##Build request object
      @do_express_checkout_payment = @api.build_do_express_checkout_payment({
        :DoExpressCheckoutPaymentRequestDetails => {
          
          # How you want to obtain payment. When implementing parallel payments,
          # this field is required and must be set to `Order`. When implementing
          # digital goods, this field is required and must be set to `Sale`. If the
          # transaction does not include a one-time purchase, this field is
          # ignored. It is one of the following values:
          # 
          # * `Sale` - This is a final sale for which you are requesting payment
          # (default).
          # * `Authorization` - This payment is a basic authorization subject to
          # settlement with PayPal Authorization and Capture.
          # * `Order` - This payment is an order authorization subject to
          # settlement with PayPal Authorization and Capture.
          # Note:
          # You cannot set this field to Sale in SetExpressCheckout request and
          # then change the value to Authorization or Order in the
          # DoExpressCheckoutPayment request. If you set the field to
          # Authorization or Order in SetExpressCheckout, you may set the field
          # to Sale.
          :PaymentAction => "Sale",
            
          # The timestamped token value that was returned in the
          # `SetExpressCheckout` response and passed in the
          # `GetExpressCheckoutDetails` request.
          :Token => "EC-4MJ31985Y7733521G",
            
          # Unique paypal buyer account identification number as returned in `GetExpressCheckoutDetails` Response
          :PayerID => "A9BVYX8XCR9ZQ",
            
          # information about the payment
          :PaymentDetails => [{
            
            # Total cost of the transaction to the buyer. If shipping cost and tax
            # charges are known, include them in this value. If not, this value
            # should be the current sub-total of the order. 
            # 
            # If the transaction includes one or more one-time purchases, this field must be equal to
            # the sum of the purchases. Set this field to 0 if the transaction does
            # not include a one-time purchase such as when you set up a billing
            # agreement for a recurring payment that is not immediately charged.
            # When the field is set to 0, purchase-specific fields are ignored.
            # 
            # * `Currency Code` - You must set the currencyID attribute to one of the
            # 3-character currency codes for any of the supported PayPal
            # currencies.
            # * `Amount`
            :OrderTotal => {
              :currencyID => "USD",
              :value => "2.0" },
              
            # Your URL for receiving Instant Payment Notification (IPN) about this transaction. If you do not specify this value in the request, the notification URL from your Merchant Profile is used, if one exists.  
            :NotifyURL => "https:#paypal-sdk-samples.herokuapp.com/merchant/ipn_notify" }] } })
      
      # ##Make API call & get response
      @do_express_checkout_payment_response = @api.do_express_checkout_payment(@do_express_checkout_payment)
      
      # ##Access Response
      # ###Success Response

      if @do_express_checkout_payment_response.Ack == "Success"

        # Transaction identification number of the transaction that was
        # created.
        # This field is only returned after a successful transaction
        # for DoExpressCheckout has occurred.
        @api.logger.info("Transaction ID : " + @do_express_checkout_payment_response.DoExpressCheckoutPaymentResponseDetails.PaymentInfo[0].TransactionID)

        # ###Error Response
      else
        @api.logger.error(@do_express_checkout_payment_response.Errors[0].LongMessage)
      end
      @do_express_checkout_payment_response
    end
  end
end