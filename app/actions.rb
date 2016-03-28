post '/api/leaderboard' do
  tag = params[:tag] || 'popular'
  Leader.create(name: params[:name], hashtag: tag, score: params[:score].to_i)
  Leader.where(hashtag: tag).order(score: :desc).limit(10).to_json
end

get '/api/leaderboard/:tag' do
  # Leader.all.order(score: :desc).limit(10).to_json
  [
    { name: 'ART', hashtag: 'cats', score: 1000 },
    { name: 'ART', hashtag: 'cats', score: 1000 },
    { name: 'ART', hashtag: 'cats', score: 1000 },
    { name: 'ART', hashtag: 'cats', score: 1000 },
    { name: 'ART', hashtag: 'cats', score: 1000 }
  ].to_json
end

before do
  # @client = Instagram.client(access_token: session[:access_token])
end

get '/api/images/popular' do
  # @links = @client.media_popular
  #           .map(&:images)
  #           .map(&:thumbnail)
  #           .map(&:url)
  # @links.take(8).to_json
@links = [
  'http://localhost:3002/stub_images/cat1.jpg',
  'http://localhost:3002/stub_images/cat2.jpg',
  'http://localhost:3002/stub_images/cat3.jpg',
  'http://localhost:3002/stub_images/cat4.jpg',
  'http://localhost:3002/stub_images/cat5.jpg',
  'http://localhost:3002/stub_images/cat6.jpg',
  'http://localhost:3002/stub_images/cat7.jpg',
  'http://localhost:3002/stub_images/cat8.jpeg'
].to_json
end

get '/api/images/:tag' do
  # tag = @client.tag_search(params[:tag]).first
  # redirect '/api/images/popular' if tag.blank?
  # @links = @client.tag_recent_media(tag[:name])
  #           .map(&:images)
  #           .map(&:thumbnail)
  #           .map(&:url)
  # @links.take(8).to_json
@links = [
  'http://localhost:3002/stub_images/cat1.jpg',
  'http://localhost:3002/stub_images/cat2.jpg',
  'http://localhost:3002/stub_images/cat3.jpg',
  'http://localhost:3002/stub_images/cat4.jpg',
  'http://localhost:3002/stub_images/cat5.jpg',
  'http://localhost:3002/stub_images/cat6.jpg',
  'http://localhost:3002/stub_images/cat7.jpg',
  'http://localhost:3002/stub_images/cat8.jpeg'
].to_json
end
