require 'spec_helper'

describe "kele endpoints" do

  it "initializes user credentials" do

    email = ENV['EMAIL']
    password = ENV['PASS']
    kele_client = Kele.new(email, password)
    kele_client.auth_token

    expect(kele_client.auth_token).not_to be_nil
  end




end
