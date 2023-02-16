class User < ApplicationRecord
  # belongs_to :bank
  has_many :banks
  has_many :accounts
  has_many :loans
  has_many :transactions, through: :accounts
  has_many :shares
  has_many :stocks, through: :shares
  belongs_to :banks, class_name: "User", optional: true
  validates :Aadhaar_card, length: { is: 12 }
  validates :Aadhaar_card, presence: true
  has_secure_password
  after_save :create_push_notification



  
  def create_push_notification
    PushNotification.create(user_id: self.id, push_notificable_type: 'User', push_notificable_id: self.id, remarks: 'succefully sign-up', notify_type: 'sign-up')
  end
end

