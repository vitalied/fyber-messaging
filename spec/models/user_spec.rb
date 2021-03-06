require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  it { is_expected.to have_many(:recipients) }
  it { is_expected.to have_many(:messages).through(:recipients) }

  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }
end
