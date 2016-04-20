enable :sessions

# before do
#   @user = User.find(session[:user_id]) || nil
#   # if session[:user_id]
#   #   @user = User.find(session[:user_id])
#   # end
# end

helpers do

  def current_user
    if session[:user_id] && session[:user_id] != ""
      User.find(session[:user_id])
    # else
    #   nil
    end
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

# TRACKS Section
get '/tracks' do
  @tracks = Track.all
  @ordered_tracks = Track.joins("LEFT JOIN votes on tracks.id = votes.track_id").order("sum(votes.score) DESC").group("tracks.id")
  # @vote_score = Vote.where(track_id: @track.id).sum("score")
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url],
    # user: current_user
    user_id: current_user.id
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @other_tracks_by_user = Track.where(user_id: @track.user_id).where.not(id: params[:id])
  @vote_score = Vote.where(track_id: @track.id).sum("score")
  erb :'tracks/show'
end

# USERS section
get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/register' do
  @user = User.new
  erb :'users/register'
end

post '/users' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/users'
  else
    erb :'users/register'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  user = User.find_by(email: params[:email])
    if user.password == params[:password]
      session[:user_id] = user.id
      # @logged_in = session[:user_id]
      redirect '/users/details'
    else
      erb :'users/login'
    end
end

get '/users/logout' do
  erb :'users/logout'
end

post '/users/logout' do
    session[:user_id] = nil
    redirect '/users/logout'
end

get '/users/details' do
  erb :'users/details'
end

# VOTE section

post '/vote' do
  puts params.inspect
  # params[:song] has track id
  if params[:vote] == "Upvote"
    vote = Vote.new(track_id: params[:song], user_id: current_user, score: 1)
    vote.save
  elsif params[:vote] == "Downvote"
    vote = Vote.new(track_id: params[:song], user_id: current_user, score: -1)
    vote.save
  end
  redirect back
end






