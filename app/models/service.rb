class Service < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  has_attached_file :image,
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV["aws_access_key_id"],
      secret_access_key: ENV["aws_secret_access_key"],
      bucket: "fiverrish-production"
    },
    s3_region: "ap-south-1",
    path: "image/:attachment/:id/:style/:filename",
    url: ":s3_domain_url",
    styles: { 
      small: "100x100#",
      medium: "220x220#"
     },
    default_url: "400x400.png"

  validates :title, presence: true, length: {maximum:80}
  validates :description, presence: true, length: {maximum:1200}
  validates :price, presence: true
  validates :delivery_time, presence: false
  validates :revisions, presence: false
  validates :requirements, presence: true, length: {maximum:450}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :orders
end
