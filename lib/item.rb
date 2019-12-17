require 'csv'

class Item

  @@items = []

  attr_reader :id, :name, :description, :unit_price, :merchant_id

  def initialize(item_info)
    @description = item_info[:description]
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @unit_price = item_info[:unit_price].to_i
    @merchant_id = item_info[:merchant_id].to_i
  end

  def self.create_items(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)

    @@items = csv.map do |row|
       Item.new(row)
    end
  end

  def self.find(id)
    @@items.find do |item|
      item.id == id
    end
  end

  def self.where(merchant_id)
    @@items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
