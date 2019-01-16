require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello World IIIIIIIIII'
end

get '/hello/' do
    greeting = params[:greeting] || "Hi There"
    erb :index, :locals => {'greeting' => greeting}

end

get '/biteme/:name' do |x|
  "Bite me #{x}."
end

get '/splatty/*.*' do
  params['splat'][0]
end
