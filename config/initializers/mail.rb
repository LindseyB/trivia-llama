ActionMailer::Base.smtp_settings = {
	:tls => true,
	:address => "smtp.gmail.com",
	:port => "587",
	:domain => "churchof1337.com",
	:authentication => :plain,
	:user_name => "llama",
	:password => "1337hax"
}

