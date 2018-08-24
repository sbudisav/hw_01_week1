require 'http'

puts "What subreddit do you want the posts to?"
subreddit = gets.chomp
response = HTTP.get("https://www.reddit.com/r/#{subreddit}/.json")

if response.code != 200
  puts "Not a subreddit"
end

reddit_data = response.parse
reddit_post = reddit_data["data"]["children"]

subs = reddit_post[0]["data"]["subreddit_subscribers"]
puts "Cool! the #{subreddit} subreddit has #{subs} subscribers"

puts "How many posts would you like to see?"
index = gets.chomp.to_i
if index > 25 
  index = 25
  puts "Limit of 25"
end

position = 0
index.times do 
  puts position + 1
  puts reddit_post[position]["data"]["title"]
  position += 1
end



puts "would you like to read some comments? y/n"
answer = gets.chomp.downcase
if answer == "y"

  puts "What position post from 1-25"
  post_index = gets.chomp.to_i
  if post_index > 25 
    puts "limit of 25, going to 25th post"
    post_index = 25
  end
  puts "Here is the highest rated comment"

  get_to_comment_url = reddit_post[post_index]["data"]["permalink"]
  comment_response = HTTP.get("https://www.reddit.com#{get_to_comment_url}.json")
  print "https://www.reddit.com#{get_to_comment_url}.json/"
  comment_data = comment_response.parse
  comment = comment_data[1]["data"]["children"][0]["data"]["body"]
  puts ""
  puts comment

else 
  puts "Program done"
end