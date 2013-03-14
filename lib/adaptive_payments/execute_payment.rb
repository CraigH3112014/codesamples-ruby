# # ExecutePayment API
# The ExecutePayment API operation lets you execute a payment set up with the Pay API operation with the actionType CREATE. To pay receivers identified in the Pay call, set the pay key from the PayResponse message in the ExecutePaymentRequest message.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/adaptivepayments-sdk/ruby)
require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class ExecutePayment
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def execute_payment
      # ##Build request object
      @execute_payment_request = @api.build_execute_payment()

      # The pay key that identifies the payment for which you
      # want to set payment options. This is the pay key returned in the
      # PayResponse message. Action Type in PayRequest must be `CREATE`and must set `Senderemail`
      @execute_payment_request.payKey = "AP-9V106802XE514350K"

      # ##Make API call & get response
      @execute_payment_response = @api.execute_payment(@execute_payment_request)

      # ##Access Response
      # ### Success Response

      if @execute_payment_response.responseEnvelope.ack == "Success"

        # The status of the payment. Possible values are:
        # 
        # * CREATED - The payment request was received; funds will be
        # transferred once the payment is approved
        # * COMPLETED - The payment was successful
        # * INCOMPLETE - Some transfers succeeded and some failed for a
        # parallel payment
        # * ERROR - The payment failed and all attempted transfers
        # failed
        # or all completed transfers were successfully reversed
        # * REVERSALERROR - One or more transfers failed when
        # attempting
        # to reverse a payment
        @api.logger.info("Payment Execution Status : " + @execute_payment_response.paymentExecStatus)
        
        # ###Error Response
      else
        @api.logger.error(@execute_payment_response.error[0].message)
      end
      @execute_payment_response
    end

  end

end