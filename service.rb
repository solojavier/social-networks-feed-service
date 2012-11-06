require 'sinatra'
require 'json'
require "supermodel"

class Resource < SuperModel::Base
end

get '/resources' do
  Resource.all.to_json
end

get '/resources/:id' do
  begin
    Resource.find(params[:id].to_i).to_json
  rescue
    404
  end
end

post '/resources' do
  return 422 if params.has_key?('invalid_attribute')

  resource = Resource.new(params)

  if resource.save
    resource.to_json
  else
    500
  end
end

get '/' do
  "Example service running"
end
