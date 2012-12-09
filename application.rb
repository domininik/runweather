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
  if item
    text = item['description'].split(' and a background').first
    case text[/[0-9]+/].to_i
    when (0...25)
      "Absolutely, the air is super clean today in #{city}! :)"
    when (26...50)
      "Sure, the air is pretty clean today in #{city} :)"
    when (51...75)
      "Yes, you can, the air is not so bad today in #{city}."
    when (76...100)
      "Well, maybe just pause today, the air is pretty dirty today in #{city} :/"
    when (100...1000)
      "No way, bro, the air is extremely dirty today in #{city} :("
    else
      "Unfortunately we have no data for #{city} :("
    end
  else
    "Unfortunately we have no data for #{city} :("
  end
end
