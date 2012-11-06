require 'sinatra'
require 'json'
require "supermodel"

class Resource < SuperModel::Base
end

get '/resources' do
  Resource.all.to_json
end

  Test.find(params[:id].to_i).to_json
get '/resources/:id' do
    Resource.find(params[:id].to_i).to_json
end

post '/resources' do
end

get '/' do
  "Example service running"
end
