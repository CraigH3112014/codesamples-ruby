# # CreateRecurringPaymentsProfile API
# The CreateRecurringPaymentsProfile API operation creates a recurring
# payments profile.
# You must invoke the CreateRecurringPaymentsProfile API operation for each
# profile you want to create. The API operation creates a profile and an
# associated billing agreement.
# `Note:
# There is a one-to-one correspondence between billing agreements and
# recurring payments profiles. To associate a recurring payments profile
# with its billing agreement, you must ensure that the description in the
# recurring payments profile matches the description of a billing
# agreement. For version 54.0 and later, use SetExpressCheckout to initiate
# creation of a billing agreement.`
# This sample code uses Merchant Ruby SDK to make API call. You can download the SDK [here](https://www.x.com/developers/paypal/documentation-tools/paypal-sdk-index)

require 'paypal-sdk-merchant'

module Merchant
  class CreateRecurringPaymentsProfile
    def initialize()
      @api = PayPal::SDK::Merchant::API.new
    end

    def create_recurring_payments_profile
      
      # ##Build request object
      @create_recurring_payments_profile = @api.build_create_recurring_payments_profile({
        :CreateRecurringPaymentsProfileRequestDetails => {
          
          # Either EC token or a credit card number is required.If you include
          # both token and credit card number, the token is used and credit card number is
          # ignored
          # In case of setting EC token,
          # `:Token => "EC-5KH01765D1724703R"`
          # A timestamped token, the value of which was returned in the response
          # to the first call to SetExpressCheckout. Call
          # CreateRecurringPaymentsProfile once for each billing
          # agreement included in SetExpressCheckout request and use the same
          # token for each call. Each CreateRecurringPaymentsProfile request
          # creates a single recurring payments profile.
          # `Note:
          # Tokens expire after approximately 3 hours.`
      
          # Credit card information for recurring payments using direct payments.
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
              
            # CVV number of the credit card
            :CVV2 => "962" },
              
          # You can include up to 10 recurring payments profiles per request. The
          # order of the profile details must match the order of the billing
          # agreement details specified in the SetExpressCheckout request
          :RecurringPaymentsProfileDetails => {
            
            # The date when billing for this profile begins.
            # `Note:
            # The profile may take up to 24 hours for activation.`
            :BillingStartDate => "2022-10-12T00:00:00+00:00" },
              
          # Describes the recurring payments schedule, including the regular
          # payment period, whether there is a trial period, and the number of
          # payments that can fail before a profile is suspended  
          :ScheduleDetails => {
            
            # Description of the recurring payment.
            # `Note:
            # You must ensure that this field matches the corresponding billing
            # agreement description included in the SetExpressCheckout request.`
            :Description => "Welcome to the world of shopping where you get everything",
              
            # Regular payment period for this schedule
            :PaymentPeriod => {
              
              # Unit for billing during this subscription period. It is one of the
              # following values:
              # 
              # * Day
              # * Week
              # * SemiMonth
              # * Month
              # * Year
              # For SemiMonth, billing is done on the 1st and 15th of each month.
              # `Note:
              # The combination of BillingPeriod and BillingFrequency cannot exceed
              # one year.`
              :BillingPeriod => "Day",
                
              # Number of billing periods that make up one billing cycle.
              # The combination of billing frequency and billing period must be less
              # than or equal to one year. For example, if the billing cycle is
              # Month, the maximum value for billing frequency is 12. Similarly, if
              # the billing cycle is Week, the maximum value for billing frequency is
              # 52.
              :BillingFrequency => 10,
              
              # Billing amount for each billing cycle during this payment period.
              # This amount does not include shipping and tax amounts.
              # `Note:
              # All amounts in the CreateRecurringPaymentsProfile request must have
              # the same currency.`
              :Amount => {
                :currencyID => "USD",
                :value => "5" } } } } })
      
      # ##Make API call & get response
      @create_recurring_payments_profile_response = @api.create_recurring_payments_profile(@create_recurring_payments_profile)
      
      # ##Access Response
      # ###Success Response
      @create_recurring_payments_profile_response.Timestamp
      @create_recurring_payments_profile_response.Ack
      @create_recurring_payments_profile_response.CorrelationID
      @create_recurring_payments_profile_response.Version
      @create_recurring_payments_profile_response.Build
      @create_recurring_payments_profile_response.CreateRecurringPaymentsProfileResponseDetails

      if @create_recurring_payments_profile_response.ack == "Success"
        
        #A unique identifier for future reference to the details of this recurring payment.
        @api.logger.info("Profile ID : " +  @create_recurring_payments_profile_response.CreateRecurringPaymentsProfileResponseDetails.ProfileID)
      
      # ###Error Response    
      else
        @api.logger.error(@create_recurring_payments_profile_response.Errors[0].LongMessage)
      end
      @create_recurring_payments_profile_response
    end
  end

end