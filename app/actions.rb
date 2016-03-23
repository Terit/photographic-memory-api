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

# STUB for INSTAGRAM API
# [
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/c0.34.1080.1080/11917984_557334237763756_325491108_n.jpg?ig_cache_key=MTIxMjA1OTAyMDE5OTA0MzgxMw%3D%3D.2.c",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/11379853_1688415151420906_21464079_n.jpg?ig_cache_key=MTIxMjA1OTAyMTAxNjU5MzI1MA%3D%3D.2",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/10817906_1551248435172313_668916468_n.jpg?ig_cache_key=MTIxMjA1ODk1MjY3NjgyOTY1NQ%3D%3D.2",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/c0.94.1080.1080/924968_246569645687487_1363798838_n.jpg?ig_cache_key=MTIxMjA1ODg4MTQ5MTk0NzMwOQ%3D%3D.2.c",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/1390321_457974494396784_214208101_n.jpg?ig_cache_key=MTIxMjA1ODg3ODc4OTg3MzE3Nw%3D%3D.2",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e15/c0.79.640.640/1689861_1122488317802243_439255071_n.jpg?ig_cache_key=MTIxMjA1ODg3MDExNjE0NTY4OQ%3D%3D.2.c",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/12142589_1050098511702346_514842384_n.jpg?ig_cache_key=MTIxMjA1ODgzNjExODQ0MjU3OA%3D%3D.2",
# "https://scontent.cdninstagram.com/t51.2885-15/s150x150/e35/12797987_241679696177980_1068067467_n.jpg?ig_cache_key=MTIxMjA1ODc3NzA3MTg1MTYxOA%3D%3D.2"
# ]
