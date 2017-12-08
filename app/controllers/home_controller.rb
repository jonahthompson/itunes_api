class HomeController < ApplicationController
  def index
  	@songs = APIS::Itunes.new.get_songs_by_artist('michael jackson')
  end
end
