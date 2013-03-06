require 'spec_helper'
require 'merchant/get_express_checkout'
require 'merchant/do_express_checkout'
require 'merchant/do_authorization'
require 'merchant/do_reauthorization'
require 'merchant/do_capture'
require 'merchant/do_void'
require 'merchant/transaction_search'
require 'merchant/refund_transaction'

describe "Merchant" do
  it "get_express_checkout" do
    get_express_checkout = Merchant::GetExpressCheckout::new
    response = get_express_checkout.get_express_checkout
    response.ack.should eql "Success"
  end
  it "do_express_checkout" do
    do_express_checkout = Merchant::DoExpressCheckout::new
    response = do_express_checkout.do_express_checkout
    response.ack.should eql "Success"
  end
  it "do_authorization" do
    do_authorization = Merchant::DoAuthorization::new
    response = do_authorization.do_authorization
    response.ack.should eql "Success"
  end
  it "do_reauthorization" do
    do_reauthorization = Merchant::DoReauthorization::new
    response = do_reauthorization.do_reauthorization
    response.ack.should eql "Success"
  end
  it "do_capture" do
    do_capture = Merchant::DoCapture::new
    response = do_capture.do_capture
    response.ack.should eql "Success"
  end
  it "do_void" do
    do_void = Merchant::DoVoid::new
    response = do_void.do_void
    response.ack.should eql "Success"
  end
  it "refund_transaction" do
    refund_transaction = Merchant::RefundTransaction::new
    response = refund_transaction.refund_transaction
    response.ack.should eql "Success"
  end
  it "transaction_search" do
    transaction_search = Merchant::TransactionSearch::new
    response = transaction_search.transaction_search
    response.ack.should eql "Success"
  end
end

