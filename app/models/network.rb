class Network < ActiveRecord::Base
  attr_readonly :ip_address, :mask
  validates :ip_address, :presence => true
  validates :mask, :presence => true
  validates_uniqueness_of :ip_address, :scope => :mask
  belongs_to :project
  belongs_to :author, :class_name => 'User'
  has_many :hosts, :dependent => :destroy

  scope :like, lambda { |arg|
    if arg.present?
      pattern = "%#{arg.to_s.strip}%"
      where("LOWER(ip_address) LIKE LOWER(:p)", :p => pattern)
    end
  }
end
