class MessageCreator
  attr_accessor :message, :sms_record

  def initialize(params)
    @message = Message.new(allowed_params(params))
  end

  def ok?
    save_message && send_notification
  end

  private

  def send_notification
	unless valid_email?(@message.sender) && valid_email?(@message.recipient)
		if valid_num?(p@message.sender) && valid_num?(@message.recipient)
		  begin
			@client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
			@sms_record = @client.messages.create(
			  :body => @message.secure_id,
			  :to => message.recipient,
			  :from => message.sender
			)
		  rescue Twilio::REST::RequestError => e
			puts e.message
		  end			
		end
    else
		MessageMailer.secure_message(@message).deliver_now
	end
  end

  def save_message
    @message.secure_id = SecureRandom.urlsafe_base64(25)
    @message.save
  end

  def allowed_params(params)  
	if valid_email?(params[:message][:sender]) && valid_email?(params[:message][:recipient])
		{ sender_email: params[:message][:sender], 
			recipient_email: params[:message][:recipient], 
			body: params[:message][:body]
		}
	elsif valid_num?(params[:message][:sender]) && valid_num?(params[:message][:recipient])
		{ body: params[:message][:body], 
			sender_phone: params[:message][:sender], 
			recipient_phone: params[:message][:recipient] 
		}	
	end

  end
  
  def valid_num?(str)
    true if Float(str) rescue false
  end
  
  def valid_email?(str)
    return str =~ /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end

end
