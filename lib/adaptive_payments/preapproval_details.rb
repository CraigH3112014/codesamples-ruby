# # PreapprovalDetails API
# Use the PreapprovalDetails API operation to obtain information about an agreement between you and a sender for making payments on the sender's behalf.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/adaptivepayments-sdk/ruby)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class PreapprovalDetails
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def preapproval_details
      # ##Build request object
      @preapproval_details_request = @api.build_preapproval_details()

      # A preapproval key that identifies the
      # preapproval for which you want to retrieve details. The preapproval
      # key is returned in the PreapprovalResponse message.
      @preapproval_details_request.preapprovalKey = "PA-2T305990ET0354039"

      # ##Make API call & get response
      @preapproval_details_response = @api.preapproval_details(@preapproval_details_request)

      # ##Access Response
      # ### Success Response

      if @preapproval_details_response.responseEnvelope.ack == "Success"

        # First date for which the preapproval is valid.
        @api.logger.info("Start Date : "); @api.logger.info(@preapproval_details_response.startingDate)

        # ###Error Response
      else
        @api.logger.error(@preapproval_details_response.error[0].message)
      end
      @preapproval_details_response
    end

  end

end