# # PaymentDetails API
# Use the PaymentDetails API operation to obtain information about a payment. You can identify the payment by your tracking ID, the PayPal transaction ID in an IPN message, or the pay key associated with the payment.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/adaptivepayments-sdk/ruby)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class PaymentDetails
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def payment_details

      # ##Build request object
      @payment_details_request = @api.build_payment_details()

      # You must specify either,
      # 
      # * `Pay Key` - The pay key that identifies the payment for which you want to retrieve details. This is the pay key returned in the PayResponse message.
      # * `Transaction ID` - The PayPal transaction ID associated with the payment. The IPN message associated with the payment contains the transaction ID.
      # `@payment_details_request.transactionId = transactionId`
      # * `Tracking ID` - The tracking ID that was specified for this payment in the PayRequest message.
      # `@payment_details_request.trackingId = trackingId`
      @payment_details_request.payKey = "AP-5S482348KH512131U"

      # ##Make API call & get response
      @payment_details_response = @api.payment_details(@payment_details_request)

      # ##Access Response
      # ### Success Response

      if @payment_details_response.responseEnvelope.ack == "Success"

        # The status of the payment. Possible values are:
        # 
        # * CREATED - The payment request was received; funds will be
        # transferred once the payment is approved
        # * COMPLETED - The payment was successful
        # * INCOMPLETE - Some transfers succeeded and some failed for a
        # parallel payment or, for a delayed chained payment, secondary
        # receivers have not been paid
        # * ERROR - The payment failed and all attempted transfers
        # failed
        # or all completed transfers were successfully reversed
        # * REVERSALERROR - One or more transfers failed when
        # attempting
        # to reverse a payment
        # * PROCESSING - The payment is in progress
        # * PENDING - The payment is awaiting processing
        @api.logger.info("Payment Status : " + @payment_details_response.status)

        # ###Error Response
      else
        @api.logger.error(@payment_details_response.error[0].message)
      end
      @payment_details_response
    end
  end
end