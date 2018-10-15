require_relative 'spec_helper'

describe 'Customer' do
  describe 'model' do
    it 'extends ActiveRecord::Base' do
      expect(Customer).to be < ActiveRecord::Base
    end
    it 'has a name' do
      expect(Customer.column_names).to include("name")
    end
    it 'has a lat(itude)' do
      expect(Customer.column_names).to include("lat")
    end
    it 'has a lon(gitude)' do
      expect(Customer.column_names).to include("lon")
    end
    it 'has many orders' do
      expect(Customer.reflect_on_association(:orders).macro).to eq(:has_many)
    end
    it 'has many reviews' do
      expect(Customer.reflect_on_association(:reviews).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'validates that name is present' do
      expect(Customer.new(name: nil, lat: 0, lon: 0).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: 0).valid?).to be true 
    end
    it 'validates that lat is present' do
      expect(Customer.new(name: "Mr. Name", lat: nil, lon: 0).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: 0).valid?).to be true 
    end
    it 'validates that lat >= -90' do
      expect(Customer.new(name: "Mr. Name", lat: -91, lon: 0).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: -90, lon: 0).valid?).to be true 
    end
    it 'validates that lat <= 90' do
      expect(Customer.new(name: "Mr. Name", lat: 91, lon: 0).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 90, lon: 0).valid?).to be true 
    end
    it 'validates that lon is present' do
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: nil).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: 0).valid?).to be true 
    end
    it 'validates that lon >= -180' do
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: -181).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: -180).valid?).to be true 
    end
    it 'validates that lon <= 180' do
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: 181).valid?).to be false
      expect(Customer.new(name: "Mr. Name", lat: 0, lon: 180).valid?).to be true 
    end
  end
end
