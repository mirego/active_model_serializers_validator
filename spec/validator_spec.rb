require 'spec_helper'

describe ActiveModel::Serializer::Validator do
  describe :valid? do
    subject { ActiveModel::Serializer.new(OpenStruct.new(foo: 'bar')) }
    before { ActiveModel::Serializer.stub(:valid_against_schema?).and_return(stubbed_validation) }

    context 'with empty errors' do
      let(:stubbed_validation) { [] }
      it { should be_valid }
    end

    context 'with errors' do
      let(:stubbed_validation) { ['First error', 'Second error'] }
      it { should_not be_valid }
    end
  end

  describe :valid_against_schema? do
    before do
      try_remove_const(:ProductSerializer)

      ProductSerializer = Class.new(ActiveModel::Serializer) do
        self.root = false
        attributes :id, :name, :price, :tags
      end
    end

    subject { ActiveModel::Serializer.valid_against_schema?(product_schema, serializer) }
    let(:serializer) { ProductSerializer.new(serializable) }
    let(:schema) { product_schema }

    context 'without validaton errors' do
      let(:serializable) { OpenStruct.new(id: 4, name: "Widget", price: 1200, tags: %w(foo bar baz)) }
      it { should be_empty }
    end

    context 'with validaton errors' do
      let(:serializable) { OpenStruct.new(id: 4, price: 1200, tags: %w(foo bar baz)) }
      it { should_not be_empty }
      its(:length) { should eql 1 }
    end
  end

  describe :json_schema do
    subject { ProductSerializer.new(serializable) }
    let(:set_schema!) { ProductSerializer.json_schema schema_file }

    before do
      try_remove_const(:ProductSerializer)

      ProductSerializer = Class.new(ActiveModel::Serializer) do
        self.root = false
        attributes :id, :name, :price, :tags
      end
    end

    context 'with existing file' do
      let(:schema_file) { File.expand_path("../fixtures/product.jsonschema", __FILE__) }
      before { set_schema! }

      context 'with valid serializable' do
        let(:serializable) { OpenStruct.new(id: 4, name: "Widget", price: 1200, tags: %w(foo bar baz)) }
        it { should be_valid }
      end

      context 'with invalid serializable' do
        let(:serializable) { OpenStruct.new }
        it { should_not be_valid }
      end
    end

    context 'with unknown file as schema' do
      let(:schema_file) { File.expand_path("../fixtures/non-existing-file.jsonschema", __FILE__) }
      it { expect { set_schema! }.to raise_error ActiveModel::Serializer::Validator::InvalidSchemaError, 'Schema file does not exist.' }
    end

    context 'with a non-supported type as schema' do
      let(:schema_file) { true }
      it { expect { set_schema! }.to raise_error ActiveModel::Serializer::Validator::InvalidSchemaError, 'Schema must be a path to a file or a Hash.' }
    end
  end
end
