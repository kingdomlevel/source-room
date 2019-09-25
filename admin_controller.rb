require('pry')
require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/exhibition.rb')
require_relative('./models/artist.rb')

also_reload('./models/*')


##### ARTISTS
# admin index
get '/admin' do
    erb (:"admin/index")
end

# manage artists
get '/admin/artists' do
    @artists = Artist.all()
    erb (:"admin/manage_artists")
end

# new artist
get '/admin/artists/new' do
    erb (:"admin/new_artist")
end

# save new artist
post '/admin/artists' do
    new_artist = Artist.new(params)
    new_artist.save()
    redirect to '/admin/artists'
end

# edit artist
get '/admin/artists/:id/edit' do
    @artist = Artist.find(params[:id])
    erb (:"admin/edit_artist")
end

# save changes to artist
post '/admin/artists/:id' do
    artist = Artist.new(params)
    artist.update()
    redirect to '/admin/artists'
end

# delete artist
post '/admin/artists/:id/delete' do
    artist = Artist.new(params)
    artist.delete()
    redirect to '/admin/artists'
end


####### EXHIBITIONS
# manage exhibitions
get '/admin/exhibitions' do
    @exhibitions = Exhibition.all()
    erb (:"admin/manage_exhibitions")
end
