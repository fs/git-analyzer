class Repository < ActiveRecord::Base
  attr_accessible :timezone, :workday_start, :workday_end

  validates :url, :name, presence: true
  validate :workday

  def url=(value)
    write_attribute :url, value
    self.name = parse_name_from_url(value)
  end

  def status_text
    '' # TODO: determine status from analyze statistics
  end

  def to_param
    name.parameterize
  end

  private

  def parse_name_from_url(value)
    uri = URI value
    nodes = uri.path.split '/'
    "#{nodes[1]}-#{nodes[2]}"
  rescue
    "repo-#{self.class.count + 1}"
  end

  def workday
    errors.add(:workday, "day end should be after day start") if workday_start >= workday_end
  end
end
