# # SetExpressCheckout API
# The SetExpressCheckout API operation initiates an Express Checkout transaction.
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class SetExpressCheckout
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def set_express_checkout

      # ##Build request object
      @set_express_checkout = @api.build_set_express_checkout({
          :SetExpressCheckoutRequestDetails => {
            
            # URL to which the buyer's browser is returned after choosing to pay
            # with PayPal. For digital goods, you must add JavaScript to this page
            # to close the in-context experience.
            # `Note:
            # PayPal recommends that the value be the final review page on which
            # the buyer confirms the order and payment or billing agreement.`
            :ReturnURL => "https://paypal-sdk-samples.herokuapp.com/merchant/do_express_checkout_payment",
              
            # URL to which the buyer is returned if the buyer does not approve the
            # use of PayPal to pay you. For digital goods, you must add JavaScript
            # to this page to close the in-context experience.
            # `Note:
            # PayPal recommends that the value be the original page on which the
            # buyer chose to pay with PayPal or establish a billing agreement.`
            :CancelURL => "https://paypal-sdk-samples.herokuapp.com/merchant/set_express_checkout",
            
            # Information about the payment
            :PaymentDetails => [{
              
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
              # * `Currency ID` - You must set the currencyID attribute to one of the
              # 3-character currency codes for any of the supported PayPal
              # currencies.
              # * `Amount`
              :OrderTotal => {
                :currencyID => "USD",
                :value => "8.27" },
                
              # Sum of cost of all items in this order. For digital goods, this field is required.
              # 
              # * `Currency ID` - You must set the currencyID attribute to one of the
              # 3-character currency codes for any of the supported PayPal
              # currencies.
              # * `Amount`
              :ItemTotal => {
                :currencyID => "USD",
                :value => "5.27" },
              
              # Total shipping costs for this order.   
              # 
              # * `Currency ID` - You must set the currencyID attribute to one of the
              # 3-character currency codes for any of the supported PayPal
              # currencies.
              # * `Amount`            
              :ShippingTotal => {
                :currencyID => "USD",
                :value => "3.0" },
               
              # Sum of tax for all items in this order.   
              # 
              # * `Currency ID` - You must set the currencyID attribute to one of the
              # 3-character currency codes for any of the supported PayPal
              # currencies.
              # * `Amount`
              :TaxTotal => {
                :currencyID => "USD",
                :value => "0" },
                
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
                :PostalCode => "95131" },
                  
              # Details about each individual item included in the order.  
              :PaymentDetailsItem => [{
                
                # Item name. This field is required when you pass a value for ItemCategory.
                :Name => "Item Name",
                  
                # Item quantity. This field is required when you pass a value for ItemCategory. For digital goods (ItemCategory=Digital), this field is required.
                :Quantity => 1,
                
                # Cost of item. This field is required when you pass a value for ItemCategory.
                :Amount => {
                  :currencyID => "USD",
                  :value => "5.27" },
                  
                # Indicates whether an item is digital or physical. For digital goods, this field is required and must be set to Digital. It is one of the following values:
                # 
                # * Digital
                # * Physical
                :ItemCategory => "Physical" }],
                
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
              :PaymentAction => "Sale" }] } })

      # ##Make API call & get response
      @set_express_checkout_response = @api.set_express_checkout(@set_express_checkout)

      # ##Access Response
      # ### Success Response
      
      if @set_express_checkout_response.Ack == "Success"

        # ### Redirecting to PayPal for authorization
        # Once you get the "Success" response, needs to authorise the
        # transaction by making buyer to login into PayPal. For that,
        # need to construct redirect url using EC token from response.
        # For example,
        # `redirectURL="https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="+ @set_express_checkout_response.Token`
        
        # Express Checkout Token
        @api.logger.info("EC Token : " +  @set_express_checkout_response.Token)
     
      # ###Error Response
      else
        @api.logger.error(@set_express_checkout_response.Errors[0].LongMessage)
      end
      @set_express_checkout_response
    end
  end
end