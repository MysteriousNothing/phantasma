# frozen_string_literal: true

RSpec.describe Phantasma::API do
  it "should not find any deprecated endpoints" do
    expect(described_class.find_deprecated_endpoints).to eq([])
  end

  it "should not find any missing endpoint" do
    expect(described_class.find_missing_endpoints).to eq([])
  end
end
