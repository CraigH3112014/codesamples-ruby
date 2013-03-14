# # CreateAccount API
# The CreateAccount API operation enables you to create a PayPal account on behalf of a third party.
# This sample code uses AdaptiveAccounts Ruby SDK to make API call. You can download the SDK [here](https://github.com/paypal/sdk-packages/tree/gh-pages/adaptiveaccounts-sdk/ruby)

require 'paypal-sdk-adaptiveaccounts'

module AdaptiveAccounts
  class CreateAccount
    def initialize()
      @api = PayPal::SDK::AdaptiveAccounts::API.new
    end

    # ## Create Personal Account
    def create_personal_account

      # ##Build request object
      @create_account_request  = @api.build_create_account()

      # The type of account to be created. Allowable values are:
      # 
      # * Personal - Personal account
      # * Premier - Premier account
      # * Business - Business account
      @create_account_request.accountType            = "Personal"

      # Salutation of the account or payment card holder.
      @create_account_request.name.salutation = "Mr."

      # First name of the account or payment card holder.
      @create_account_request.name.firstName  = "Bonzop"

      # Middle name of the account or payment card holder.
      @create_account_request.name.middleName = "Simore"

      # Last name of the account or payment card holder.
      @create_account_request.name.lastName   = "Zaius"

      # The street address
      @create_account_request.address.line1       = "1968 Ape Way"

      # The city
      @create_account_request.address.city        = "Austin"

      # The state
      @create_account_request.address.state       = "TX"

      # The Zip Code
      @create_account_request.address.postalCode  = "78750"

      # The country code
      @create_account_request.address.countryCode = "US"

      # Phone Number to be associated with the account.
      @create_account_request.contactPhoneNumber     = "5126914160"

      # The three letter code for the currency to be associated with the account.
      @create_account_request.currencyCode           = "USD"

      # The code of the country to be associated with the account.
      @create_account_request.citizenshipCountryCode = "US"

      # he code indicating the language to be
      # associated with the account.
      # What value is allowed depends on the country code passed in the
      # countryCode parameter for the address.
      # For Example: United States (US) - en_US
      @create_account_request.preferredLanguageCode  = "en_US"

      # The URL to post instant payment notification (IPN) messages to
      # regarding account creation. This URL supersedes the IPN notification
      # URL set in the merchant profile.
      @create_account_request.notificationURL        = "https://paypal-sdk-samples.herokuapp.com/adaptive_accounts/ipn_notify"

      # Email address of person for whom the PayPal account is created.
      @create_account_request.emailAddress           = "newEmailAddress@paypal.com"

      # This attribute determines whether a key or a URL is returned for the
      # redirect URL. Allowable value(s) currently supported:
      # `Web` - Returns a URL
      @create_account_request.registrationType       = "Web"

      # The URL to which the business redirects the PayPal user for PayPal account setup completion
      @create_account_request.createAccountWebOptions.returnUrl = "https://paypal-sdk-samples.herokuapp.com/adaptive_accounts/create_account"
      @create_account_response=make_api_call;
      @create_account_response
    end

    # ## Create PremierAccount
    # Needs to set all the above parameters mentioned in personal account
    # creation, but account type needs to be `premier`.
    def create_premier_account
      # The type of account to be created. Allowable values are:
      # 
      # * Personal - Personal account
      # * Premier - Premier account
      # * Business - Business account
      @create_account_request.accountType            = "Premier"
      @create_account_response=make_api_call;
      @create_account_response
    end

    # ## Create BusinessAccount
    # Needs to set all the above parameters mentioned in personal account
    # creation, but account type needs to be `business`.
    def create_business_account

      # The type of account to be created. Allowable values are:
      # 
      # * Personal - Personal account
      # * Premier - Premier account
      # * Business - Business account
      @create_account_request.accountType            = "Business"

      # The name of the business for which the PayPal account is created.
      @create_account_request.businessInfo.businessName                = "Toy Shop"

      # The street address
      @create_account_request.businessInfo.businessAddress.line1       = "1968 Ape Way"

      # The city
      @create_account_request.businessInfo.businessAddress.city        = "Austin"

      # The state
      @create_account_request.businessInfo.businessAddress.state       = "TX"

      # The zip code
      @create_account_request.businessInfo.businessAddress.postalCode  = "78750"

      # The country code
      @create_account_request.businessInfo.businessAddress.countryCode = "US"

      # Contact Phone Number
      @create_account_request.businessInfo.workPhone                   = "5126914161"

      # The category code for the business. state in which the business was
      # established. Required unless you specify both category and
      # subcategory. PayPal uses the industry standard Merchant Category
      # Codes.
      @create_account_request.businessInfo.merchantCategoryCode        = 1520

      # Required for US accounts
      @create_account_request.businessInfo.customerServicePhone        = "5126914162"

      # The email address for the customer service department of the
      # business.
      @create_account_request.businessInfo.customerServiceEmail        = "customercare@toy.com"

      # The date of establishment for the business. Optional for France
      # business accounts and required for business accounts in the following
      # countries: United States, United Kingdom, Canada, Germany, Spain,
      # Italy, Netherlands, Czech Republic, Sweden, and Denmark. Format needs
      # to be `YYYY-MM-DD`
      @create_account_request.businessInfo.dateOfEstablishment         = "2011-12-21"

      # The type of the business for which the PayPal account is created.
      # Allowable values are:
      # 
      # * CORPORATION
      # * GOVERNMENT
      # * INDIVIDUAL
      # * NONPROFIT
      # * PARTNERSHIP
      # * PROPRIETORSHIP
      @create_account_request.businessInfo.businessType                = "INDIVIDUAL"

      # The average price per transaction. Required for all countries except
      # Japan and Australia.
      @create_account_request.businessInfo.averagePrice                = 34.0

      # The average monthly transaction volume of the business for which the
      # PayPal account is created. Required for all countries except Japan
      # and Australia.
      @create_account_request.businessInfo.averageMonthlyVolume        = 24.0

      # The percentage of online sales for the business from 0 through 100.
      # Required for business accounts in the following countries: United
      # States, Canada, United Kingdom, France, Czech Republic, New Zealand,
      # Switzerland, and Israel.
      @create_account_request.businessInfo.percentageRevenueFromOnline = 30

      # The venue type for sales. Required for business accounts in all
      # countries except Czech Republic and Australia. Allowable values are:
      # 
      # * WEB
      # * EBAY
      # * OTHER_MARKETPLACE
      # * OTHER
      @create_account_request.businessInfo.salesVenue                  = ["OTHER"]

      # A description of the sales venue. Required if salesVenue is OTHER for all countries except Czech Republic and Australia.
      @create_account_request.businessInfo.salesVenueDesc              = "Other"
      @create_account_response=make_api_call;
      @create_account_response
    end

    def make_api_call()
      # ##Make API call & get response
      @create_account_response = @api.create_account(@create_account_request)

      # ##Access Response
      # ### Success Response

      if @create_account_response.responseEnvelope.ack == "Success"

        #  ### Redirection to PayPal
        # Once you get the success response, user needs to redirect to
        # PayPal to enter password for the created account. For that,
        # you have to use the redirect URL from the response, like
        #  @create_account_response.redirectURL. Using this url,
        # redirects the user to PayPal.
        
        # A unique key that identifies the account that was created.
        @api.logger.info("CreateAccountKey : " + @create_account_response.createAccountKey)

        # ###Error Response
      else
        @api.logger.error(@create_account_response.error[0].message)
      end
      @create_account_response
    end
  end
end