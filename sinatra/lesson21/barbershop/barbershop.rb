require 'sinatra'

get '/' do
  erb :index
end
get '/result' do
  @file = File.open("./public/users.txt","r")
  erb :result
  # @file.close - с этим у меня не работает, перенёс в erb
end

# спросим Имя, номер телефона и дату, когда придёт клиент.
post '/' do
  # user_name, phone, date_time
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]

  @title = "Thank you!"
  @message = "Уважаемый #{@user_name}, мы ждём вас #{@date_time}"

  # запишем в файл то, что ввёл клиент
  f = File.open './public/users.txt', 'a'
  f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@date_time}.\n"
  f.close

  erb :message
end
get '/admin' do
  erb :admin
end

post '/admin' do
  @login = params[:login]
  @password = params[:password]

  # проверим логин и пароль, и пускаем внутрь или нет:
  if @login == 'admin' && @password == '12345'
    @file = File.open("./public/users.txt","r")
    erb :watch_result
    # @file.close - должно быть, но тогда не работает. указал в erb
  else
    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
    erb :admin
  end
end