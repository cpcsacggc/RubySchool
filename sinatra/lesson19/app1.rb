require "sinatra"
get '/' do
	erb :index
end

post '/' do
	@login = params[:login]
	@password = params[:pass]
	if @login == 'admin' && password == '12345'
		erb :welcome
	else
		@if_stop = "STOP!"
		erb :index
	end
end
