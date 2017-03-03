class Sms_record < ActiveRecord::Base
  SMS_FORMAT = /\A[-+]?[0-9]*\.?[0-9]+\Z/

  validates :sender, :recipient, format: EMAIL_FORMAT, allow_nil: true
  validates :body, :secure_id, presence: true

  def sender
    sender
  end

  def recipient
    recipient
  end

  def to_param
    secure_id
  end
end
