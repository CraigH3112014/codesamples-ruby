require 'spec_helper'
require 'invoice/create_invoice'
require 'invoice/create_and_send_invoice'
require 'invoice/search_invoices'
require 'invoice/get_invoice_details'
require 'invoice/update_invoice'

describe "Invoice" do
  it "create_invoice" do
    create_invoice = Invoice::CreateInvoice.new
    response = create_invoice.create_invoice
    response.response_envelope.ack.should eql "Success"
  end
  it "create_and_send_invoice" do
    create_and_send_invoice = Invoice::CreateAndSendInvoice.new
    response = create_and_send_invoice.create_and_send_invoice
    response.response_envelope.ack.should eql "Success"
  end
  it "update_invoice" do
    update_invoice = Invoice::UpdateInvoice.new
    response = update_invoice.update_invoice
    response.response_envelope.ack.should eql "Success"
  end
  it "search_invoices" do
    search_invoices = Invoice::SearchInvoices.new
    response = search_invoices.search_invoices
    response.response_envelope.ack.should eql "Success"
  end
  it "get_invoice_details" do
    get_invoice_details = Invoice::GetInvoiceDetails.new
    response = get_invoice_details.get_invoice_details
    response.response_envelope.ack.should eql "Success"
  end
end