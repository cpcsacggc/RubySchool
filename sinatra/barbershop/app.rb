require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
configure do
	$db = SQLite3::Database.new 'barbershop.db'
	$db.execute 'CREATE TABLE IF NOT EXISTS 
	"Users" 
	(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
		"username" TEXT, 
		"phone", TEXT,
		"datestamp" TEXT, 
		"barber" TEXT, 
		"color" TEXT
	);'
end

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
	erb :result
end

get '/showusers' do
  erb  "Hello World"

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
			:barber => 'Выберите Парекмахера',
			:color => 'Выберите цвет покраски волос'
		}

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

	$db.execute 'insert into Users 
	(
		username, 
		phone, 
		datestamp,
		barber, 
		color
	)
	values
	(
	?, ?, ?, ?, ?
	)', [@username, @phone, @datetime, @barber, @color]

	@title = "Ok"
	@message = "Username: #{@username}, Phone: #{@phone}, Date and Time: #{@datetime}, Barber: #{@barber}, Color: #{@color}"
	erb :message

end