require 'spec_helper'
require 'adaptive_payments/execute_payment'

describe "AdaptivePayments" do
  it "make execute_payment request" do
    execute_payment      = AdaptivePayments::ExecutePayment.new
    response =  execute_payment.execute_payment
    response.response_envelope.ack.should eql "Success"
  end
end