class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  def new
    @post = Post.new
  end

  def create
    # require 'pry'; binding.pry
    @post = Post.new(post_params.merge(user:current_user))
    if @post.save
      flash[:info] = 'Your registration is succeeded. Please sign in.'
      redirect_to posts_path
    else 
      flash[:danger] = "There are some problems in your post form. Please check"
      render new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @request = Request.new
  end



  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).select{|post| post.status != :success}
    elsif params[:location]
      location = Location.find(params[:location])
      @posts = Post.all.select{|post| post.locations.include? location}
    else
    @posts = Post.all.select{|post| post.status != :success}
    end
  end

  private
  def post_params
    params.require(:post).permit!
  end

end