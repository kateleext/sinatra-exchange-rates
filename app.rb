require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

key = ENV.fetch("EXCHANGE_RATE_KEY")
list_url = "https://api.exchangerate.host/list?access_key=" + key

get("/") do
  @currencies = JSON.parse(HTTP.get(list_url)).fetch("currencies").keys
  erb(:home)
end

get("/:currency_one") do
  @currency_one = params.fetch("currency_one")
  @currencies = JSON.parse(HTTP.get(list_url)).fetch("currencies").keys
  erb(:currency_one)
end

get("/:currency_one/:currency_two") do
  @currency_one = params.fetch("currency_one")
  @currency_two = params.fetch("currency_two")
  convert_url = "https://api.exchangerate.host/convert?from=#{@currency_one}&to=#{@currency_two}&amount=1&access_key=" + key
  @result = JSON.parse(HTTP.get(convert_url)).fetch("result")
  erb(:currency_two)
end
