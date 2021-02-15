require "sinatra"

get '/' do
  "Hello Foo Bar"
end

get '/contacts' do
  @title = "Contacts"
  @message = "Hello all! Phone me now."
  erb :message
end

get '/faq' do
  @title = "FAQ about our products"
  @message = "It`s FAQ"
  erb :message
end

get '/none-page' do
  under_construction
end

def under_construction
  @title = "Under Construction"
  @message = "This page is under construction."
  erb :message
end