# # DoCapture API
# Captures an authorized payment.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class DoCapture
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_capture

      # ##Build request object
      @do_capture = @api.build_do_capture({
        
        # Authorization identification number of the
        # payment you want to capture. This is the transaction ID returned from
        # DoExpressCheckoutPayment, DoDirectPayment, or CheckOut. For
        # point-of-sale transactions, this is the transaction ID returned by
        # the CheckOut call when the payment action is Authorization.
        :AuthorizationID => "2BL4337502215553K",
          
        # Amount to capture
        :Amount => {
          :currencyID => "USD",
          :value => "1.00" },
          
        # Indicates whether or not this is your last capture.
        # It is one of the following values:
        #  * Complete – This is the last capture you intend to make.
        #  * NotComplete – You intend to make additional captures.
        # `Note:
        # If Complete, any remaining amount of the original authorized
        # transaction is automatically voided and all remaining open
        # authorizations are voided.`
        :CompleteType => "Complete" })
      
      # ##Make API call & get response
      @do_capture_response = @api.do_capture(@do_capture)
      
      # ##Access Response
      # ###Success Response

      if @do_capture_response.Ack == "Success"

        # Authorization identification number
        @api.logger.info("Authorization ID : " +  @do_capture_response.DoCaptureResponseDetails.AuthorizationID)

        # ###Error Response
      else
        @api.logger.error(@do_capture_response.Errors[0].LongMessage)
      end
      @do_capture_response
    end
  end
end