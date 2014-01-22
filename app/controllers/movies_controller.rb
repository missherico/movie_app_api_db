class MoviesController < ApplicationController

  @@movie_db = [
          {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)
  def index
    @movies = @@movie_db

    respond_to do |format|
      format.html
      format.json { render :json => @@movie_db }
      format.xml { render :xml => @@movie_db.to_xml }
    end
  end
  # route: # GET    /movies/:id(.:format)
  def show
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end
    if @movie.nil?
      flash.now[:message] = "Movie not found" if @movie.nil?
      @movie = {}
    end
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end

    if @movie.nil?
      flash.now[:message] = "Movie not found" if @movie.nil?
      @movie = {}
    end
  end

  #route: # POST   /movies(.:format)
  def create
    # create new movie object from params
    movie = params.require(:movie).permit(:title, :year)
    movie["imdbID"] = rand(10000..100000000).to_s
    # add object to movie db
    @@movie_db << movie
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  def update
    # 'delete and insert'
    @@movie_db.delete_if do |m|
      m["imdbID"] == params[:id]
    end

    #create new movie
    movie = params.require(:movie).permit(:title, :year)
    movie['imdbID'] = params[:id]

    @@movie_db << movie
    redirect_to action: :index
  end

  # route: DELETE /movies/:id(.:format)
  def destroy
    @@movie_db.delete_if do |m|
      m["imdbID"] == params[:id]
    end
    redirect_to action: :index
  end

end
