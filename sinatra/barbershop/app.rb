require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers
	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'insert into Barbers (name) values (?)',[barber]
		end	
	end
end

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
	"Users" 
	(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
		"username" TEXT, 
		"phone", TEXT,
		"datestamp" TEXT, 
		"barber" TEXT, 
		"color" TEXT
	)'
	
	db.execute 'CREATE TABLE IF NOT EXISTS 
	"Barbers" 
	(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
		"name" TEXT 
	)'

	seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/showusers' do
	db = get_db
 	@results = db.execute 'Select * from Users ORDER BY id DESC'
 	erb :showusers
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
	db = get_db
	db.execute 'insert into Users 
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