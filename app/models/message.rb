class Message < ActiveRecord::Base
  EMAIL_FORMAT = /\A(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*(\+[_a-z0-9-]+)?@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})\z/i
  SMS_FORMAT = /\A[-+]?[0-9]*\.?[0-9]+\Z/
  
  validates :sender_email, :recipient_email, format: EMAIL_FORMAT, allow_nil: true
  validates :sender_phone, :recipient_phone, format: SMS_FORMAT, allow_nil: true
  validates :body, :secure_id, presence: true

  def sender
    sender_email || sender_phone
  end

  def recipient
    recipient_email || recipient_phone
  end

  def to_param
    secure_id
  end
  
end
