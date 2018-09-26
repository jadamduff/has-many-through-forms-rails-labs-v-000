class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.content = params[:content]
    @comment.post_id = params[:post_id]
    if params[:user_id]
      @comment.user_id = params[:user_id]
    elsif !params[:user_attributes][:username].empty?
      @comment.user_id = User.create(username: params[:user_attributes][:username]).id
    end
    @comment.save
    binding.pry
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, user_attributes: [:username])
  end
end
