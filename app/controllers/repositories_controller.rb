class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
   @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
       req.params['client_id'] = 'c0885faf7af7a22d7108'
       req.params['client_secret'] = '3d6cda358babbd5c47c108b1af161ab9f1775e7d'
       req.params['q'] = params[:query]
     end
     body = JSON.parse(@resp.body)
     if @resp.success?
       @results = body["response"]["items"]
     else
       @error = body["meta"]["errorDetail"]
     end

   rescue Faraday::ConnectionFailed
     @error = "There was a timeout. Please try again."
   end
   render 'search'
  end
end
