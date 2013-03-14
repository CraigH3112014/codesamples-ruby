# # DoDirectPayment API
# The DoDirectPayment API Operation enables you to process a credit card payment.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/merchant-sdk/ruby)

require 'paypal-sdk-merchant'

module Merchant
  class DoDirectPayment
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def do_direct_payment
      
      # ##Build request object
      @do_direct_payment = @api.build_do_direct_payment({
        :DoDirectPaymentRequestDetails => {
          
          # How you want to obtain payment. When implementing parallel payments,
          # this field is required and must be set to `Order`. When implementing
          # digital goods, this field is required and must be set to `Sale`. If the
          # transaction does not include a one-time purchase, this field is
          # ignored. It is one of the following values:
          # 
          # * `Sale` - This is a final sale for which you are requesting payment
          # (default).
          # * `Authorization` - This payment is a basic authorization subject to
          # settlement with PayPal Authorization and Capture.
          # * `Order` - This payment is an order authorization subject to
          # settlement with PayPal Authorization and Capture.
          # `Note:
          # You cannot set this field to Sale in SetExpressCheckout request and
          # then change the value to Authorization or Order in the
          # DoExpressCheckoutPayment request. If you set the field to
          # Authorization or Order in SetExpressCheckout, you may set the field
          # to Sale.` 
          :PaymentAction => "Sale",
            
          # Information about the payment
          :PaymentDetails => {
            
            # Total cost of the transaction to the buyer. If shipping cost and tax
            # charges are known, include them in this value. If not, this value
            # should be the current sub-total of the order.
            # 
            # If the transaction includes one or more one-time purchases, this field must be equal to
            # the sum of the purchases. Set this field to 0 if the transaction does
            # not include a one-time purchase such as when you set up a billing
            # agreement for a recurring payment that is not immediately charged.
            # When the field is set to 0, purchase-specific fields are ignored.
            # 
            # * `Currency Code` - You must set the currencyID attribute to one of the
            # 3-character currency codes for any of the supported PayPal
            # currencies.
            # * `Amount`
            :OrderTotal => {
              :currencyID => "USD",
              :value => "1" },
              
            # Your URL for receiving Instant Payment Notification (IPN) about this transaction. If you do not specify this value in the request, the notification URL from your Merchant Profile is used, if one exists.
            :NotifyURL => "https://paypal-sdk-samples.herokuapp.com/merchant/ipn_notify",
              
            # `Address` to which the order is shipped
            :ShipToAddress => {
              
              # Person's name associated with this shipping address. It is required if using a shipping address.
              :Name => "John Doe",
                
              # Street Name
              :Street1 => "1 Main St",
                
              # City
              :CityName => "San Jose",
              
              # State
              :StateOrProvince => "CA",
              
              # Country
              :Country => "US",

              # Postal Code
              :PostalCode => "95131" } },
              
          # Information about the credit card to be charged.    
          :CreditCard => {
            
            # Type of credit card. For UK, only Maestro, MasterCard, Discover, and
            # Visa are allowable. For Canada, only MasterCard and Visa are
            # allowable and Interac debit cards are not supported. It is one of the
            # following values:
            # 
            # * Visa
            # * MasterCard
            # * Discover
            # * Amex
            # * Solo
            # * Switch
            # * Maestro: See note.
            # `Note:
            # If the credit card type is Maestro, you must set currencyId to GBP.
            # In addition, you must specify either StartMonth and StartYear or
            # IssueNumber.`
            :CreditCardType => "Visa",
              
            # Credit Card Number
            :CreditCardNumber => "4904202183894535",
              
            # Credit Card Expiration Month
            :ExpMonth => 12,
              
            # Credit Card Expiration Year
            :ExpYear => 2022,
              
            # CVV Number of the credit card
            :CVV2 => "962" } } })
      
      # ##Make API call & get response
      @do_direct_payment_response = @api.do_direct_payment(@do_direct_payment)
      
      # ##Access Response
      # ###Success Response
      
      if @do_direct_payment_response.Ack == "Success"

        # Unique identifier of the transaction
        @api.logger.info("Transaction ID : " + @do_direct_payment_response.TransactionID)

        # ###Error Response
      else
        @api.logger.error(@do_direct_payment_response.Errors[0].LongMessage)
      end
      @do_direct_payment_response
    end

  end
end