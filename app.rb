require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/exhibition.rb')

also_reload('./models/*')

@current_exhibitions = Exhibition.all()[0..2]

get '/' do # index
    erb(:index)
end