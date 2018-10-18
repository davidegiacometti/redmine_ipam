class Host < ActiveRecord::Base
  attr_readonly :ip_address
  validates :ip_address, presence: true
  validates :network_id, presence: true
  validates_uniqueness_of :ip_address
  belongs_to :network
  belongs_to :project
  belongs_to :author, class_name: 'User'

  scope :like, lambda { |arg|
    if arg.present?
      pattern = "%#{arg.to_s.strip}%"
      where("LOWER(ip_address) LIKE LOWER(:p)", :p => pattern)
    end
  }

  def scan
    self.last_scan = DateTime.now
    if Net::Ping::External.new(self.ip_address).ping?
      self.status = 1
      self.hostname = Resolv.getname(self.ip_address) rescue ''
    else
      self.status = 0
    end
    self.save!
  end
end
