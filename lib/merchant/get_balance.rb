# # GetBalance API
# The GetBalance API Operation obtains the available balance for a PayPal account.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class GetBalance
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def get_balance

      # ##Build request object
      @get_balance = @api.build_get_balance({
        
        # Indicates whether to return all currencies. It is one of the
        # following values:
        # 
        # * 0 – Return only the balance for the primary currency holding.
        # * 1 – Return the balance for each currency holding.
        :ReturnAllCurrencies => "1" })
      
      # ##Make API call & get response
      @get_balance_response = @api.get_balance(@get_balance)
      
      # ##Access Response
      # ###Success Response

      if @get_balance_response.Ack == "Success"

        @get_balance_response.BalanceHoldings.each do |balance|
          
          # Available balance and associated currency code for each currency held, including the primary currency. The first currency is the primary currency.
          @api.logger.info("BalanceHoldings : " + balance.value + " " + balance.currencyID)
        end
        # ###Error Response
      else
        @api.logger.error(@get_balance_response.Errors[0].LongMessage)
      end
      @get_balance_response
    end

  end
end