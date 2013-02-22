class Repository
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :name, :attributes, :records
  attr_accessor :url, :time_zone, :workday_start

  validates :url, presence: true

  def self.field(name)
    define_method(name) { @attributes[name] }
    define_method("#{name}=") {|value| @attributes[name] = value }
  end

  def initialize(attributes = {})
    @attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
