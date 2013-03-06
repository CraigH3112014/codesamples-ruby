# # RequestPermissions API
# Use the RequestPermissions API operation to request permissions to execute API operations on a PayPal account holder's behalf.
# This sample code uses Permissions Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-permissions'

module Permissions
  class RequestPermissions
    def initialize()
      @api = PayPal::SDK::Permissions::API.new
    end

    def request_permissions

      # ##Build request object
      @request_permissions_request = @api.build_request_permissions()
      
      # `Scope`, which can take at least 1 of the following permission
      # categories:
      # 
      # * EXPRESS_CHECKOUT
      # * DIRECT_PAYMENT
      # * AUTH_CAPTURE
      # * AIR_TRAVEL
      # * TRANSACTION_SEARCH
      # * RECURRING_PAYMENTS
      # * ACCOUNT_BALANCE
      # * ENCRYPTED_WEBSITE_PAYMENTS
      # * REFUND
      # * BILLING_AGREEMENT
      # * REFERENCE_TRANSACTION
      # * MASS_PAY
      # * TRANSACTION_DETAILS
      # * NON_REFERENCED_CREDIT
      # * SETTLEMENT_CONSOLIDATION
      # * SETTLEMENT_REPORTING
      # * BUTTON_MANAGER
      # * MANAGE_PENDING_TRANSACTION_STATUS
      # * RECURRING_PAYMENT_REPORT
      # * EXTENDED_PRO_PROCESSING_REPORT
      # * EXCEPTION_PROCESSING_REPORT
      # * ACCOUNT_MANAGEMENT_PERMISSION
      # * INVOICING
      # * ACCESS_BASIC_PERSONAL_DATA
      # * ACCESS_ADVANCED_PERSONAL_DATA
      @request_permissions_request.scope    = ["EXPRESS_CHECKOUT","INVOICING"]
        
      # Your callback function that specifies actions to take
      # after the account holder grants or denies the request.
      @request_permissions_request.callback = "https://paypal-sdk-samples.herokuapp.com/permissions/get_access_token"

      # ##Make API call & get response
      @request_permissions_response = @api.request_permissions(@request_permissions_request)

      # ##Access Response
      @request_permissions_response.responseEnvelope
     
      # ### Success Response

      if @request_permissions_response.responseEnvelope.ack == "Success"

        # ###Redirecting to PayPal
        # Once you get the success response, user needs to redirect to
        # paypal to authorize. Construct the `redirectUrl` as follows,
        # `redirectURL=https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_grant-permission&request_token="+ @request_permissions_response.token`
        # Once you are done with authorization, you will be returning
        # back to `callback` url mentioned in your request. While
        # returning, PayPal will send two parameters in request:
        # 
        # * `request_token`
        # * `token_verifier`
        # You have to use these values in `GetAccessToken` API call to
        # generate `AccessToken` and `TokenSecret`
        
        # A token from PayPal that enables the request to obtain permissions.
        @api.logger.info("Request_Token : " +  @request_permissions_response.token)

        # ###Error Response
      else
        @api.logger.error(@request_permissions_response.error[0].message)
      end
      @request_permissions_response
    end
  end
end