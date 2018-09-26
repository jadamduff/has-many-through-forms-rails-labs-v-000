class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.content = comment_params[:content]
    @comment.post_id = comment_params[:post_id]
    if comment_params[:user_id] != ''
      @comment.user_id = comment_params[:user_id]
    elsif !comment_params[:user_attributes][:username].empty?
      @comment.user_id = User.create(username: comment_params[:user_attributes][:username]).id
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
