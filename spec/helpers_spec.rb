# frozen_string_literal: true

RSpec.describe Phantasma::Helpers do

  let(:method_name) { 'GetAccount' }
  let(:special_case) { 'GetValidator/{type}' }
  let(:special_case_output) { 'get_validator/{type}' }
  let(:snake_case_regex) { /^[a-z_\/{}]+$/ }

  describe 'API allowed methods camel case to_snake case' do
    Phantasma::API::ALLOWED_METHODS&.each do |method|
      it "should go trough allowed methods and snake case - #{method}" do
        camel_to_snake = described_class.camel_to_snake(method)
        expect(camel_to_snake).to match snake_case_regex
      end
    end

    it "should check if Swagger endpoints length ALLOWED_METHODS are same" do
      expect(described_class.test_api_endpoints&.kind_of?(Array)).to eq(true)
      expect(described_class.test_api_endpoints.length).to be > 1
      expect(described_class.test_api_endpoints.length).to eq(Phantasma::API::ALLOWED_METHODS.length)
    end

  end

  describe 'camel_to_snake' do
    it 'converts CamelCase to snake_case' do
      expect(described_class.camel_to_snake('CamelCase')).to eq('camel_case')
    end

    it 'Test special case in API' do
      method = described_class.camel_to_snake(special_case)
      expect(method).to eq(special_case_output)
      expect { method }.not_to raise_error
    end

    it 'Handles acronyms correctly' do
      expect(described_class.camel_to_snake('APITest')).to eq('api_test')
    end

    it 'Converts hyphens to underscores' do
      expect(described_class.camel_to_snake('hyphen-ated')).to eq('hyphen_ated')
    end

    it 'Handles mixed cases' do
      expect(described_class.camel_to_snake('MixedCASETest')).to eq('mixed_case_test')
    end

    it 'Does not modify strings that are already in snake_case' do
      expect(described_class.camel_to_snake('already_snake_case')).to eq('already_snake_case')
    end

    it 'Handles empty strings' do
      expect(described_class.camel_to_snake('')).to eq('')
    end

    it 'Handles nil input' do
      expect(described_class.camel_to_snake(nil)).to eq('')
    end

    it 'Fail covert to snake case' do
      expect(described_class.camel_to_snake(method_name)).not_to eq(method_name.upcase)
    end

  end

end
