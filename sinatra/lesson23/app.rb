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

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	#save data to file name
	f = File.open './public/barbershop.txt', 'a'
	f.write "User: #{@username}, phone: #{@phone}, date and time: #{@date_time}, Barber: #{@barber}, Color: #{@color}\n"
	f.close


	@title = "Ok"
	@message = "Username: #{@username}, Phone: #{@phone}, Date and Time: #{@datetime}, Barber: #{@barber}, Color: #{@color}"
	erb :message

end
