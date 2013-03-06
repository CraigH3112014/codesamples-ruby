require 'spec_helper'
require 'adaptive_accounts/create_account'

describe 'AdaptiveAccounts' do
  it 'create_account' do
    create_account      = AdaptiveAccounts::CreateAccount.new
    response =  create_account.create_personal_account
    response.response_envelope.ack.should eql "Success"
    response =  create_account.create_premier_account
        response.response_envelope.ack.should eql "Success"
    response =  create_account.create_business_account
        response.response_envelope.ack.should eql "Success"
  end

end