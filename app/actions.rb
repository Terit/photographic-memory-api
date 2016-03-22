post '/leaderboard' do
  if params[:tag] == ''
    params[:tag] = 'popular'
  end
  Leader.create name: params[:name],hashtag: params[:tag],score: params[:score].to_i
  redirect '/leaderboard'
end

get '/leaderboard' do
  @tag = 'leaderboard'
  @leaders = Leader.all.order(score: :desc).limit(10)
  erb :leaderboard
end

before do
  @client = Instagram.client(access_token: session[:access_token])
end

get '/api/images/popular' do
  @links = @client.media_popular
            .map(&:images)
            .map(&:thumbnail)
            .map(&:url)
  @links.take(8).to_json
end

get '/api/images/:tag' do
  tag = @client.tag_search(params[:tag]).first
  redirect '/api/images/popular' if tag.blank?
  @links = @client.tag_recent_media(tag[:name])
            .map(&:images)
            .map(&:thumbnail)
            .map(&:url)
  @links.take(8).to_json
end
