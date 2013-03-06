# # Preapproval API
# Use the Preapproval API operation to set up an agreement between yourself
# and a sender for making payments on the sender's behalf. You set up a
# preapprovals for a specific maximum amount over a specific period of time
# and, optionally, by any of the following constraints:
# 
# * the number of payments
# * a maximum per-payment amount
# * a specific day of the week or the month
# * whether or not a PIN is required for each payment request.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class Preapproval
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def preapproval

      # ##Build request object
      @preapproval_request = @api.build_preapproval()

      # URL to redirect the sender's browser to after canceling the preapproval
      @preapproval_request.cancelUrl          = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/preapproval"

      # The code for the currency in which the payment is made; you can specify only one currency, regardless of the number of receivers
      @preapproval_request.currencyCode       = "USD"

      # URL to redirect the sender's browser to after the sender has logged into PayPal and confirmed the preapproval
      @preapproval_request.returnUrl          = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/preapproval"

      # The URL to which you want all IPN messages for this preapproval to be sent.
      # This URL supersedes the IPN notification URL in your profile
      @preapproval_request.ipnNotificationUrl = "https://paypal-sdk-samples.herokuapp.com/adaptive_payments/ipn_notify"

      # First date for which the preapproval is valid. It cannot be before today's date or after the ending date.
      @preapproval_request.startingDate       = "2015-10-10T00:00:00+00:00"

      # ##Make API call & get response
      @preapproval_response = @api.preapproval(@preapproval_request)

      # ##Access Response
      # ### Success Response

      if @preapproval_response.responseEnvelope.ack == "Success"

        # Once you get success response, user has to redirect to PayPal
        # to preapprove the payment. Construct redirectURL as follows,
        # `redirectURL=https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-preapproval&preapprovalkey="
        # + @preapproval_response.preapprovalKey;`

        # A preapproval key that identifies the preapproval requested.
        # You can use this key in other Adaptive Payment requests to
        # identify this preapproval.
        @api.logger.info("Preapproval Key : " + @preapproval_response.preapprovalKey)

        # ###Error Response
      else
        @api.logger.error(@preapproval_response.error[0].message)
      end
      @preapproval_response
    end
  end
  
end