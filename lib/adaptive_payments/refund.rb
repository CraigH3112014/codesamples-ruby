# # Refund API
# Use the Refund API operation to refund all or part of a payment.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/adaptivepayments-sdk/ruby)
require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class Refund
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def refund

      # ##Build request object
      @refund_request = @api.build_refund()

      # You must specify either,
      # 
      # * `Pay Key` - The pay key that identifies the payment for which you want to retrieve details. This is the pay key returned in the PayResponse message.
      # * `Transaction ID` - The PayPal transaction ID associated with the payment. The IPN message associated with the payment contains the transaction ID.
      # `@refund_request.transactionId = transactionId`
      # * `Tracking ID` - The tracking ID that was specified for this payment in the PayRequest message.
      # `@refund_request.trackingId = trackingId`
      @refund_request.payKey = "AP-5S482348KH512131U"

      # The currency code. You must specify the currency code that matches the currency code of the original payment unless you also specify the payment key.
      @refund_request.currencyCode = "USD"

      # Amount to refund from the receiver identified by email address
      @refund_request.receiverList.receiver[0].amount = 1.0

      # The receiver's email address
      @refund_request.receiverList.receiver[0].email  = "platfo_1255612361_per@gmail.com"

      # ##Make API call & get response
      @refund_response = @api.refund(@refund_request)

      # ##Access Response
      # ### Success Response

      if @refund_response.responseEnvelope.ack == "Success"
        #  Status of the refund. It is one of the following values:
        # 
        # * REFUNDED - Refund successfully completed
        # * REFUNDED_PENDING - Refund awaiting transfer of funds;
        # for example, a refund paid by eCheck.
        # * NOT_PAID - Payment was never made; therefore, it cannot
        # be refunded.
        # * ALREADY_REVERSED_OR_REFUNDED - Request rejected because
        # the refund was already made, or the payment was reversed
        # prior to this request.
        # * NO_API_ACCESS_TO_RECEIVER - Request cannot be completed
        # because you do not have third-party access from the
        # receiver to make the refund.
        # * REFUND_NOT_ALLOWED - Refund is not allowed.
        # * INSUFFICIENT_BALANCE - Request rejected because the
        # receiver from which the refund is to be paid does not
        # have sufficient funds or the funding source cannot be
        # used to make a refund.
        # * AMOUNT_EXCEEDS_REFUNDABLE - Request rejected because
        # you attempted to refund more than the remaining amount of the
        # payment; call the PaymentDetails API operation to
        # determine the amount already refunded.
        # * PREVIOUS_REFUND_PENDING - Request rejected because a
        # refund is currently pending for this part of the payment
        # * NOT_PROCESSED - Request rejected because it cannot be
        # processed at this time
        # * REFUND_ERROR - Request rejected because of an internal
        # error
        # * PREVIOUS_REFUND_ERROR - Request rejected because
        # another part of this refund caused an internal error.

        @refund_response.refundInfoList.refundInfo.each do |refund_info|
          @api.logger.info("RefundStatus : "+refund_info.refundStatus);
        end

        # ###Error Response
      else
        @api.logger.error(@refund_response.error[0].message)
      end
      @refund_response
    end
  end
end