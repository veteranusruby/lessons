# encoding: utf-8
require 'sinatra'

get '/london' do
  london_time = Time.now.utc
  "У Лондоні зараз: #{london_time}"
end
