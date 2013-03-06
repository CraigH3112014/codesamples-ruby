require 'spec_helper'
require 'invoice/send_invoice'

describe "Invoice" do
  it "send_invoice" do
    send_invoice = Invoice::SendInvoice.new
    response = send_invoice.send_invoice
    response.response_envelope.ack.should eql "Success"
  end
end