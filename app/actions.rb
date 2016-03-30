# Allow preflight CORS headers to be set
options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"

  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  200
end

post '/api/leaderboard/new' do
  tag = params[:tag]
  puts params
  leader = Leader.create(name: params[:name], hashtag: tag, score: params[:score].to_i)
  leaders = Leader.where(hashtag: tag).order(score: :desc).pluck(:id)
  { rank: (leaders.index(leader.id) + 1) }.to_json
end

get '/api/leaderboard/:tag' do
  puts params
  Leader.where(hashtag: params[:tag]).order(score: :desc).limit(10).to_json
  # [
  #   { name: 'ART', hashtag: 'cats', score: 1000 },
  #   { name: 'ART', hashtag: 'cats', score: 1000 },
  #   { name: 'ART', hashtag: 'cats', score: 1000 },
  #   { name: 'ART', hashtag: 'cats', score: 1000 },
  #   { name: 'ART', hashtag: 'cats', score: 1000 }
  # ].to_json
end

get '/api/images/popular' do
  @client = Instagram.client(access_token: session[:access_token])
  @links = @client.media_popular
            .map(&:images)
            .map(&:thumbnail)
            .map(&:url)
  @links.take(8).to_json
end

get '/api/images/:tag' do
  @client = Instagram.client(access_token: session[:access_token])
  tag = @client.tag_search(params[:tag]).first
  redirect '/api/images/popular' if tag.blank?
  @links = @client.tag_recent_media(tag[:name])
            .map(&:images)
            .map(&:thumbnail)
            .map(&:url)
  @links.take(8).to_json
# @links = [
#   'http://localhost:3002/stub_images/cat1.jpg',
#   'http://localhost:3002/stub_images/cat2.jpg',
#   'http://localhost:3002/stub_images/cat3.jpg',
#   'http://localhost:3002/stub_images/cat4.jpg',
#   'http://localhost:3002/stub_images/cat5.jpg',
#   'http://localhost:3002/stub_images/cat6.jpg',
#   'http://localhost:3002/stub_images/cat7.jpg',
#   'http://localhost:3002/stub_images/cat8.jpeg'
# ].to_json
end
