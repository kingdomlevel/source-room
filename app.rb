require('pry')
require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/exhibition.rb')
require_relative('./admin_controller.rb')

also_reload('./models/*')

@current_exhibitions = nil

# index
get '/' do
    @current_exhibitions = Exhibition.all()[0..2]
    erb(:index)
end

get '/exhibitions' do
  @exhibitions = Exhibition.all()
  erb(:exhibitions)
end

get '/exhibitions/:id' do
  @exhibition = Exhibition.find(params[:id])
  erb(:exhibition)
end

get '/artists' do
  @artists = Artist.all()
  erb(:artists)
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  erb(:artist)
end
