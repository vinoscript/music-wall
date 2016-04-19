enable :sessions

# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
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
    redirect '/users'
  else
    erb :'users/register'
  end
end

get '/users/login' do
  erb :'users/login'
end

get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @tracks_by_author = Track.where(author: @track.author).where.not(id: params[:id])
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end



