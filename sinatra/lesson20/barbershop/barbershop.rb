require 'sinatra'

get '/' do
  erb :index
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
  f = File.open 'users.txt', 'a'
  f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@date_time}.\n"
  f.close

  erb :message
end