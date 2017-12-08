require 'net/http'
require 'json'

class APIS::Itunes
	def initialize
		@base_uri = "https://itunes.apple.com/"
	end

	def get_songs_by_artist(artist, options = {})
		results = uri_call({term: artist, entity: 'song'}.merge(options))
		results.map do |track|
			{trackName: track["trackName"], trackId: track["trackId"]}
		end
	end

	def get_movies_with_term(term, options = {})
		results = uri_call({term: term, entity: 'movie'}.merge(options))
		results.map do |movie|
			{trackName: movie["trackName"], shortDescription: movie["shortDescription"] }
		end
	end

	def get_ebooks_by_author(author, options = {})
		results = uri_call({term: author, entity: 'ebook'}.merge(options))
		results.map do |ebook|
			{title: ebook["trackCensoredName"], description: ebook["description"]}
		end
	end

	def get_all_by_artist(artist)

	end

private

	def uri_call(options = {})
		q_params = URI.encode_www_form(options)
		uri = URI(@base_uri + "search?" + q_params)
		JSON.parse(Net::HTTP.get(uri))["results"]
	end

end
