# # GetAccessToken API
# Use the GetAccessToken API operation to obtain an access token for a set of permissions.
# This sample code uses Permissions Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-permissions'

module Permissions
  class GetAccessToken
    def initialize()
      @api = PayPal::SDK::Permissions::API.new
    end

    def get_access_token

      # ##Build request object
      @get_access_token_request = @api.build_get_access_token()
      
      # The request token from the response to RequestPermissions.
      @get_access_token_request.token    = "AAAAAAAXfKLzG4d4yivH"
      
      # The verification code returned in the redirect from PayPal to the
      # return URL after `RequestPermissions` call
      @get_access_token_request.verifier = "wqiqjhDjCfl.2FDVWVjaVQ"
      
      # ##Make API call & get response
      @get_access_token_response = @api.get_access_token(@get_access_token_request)
      
      # ##Access Response
      @get_access_token_response.responseEnvelope
      @get_access_token_response.error
      # ### Success Response

      if @get_access_token_response.responseEnvelope.ack == "Success"

        # The access token that identifies a set of permissions.
        @api.logger.info("Access Token : " + @get_access_token_response.token)
        
        # The secret associated with the access token.
        @api.logger.info("Token Secret: " + @get_access_token_response.tokenSecret)

        # ###Error Response
      else
        @api.logger.error(@get_access_token_response.error[0].message)
      end
      @get_access_token_response
    end
  end
end