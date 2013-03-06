# # Pay API
# Use the Pay API operation to transfer funds from a sender's PayPal account to one or more receivers' PayPal accounts. You can use the Pay API operation to make simple payments, chained payments, or parallel payments; these payments can be explicitly approved, preapproved, or implicitly approved.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class Pay
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def pay

      # ## Build request object
      @pay_request = @api.build_pay()

      # The action for this request. Possible values are:
      # 
      # * PAY - Use this option if you are not using the Pay request in
      # combination with ExecutePayment.
      # * CREATE - Use this option to set up the payment instructions with
      # SetPaymentOptions and then execute the payment at a later time with
      # the ExecutePayment.
      # * PAY_PRIMARY - For chained payments only, specify this value to delay
      # payments to the secondary receivers; only the payment to the primary
      # receiver is processed.
      @pay_request.actionType         = "PAY"

      # URL to redirect the sender's browser to after
      # canceling the approval for a payment; it is always required but only
      # used for payments that require approval (explicit payments)
      @pay_request.cancelUrl          = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/pay"

      # The code for the currency in which the payment is
      # made; you can specify only one currency, regardless of the number of
      # receivers
      @pay_request.currencyCode       = "USD"

      # The payer of PayPal fees. Allowable values are:
      # 
      # * SENDER - Sender pays all fees (for personal, implicit simple/parallel payments; do not use for chained or unilateral payments)
      # * PRIMARYRECEIVER - Primary receiver pays all fees (chained payments only)
      # * EACHRECEIVER - Each receiver pays their own fee (default, personal and unilateral payments)
      # * SECONDARYONLY - Secondary receivers pay all fees (use only for chained payments with one secondary receiver)
      @pay_request.feesPayer          = "SENDER"

      # The URL to which you want all IPN messages for this payment to be sent.
      @pay_request.ipnNotificationUrl = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/ipn_notify"

      # Amount to be paid to the receiver.
      @pay_request.receiverList.receiver[0].amount = 1.0

      # Receiver's email address. This address can be unregistered with paypal.com. If so, a receiver cannot claim the payment until a PayPal account is linked to the email address. The PayRequest must pass either an email address or a phone number.
      @pay_request.receiverList.receiver[0].email  = "platfo_1255612361_per@gmail.com"

      # The URL to which the sender's browser is redirected after approving a payment on paypal.com. Specify the URL with the HTTP or HTTPS designator.
      @pay_request.returnUrl          = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/pay"

      # ## Make API call & get response
      @pay_response = @api.pay(@pay_request)

      # ## Access Response
      # ### Success Response

      if @pay_response.responseEnvelope.ack == "Success"
        # Once you get success response, user has to redirect to PayPal
        # for the payment. Construct redirectURL as follows,
        # `redirectURL=https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey="
        # + @pay_response.payKey;`

        # The pay key, which is a token you use in other Adaptive
        # Payment APIs (such as the Refund Method) to identify this
        # payment. The pay key is valid for 3 hours; the payment must
        # be approved while the pay key is valid.
        @api.logger.info( @pay_response.payKey)

        # The status of the payment. Possible values are:
        # 
        # * CREATED - The payment request was received; funds will be transferred once the payment is approved
        # * COMPLETED - The payment was successful
        # * INCOMPLETE - Some transfers succeeded and some failed for a parallel payment or, for a delayed chained payment, secondary receivers have not been paid
        # * ERROR - The payment failed and all attempted transfers failed or all completed transfers were successfully reversed
        # * REVERSALERROR - One or more transfers failed when attempting to reverse a payment
        # * PROCESSING - The payment is in progress
        # * PENDING - The payment is awaiting processing
        @api.logger.info("Pay Key : " + @pay_response.paymentExecStatus)

        # ###Error Response
      else
        @api.logger.error( @pay_response.error[0].message)

      end
      @pay_response
    end
  end
end