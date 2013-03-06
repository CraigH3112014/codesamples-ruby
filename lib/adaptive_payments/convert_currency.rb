# # ConvertCurrency API
# Use the ConvertCurrency API operation to request the current foreign exchange (FX) rate for a specific amount and currency.
# This sample code uses AdaptivePayments Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-adaptivepayments'

module AdaptivePayments
  class ConvertCurrency
    def initialize()
      @api = PayPal::SDK::AdaptivePayments::API.new
    end

    def convert_currency

      # ##Build request object
      @convert_currency_request = @api.build_convert_currency()

      # `CurrencyCodeType` - The currency code. Allowable values are:
      # 
      #  * Australian Dollar - AUD
      #  * Brazilian Real - BRL
      #  `Note:
      #  The Real is supported as a payment currency and currency balance only
      #  for Brazilian PayPal accounts.`
      #  * Canadian Dollar - CAD
      #  * Czech Koruna - CZK
      #  * Danish Krone - DKK
      #  * Euro - EUR
      #  * Hong Kong Dollar - HKD
      #  * Hungarian Forint - HUF
      #  * Israeli New Sheqel - ILS
      #  * Japanese Yen - JPY
      #  * Malaysian Ringgit - MYR
      #  `Note:
      #  The Ringgit is supported as a payment currency and currency balance
      #  only for Malaysian PayPal accounts.`
      #  * Mexican Peso - MXN
      #  * Norwegian Krone - NOK
      #  * New Zealand Dollar - NZD
      #  * Philippine Peso - PHP
      #  * Polish Zloty - PLN
      #  * Pound Sterling - GBP
      #  * Singapore Dollar - SGD
      #  * Swedish Krona - SEK
      #  * Swiss Franc - CHF
      #  * Taiwan New Dollar - TWD
      #  * Thai Baht - THB
      #  * Turkish Lira - TRY
      #  `Note:
      #  The Turkish Lira is supported as a payment currency and currency
      #  balance only for Turkish PayPal accounts.`
      #  * U.S. Dollar - USD
      @convert_currency_request.baseAmountList.currency[0].code   = "USD"

      # Amount to be converted
      @convert_currency_request.baseAmountList.currency[0].amount = 2.0

      # `CurrencyCodeType` - The currency code. Allowable values are:
      # 
      #  * Australian Dollar - AUD
      #  * Brazilian Real - BRL
      #  `Note:
      #  The Real is supported as a payment currency and currency balance only
      #  for Brazilian PayPal accounts.`
      #  * Canadian Dollar - CAD
      #  * Czech Koruna - CZK
      #  * Danish Krone - DKK
      #  * Euro - EUR
      #  * Hong Kong Dollar - HKD
      #  * Hungarian Forint - HUF
      #  * Israeli New Sheqel - ILS
      #  * Japanese Yen - JPY
      #  * Malaysian Ringgit - MYR
      #  `Note:
      #  The Ringgit is supported as a payment currency and currency balance
      #  only for Malaysian PayPal accounts.`
      #  * Mexican Peso - MXN
      #  * Norwegian Krone - NOK
      #  * New Zealand Dollar - NZD
      #  * Philippine Peso - PHP
      #  * Polish Zloty - PLN
      #  * Pound Sterling - GBP
      #  * Singapore Dollar - SGD
      #  * Swedish Krona - SEK
      #  * Swiss Franc - CHF
      #  * Taiwan New Dollar - TWD
      #  * Thai Baht - THB
      #  * Turkish Lira - TRY
      #  `Note:
      #  The Turkish Lira is supported as a payment currency and currency
      #  balance only for Turkish PayPal accounts.`
      #  * U.S. Dollar - USD
      @convert_currency_request.convertToCurrencyList.currencyCode = ["GBP"]

      # ##Make API call & get response
      @convert_currency_response = @api.convert_currency(@convert_currency_request)

      # ##Access Response
      # ### Success Response

      if @convert_currency_response.responseEnvelope.ack == "Success"
        @convert_currency_response.responseEnvelope
        @convert_currency_response.estimatedAmountTable.currencyConversionList.each do |currency|
          @api.logger.info("Amount to be Converted : "+ currency.baseAmount.amount.to_s+" "+currency.baseAmount.code)
          currency.currencyList.currency.each do |converted_currency|
            @api.logger.info("Converted Amount: "+ converted_currency.amount.to_s+" "+converted_currency.code)

          end
        end

        # ###Error Response
      else
        @api.logger.error(@convert_currency_response.error[0].message)
      end
      @convert_currency_response
    end
  end
end