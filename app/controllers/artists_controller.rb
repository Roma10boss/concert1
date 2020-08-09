class ArtistsController < ApplicationController
  get '/artists' do
    @artists = Artist.all
    erb :'/artists/artists'
  end

  post '/artists' do
    @artist = current_user.artists.new(name: params[:name].strip, bio: params[:bio])
    if @artist.save
      redirect to "/artists/#{@artist.slug}"
    else
      redirect to '/artists/new'
    end
  end

  get '/artists/new' do
    if logged_in?
      erb :'/artists/create_artist'
    else
      redirect to '/'
    end
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'/artists/show_artist'
  end

  get '/artists/:slug/edit' do
    @artist = Artist.find_by_slug(params[:slug])
    if logged_in? && current_user.artists.include?(@artist)
      erb :'/artists/edit_artist'
    else
      redirect to "/artists/#{@artist.slug}"
    end
  end

  patch '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    @artist.name = params[:name]
    @artist.bio = params[:bio]
    if logged_in? && current_user.artists.include?(@artist) && @artist.valid?
      @artist.save
      redirect to "/artists/#{@artist.slug}"
    else
      redirect to "/artists/#{@artist.slug}"
    end
  end

  delete '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    if logged_in? && current_user.artists.include?(@artist)
      @artist.concerts.each do |concert|
        concert.delete
      end
      @artist.delete
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/artists/#{@artist.slug}"
    end
  end
end
