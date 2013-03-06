require 'spec_helper'
require 'merchant/set_express_checkout'
require 'merchant/get_transaction_details'
require 'merchant/masspay'
require 'merchant/do_direct_payment'
require 'merchant/create_recurring_payments_profile'
require 'merchant/do_reference_transaction'
require 'merchant/get_balance'

describe "Merchant" do
  it "set_express_checkout" do
    set_express_checkout      = Merchant::SetExpressCheckout.new
    response =  set_express_checkout.set_express_checkout
    response.ack.should eql "Success"
  end
  it "get_transaction_details" do
    get_transaction_details      = Merchant::GetTransactionDetails.new
    response =  get_transaction_details.get_transaction_details
    response.ack.should eql "Success"
  end
  it "masspay" do
    masspay      = Merchant::Masspay.new
    response =  masspay.masspay
    response.ack.should eql "Success"
  end
  it "do_direct_payment" do
    do_direct_payment      = Merchant::DoDirectPayment.new
    response =  do_direct_payment.do_direct_payment
    response.ack.should eql "Success"
  end
  it "create_recurring_payments_profile" do
    create_recurring_payments_profile      = Merchant::CreateRecurringPaymentsProfile.new
    response =  create_recurring_payments_profile.create_recurring_payments_profile
    response.ack.should eql "Success"
  end
  it "do_reference_transaction" do
    do_reference_transaction      = Merchant::DoReferenceTransaction.new
    response =  do_reference_transaction.do_reference_transaction
    response.ack.should eql "Success"
  end
  it "get_balance" do
    get_balance      = Merchant::GetBalance.new
    response =  get_balance.get_balance
    response.ack.should eql "Success"
  end
end
