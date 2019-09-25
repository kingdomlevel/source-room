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
