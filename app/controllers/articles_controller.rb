class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index]
  before_action :set_article, except: [:index, :new, :create]
	def index
		@articles = Article.all
	end

	def show		
    @article.update_visits_count
	end	

	def new
		@article = Article.new
	end	

	def edit
  end

	def create
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article/1
  # PATCH/PUT /article/1.json
  def update
  	if @article.update(article_params)
  		redirect_to @article
  	else
  		render :edit
  	end
    #respond_to do |format|
     # if @article.update(article_params)
      #  format.html { redirect_to @article, notice: 'Article was successfully updated.' }
       # format.json { render :show, status: :ok, location: @article }
      #else
       # format.html { render :edit }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # DELETE /article/1
  # DELETE /article/1.json
  def destroy    
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
    #respond_to do |format|
     # format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
