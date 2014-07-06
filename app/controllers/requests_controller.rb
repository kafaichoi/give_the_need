class RequestsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @request = @post.requests.new(comment_params)
    @request.creator = current_user
    if @request.save
      flash[:info] = "Your comment is added"
      redirect_to post_path(@post)
    else
      render post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:request).permit(:body)
  end
end