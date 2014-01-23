class MoviesController < ApplicationController


  # route: GET    /movies(.:format)
  def index
    @movies = Movie.all

    respond_to do |format|
      format.html
      format.json { render :json => @movie }
      format.xml { render :xml => @movie.to_xml }
    end
  end
  # route: # GET    /movies/:id(.:format)
  def show
    @movie = get_movie params[:imdbid]
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = get_movie params[:imdbid]

  end

  #route: # POST   /movies(.:format)
  def create
    # create new movie object from params
    movie = params.require(:movie).permit(:title, :year)
    new_movie = Movie.create(movie)
    
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  def update
    @movie = get_movie params[:id]
    #implement
  end

  # route: DELETE /movies/:id(.:format)
  def destroy
    #implement
  end


private
  def get_movie movie_id
      the_movie = @@movie_db.find do |m|
        m["imdbID"] == params[:id]
      end

      if the_movie.nil?
        flash.now[:message] = "Movie not found" if @movie.nil?
        the_movie = {}
      end
      the_movie
  end



end
