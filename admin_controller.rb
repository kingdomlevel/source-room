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

# new exhibition
get '/admin/exhibitions/new' do
    @artists = Artist.all()
    erb (:"admin/new_exhibition")
end

# save new exhibition
post '/admin/exhibitions' do
    new_exhibition = Exhibition.new(params)
    new_exhibition.save()
    redirect to '/admin/exhibitions'
end

# edit exhibition
get '/admin/exhibitions/:id/edit' do
    @exhibition = Exhibition.find(params[:id])
    @artists = Artist.all()
    erb (:"admin/edit_exhibition")
end

# save changes to exhibition
post '/admin/exhibitions/:id' do
    exhibition = Exhibition.new(params)
    exhibition.update()
    redirect to '/admin/exhibitions'
end

# delete exhibition
post '/admin/exhibitions/:id/delete' do
    exhibition = Exhibition.new(params)
    exhibition.delete()
    redirect to '/admin/exhibitions'
end