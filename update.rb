require 'twitter'
require 'httparty'
require 'nokogiri'

twitter = Twitter::REST::Client.new do |config|
  config.consumer_key        = "wLd3x7tCG9ct6onqweMiAbI6J"
  config.consumer_secret     = "Pg6r2so9pkhMrSGUfDdbsAuwjTforiu9ec3tesRtEvljO0U6jL"
  config.access_token        = "1070363957532205056-XEDLnjvvxH0XtCy8fCVPyS1lQBHjAL"
  config.access_token_secret = "zfgDP9tphlzTabdI76wHgN9SvNoTkJvhoZr2U0DZlAaDl"
end

latest_tweets = twitter.user_timeline("hugedanny")
previous_tweets = latest_tweets.map do |tweet|
  if tweet.urls.any?
    tweet.urls[0].expanded_url
  end
end

rss_harle = HTTParty.get("https://www.google.com/alerts/feeds/17701930348868718501/3772213104170934806").to_s
doc_harle = Nokogiri::XML(rss_harle)

doc_harle.css("entry").take(3).each do |entry|
  harle_title = entry.css("title").text
  harle_link = entry.css("link").map {|link| link['href']}.join

  unless previous_tweets.include?(harle_link)
   twitter.update("#{harle_title} #{harle_link}")
 end
end

rss_welbz = HTTParty.get("https://www.google.com/alerts/feeds/17701930348868718501/6987484678791758019").to_s
doc_welbz = Nokogiri::XML(rss_welbz)

doc_welbz.css("entry").take(3).each do |entry|
  welbz_title = entry.css("title").text
  welbz_link = entry.css("link").map {|link| link['href']}.join

  unless previous_tweets.include?(welbz_link)
   twitter.update("#{welbz_title} #{welbz_link}")
 end
end
