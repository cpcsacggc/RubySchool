require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

get '/result' do
	@file = File.open("./public/barbershop.txt", "r")
	erb :result
end

post '/visit' do
	# recieve data from the form and save to variables
	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:datetime]
	@barber = params[:barber]

	@title = "Thank you"
	@message = "Уважаемый #{@username}, мы ждём вас #{@date_time}"

	#save data to file name
	f = File.open './public/barbershop.txt', 'a'
	f.write "User: #{@username}, phone: #{@phone}, date and time: #{@date_time}, Barber: #{@barber}.\n"
	f.close
	erb :message
end
