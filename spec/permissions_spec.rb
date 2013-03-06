require 'spec_helper'
require 'permissions/request_permissions'

describe "Permissions" do
  it "request_permissions" do
    request_permissions = Permissions::RequestPermissions.new
    response = request_permissions.request_permissions
    response.response_envelope.ack.should eql "Success"
  end
end