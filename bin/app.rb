require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello World'
end

get '/hello/' do
    erb :hello_form
    #greeting = params[:greeting] || "Hi There"
    #erb :index, :locals => {'greeting' => greeting}
end

post '/hello/' do
  greeting = params[:greeting] || "Hi there"
  name = params[:name] || 'Nobody'

  erb :index, :locals => {'greeting' => greeting, 'name' => name}
end

get '/biteme/:name' do |x|
  "Bite me #{x}."
end

get '/splatty/*.*' do
  params['splat'][0]
end

get '/hola' do
  erb :hola
end

get '/looky/:name' do
  params.inspect
end

get '/passing/' do
  @name = 'Ben'
  erb :passing
end

get '/comment/' do
  erb :comment
end

post '/comment/' do
  @comment = params[:comment]
  erb :comment_post
end
