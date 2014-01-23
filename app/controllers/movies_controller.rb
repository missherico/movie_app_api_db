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
    @movie = get_movie params[:id]
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = get_movie params[:id]


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

    updated_info = params.require(:movie).permit(:title, :year)
    @movie.update_attributes(updated_info)
    #implement
    redirect_to action: :show
  end


  # route: DELETE /movies/:id(.:format)
  def destroy
    movie = get_movie params[:id]
    movie.destroy
    
    redirect_to action: :index
  end


  def search
    

    render :search
  end


  def result
  
  search_str = params[:movie]

  response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str, :plot => "full"})
  result = JSON.parse(response.body)

  @result_array = result["Search"].sort_by { |movie| movie["Year"]}
  save_search_to_db
  

  render :result
  end


private
  def get_movie movie_id
      the_movie = Movie.find do |movie|
      movie["id"] = movie_id

      end

      if the_movie.nil?
        flash.now[:message] = "Movie not found" if @movie.nil?
        the_movie = {}
      end
      the_movie
  end


  def save_search_to_db
    #movie = params.require(:movie).permit(:title, :year, :imdbID, :full_plot, :pic_link)

    local_array = @result_array.each do |movie|
      id = movie["imdbID"]
      response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => id, :plot => "full"})
      result = JSON.parse(response.body)

      movie = Movie.create(title: result["Title"], year: result["Year"], imdb: result["imdbID"], full_plot: result["Plot"], pic_link: result["Poster"])

    end


  end

end
