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
	@arr1 = []
	@hh = {}
	@file = File.open("./public/barbershop.txt", "r")
	@file.each_line do |line|
		@ar2=[]
		@arr2 = line.strip
		@arr1 = @arr2.split(', ')
		@hh[@file.lineno] = @arr1
		#@hh.delete_if{|key, value| key == 1}
	end
	erb :result
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	# хеш
	hh = { 	:username => 'Введите имя',
			:phone => 'Введите телефон',
			:datetime => 'Введите дату и время',
		}

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

	#erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"
	#save data to file name
		f = File.open './public/barbershop.txt', 'a'

	f.write "#{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}\n"
	f.close


	@title = "Ok"
	@message = "Username: #{@username}, Phone: #{@phone}, Date and Time: #{@datetime}, Barber: #{@barber}, Color: #{@color}"
	erb :message

end
