require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it { is_expected.to belong_to(:message) }
  it { is_expected.to belong_to(:user) }
end
