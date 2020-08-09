class ConcertsController < ApplicationController

  get '/concerts/new' do
    if logged_in?
      erb :'/concerts/create_concert'
    else
      redirect to '/'
    end
  end

  post '/concerts' do
    @concert = Concert.new(artist: Artist.find_or_create_by(name: params[:artist][:name].strip, user_id: current_user.id),
                              location: params[:location].strip,
                              concert_date: Date.parse(params[:concert_date]),
                              description: params[:description].strip,
                              ticket_price: params[:ticket_price].to_f)
    if @concert.save && @concert.artist.valid?
      redirect to "/concerts/#{@concert.id}"
    else
      redirect to '/concerts/new'
    end
  end

  get '/concerts/:id' do
    @concert = Concert.find_by_id(params[:id])
    erb :'/concerts/show_concert'
  end

  get '/concerts/:id/edit' do
    @concert = Concert.find_by_id(params[:id])
    if logged_in? && current_user.concerts.include?(@concert)
      erb :'/concerts/edit_concert'
    else
      redirect to "/concerts/#{@concert.id}"
    end
  end

  patch '/concerts/:id' do
    @concert = Concert.find_by_id(params[:id])
    @concert.artist = Artist.find_or_create_by(name: params[:artist][:name].strip, user_id: current_user.id)
    @concert.location = params[:location].strip
    @concert.concert_date = Date.parse(params[:concert_date])
    @concert.description = params[:description].strip
    @concert.ticket_price = params[:ticket_price].to_f
    if logged_in? && current_user.concerts.include?(@concert)
      @concert.save
      redirect to "/concerts/#{@concert.id}"
    else
      redirect to "/concerts/#{@concert.id}"
    end
  end

  delete '/concerts/:id' do
    @concert = Concert.find_by_id(params[:id])
    if logged_in? && current_user.concerts.include?(@concert)
      @concert.delete
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/concerts/#{@concert.id}"
    end
  end
end
