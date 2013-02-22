class Repository
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :url, :name, :attributes
  attr_accessor :time_zone, :workday_start

  validates :url, presence: true

  def initialize(attributes = {})
    @attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def url=(value)
    @url = value
    @name = parse_name_from_url
  end

  def status_text
    ''
  end

  def to_param
    @name.parameterize
  end

  private

  def parse_name_from_url
    uri = URI @url
    nodes = uri.path.split '/'
    "#{nodes[1]} - #{nodes[2]}"
  rescue
    'no name!'
  end
end
