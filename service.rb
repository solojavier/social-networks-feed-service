require 'sinatra'
require 'json'
require "supermodel"

class Test < SuperModel::Base
end

get '/objects' do
  Test.all.to_json
end

get '/objects/:id' do
  Test.find(params[:id].to_i).to_json
end

post '/objects' do
  Test.create(name: 'test').to_json
end

get '/' do
  "Example service running"
end
