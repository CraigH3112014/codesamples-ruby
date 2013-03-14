# # MassPay API
# The MassPay API operation makes a payment to one or more PayPal account holders.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class Masspay
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def masspay

      # ##Build request object
      @mass_pay = @api.build_mass_pay({
        
        # How you identify the recipients of payments in this call to MassPay. It is one of the following values:
        # 
        # * EmailAddress
        # * UserID
        # * PhoneNumber
        :ReceiverType => "EmailAddress",
          
        # Details of each payment.
        # `Note:
        # A single MassPayRequest can include up to 250 MassPayItems.`
        :MassPayItem => [{
          :ReceiverEmail => "enduser_biz@gmail.com",
            
          # `Amount` for the payment
          :Amount => {
            
            # Currency ID
            :currencyID => "USD",
              
            # Amount
            :value => "3.00" } }] })
      
      # ##Make API call & get response
      @mass_pay_response = @api.mass_pay(@mass_pay)
      
      # ##Access Response
      # ###Success Response

      if @mass_pay_response.Ack == "Success"

        # ###Error Response
      else
        @api.logger.error(@mass_pay_response.Errors[0].LongMessage)
      end
      @mass_pay_response
    end
  end
end