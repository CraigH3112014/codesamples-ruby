require 'spec_helper'
require 'adaptive_payments/pay'
require 'adaptive_payments/payment_details'
require 'adaptive_payments/preapproval_details'
require 'adaptive_payments/preapproval'
require 'adaptive_payments/refund'
require 'adaptive_payments/convert_currency'
require 'adaptive_payments/set_payment_options'
require 'adaptive_payments/get_payment_options'

describe "AdaptivePayments" do
  it "make pay request" do
    pay      = AdaptivePayments::Pay.new
    response = pay.pay
    response.response_envelope.ack.should eql "Success"
  end

  it "make payment_details request" do
    payment_details      = AdaptivePayments::PaymentDetails.new
    response =  payment_details.payment_details
    response.response_envelope.ack.should eql "Success"
  end

  it "make preapproval request" do
    preapproval      = AdaptivePayments::Preapproval.new
    response =  preapproval.preapproval
    response.response_envelope.ack.should eql "Success"
  end

  it "make preapproval_details request" do
    preapproval_details      = AdaptivePayments::PreapprovalDetails.new
    response =  preapproval_details.preapproval_details
    response.response_envelope.ack.should eql "Success"
  end

  it "make refund request" do
    refund      = AdaptivePayments::Refund.new
    response =  refund.refund
    response.response_envelope.ack.should eql "Success"
  end

  it "make convert_currency request" do
    convert_currency      = AdaptivePayments::ConvertCurrency.new
    response =  convert_currency.convert_currency
    response.response_envelope.ack.should eql "Success"
  end

  it "make set_payment_options request" do
    set_payment_options      = AdaptivePayments::SetPaymentOptions.new
    response =  set_payment_options.set_payment_options
    response.response_envelope.ack.should eql "Success"
  end

  it "make get_payment_options request" do
    get_payment_options      = AdaptivePayments::GetPaymentOptions.new
    response =  get_payment_options.get_payment_options
    response.response_envelope.ack.should eql "Success"
  end

end