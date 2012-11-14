require 'spec_helper'

#-----------------
# Uses stubs
# Requires Shoulda
#-----------------
describe User do
  let(:user) { build_stub(:user) }
  it { should validate_presence_of :email }
  it {
    create(:user)
    should validate_uniqueness_of :email
  }
end