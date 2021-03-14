require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to(:sender) }
  it { is_expected.to have_many(:recipients) }
  it { is_expected.to have_many(:users).through(:recipients) }

  it { is_expected.to validate_presence_of(:content) }
end
