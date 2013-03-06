require 'spec_helper'
require 'permissions/get_access_token'

describe "Permissions" do
  it "get_access_token" do
    get_access_token = Permissions::GetAccessToken.new
    response = get_access_token.get_access_token
    response.response_envelope.ack.should eql "Success"
  end
end