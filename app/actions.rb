enable :sessions

# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
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
    url: params[:url]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @tracks_by_author = Track.where(author: @track.author).where.not(id: params[:id])
  erb :'tracks/show'
end


get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/register' do
  @user = User.new
  @logged_in = session[:name]
  erb :'users/register'
end

post '/users' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:name] = @user.id
    redirect '/users'
  else
    erb :'users/register'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:name] = @user.id
      redirect '/users/details'
    else
      erb :'users/login'
    end
end

get '/users/logout' do
  erb :'users/logout'
end

post '/users/logout' do
  @user = User.find_by(email: params[:email])
    session[:name] = nil
    redirect '/users/logout'
end

get '/users/details' do
  @user = User.find session[:name]
  erb :'users/details'
end







