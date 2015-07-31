class UserMailer < ActionMailer::Base
  default from: "ziply@whiterabbit.is"
  #"#{request.protocol}#{request.host_with_port}"

  def user_order_received (transaction, protocol, host)
    @app_url = "#{protocol}#{host}"
    @user = transaction.job.customer
    @job = transaction.job
    mail(:to => @user.email,
         :subject => "Your order has been received!")
  end

  def confirm_driver(user, protocol, host, password)
    @app_url = "#{protocol}#{host}"
    @password = password
    @user = user
    @host = host
    @protocol = protocol
    mail(:to => @user.email, :subject => 'Welcome to Ziply')
  end

  def invite_complete(user, user_password)
    @user = user
    @user_password = user_password
    @host = default_url_options[:host]
    @url = "http://#{@host}/"
    mail(:to => user.email, :subject => "Here's Your Account Information")
  end

  def welcome_customer(user, protocol, host)
    @app_url = "#{protocol}#{host}"
    @user = user
    mail(:to => user.email, :subject => "Welcome to Ziply")
  end

  def new_job_open (job, drivers, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = job
    mail(:to => drivers.map { |driver| driver.email },
         :subject => "New Job Open in your area")
  end

  def job_accepted (job, driver, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = job
    @driver = driver
    mail(:to => @job.customer.email,
         :subject => "Your job has been accepted")
  end

  def job_picked (job, driver, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = job
    @driver = driver
    mail(:to => @job.customer.email,
         :subject => "Your job has been picked")
  end

  def job_delivered (job, driver, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = job
    @driver = driver
    mail(:to => @job.customer.email,
         :subject => "Your Job has been delivered")
  end

  def welcome_driver request
    @request = request
  end

  def file_claim(file_claim, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = file_claim.job
    @user = file_claim.user
    @file_claim = file_claim
    mail(:to => "super_admin@ziply.com",
         :subject => "New File Claim!")
  end

  def ziply_update(request, email, protocol, host)
    @app_url = "#{protocol}#{host}"
    @email = email
    mail(:to => @email,
         :subject => "Ziply driver update request!")
  end

  def new_message_from_driver(message, protocol, host)
    @app_url = "#{protocol}#{host}"
    @message = message
    if message.receiver.email.present?
      mail(:to => message.receiver.email,
           :subject => "New Message From Driver")
    end
  end

  def recipient_order (job, protocol, host)
    @app_url = "#{protocol}#{host}"
    @job = job
    @email = job.recipient_phone
    mail(:to => @email,
         :subject => "You have a new shipment being sent to you via Ziply.")

  end

end
