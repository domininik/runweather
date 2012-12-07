require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'pry'
require 'httparty'

get '/' do
  erb :home
end

get '/cities/:name' do
  # DF FIXME temp. hack
  city = params[:name][4].ord == 243 ? 'Krakow' : params[:name]
  response = HTTParty.get('http://www.airqualitynow.eu/rss.php')
  data = response['rss']['channel']['item']
  item = data.select { |i| i['title'] == city }.first
  item ? item['description'] : 'no data :('
end
