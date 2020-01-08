class CommentsController < ApplicationController
  before_action :find_commentable, only: :create
  before_action :correct_user, only: %i[edit update]

  def create
    # render json: params
    @commentable.comments.build(comment_params)
    if @commentable.save
      flash[:success] = 'Comment created!'
    else
      flash[:danger] = 'comment cannot be created!'
    end

    redirect_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    if (current_user == @comment.user) || current_user.admin?
      @comment.destroy
      flash[:success] = 'Comment deleted !'
    else
      flash[:danger] = 'Unauthorized'
    end

    redirect_url
  end

  def edit
  end

  def update
    @comment.update_attributes(comment_params)
    redirect_url
  end

  private

  # filtering before writing to db
  def comment_params
    {
      content: params[:comment][:content],
      user_id: current_user.id
    }
  end

  # finding the comment or post => adding new comment
  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
        @commentable = Post.find_by_id(params[:post_id])
    end
  end

  # redirecting to the post after updating the comment
  def redirect_url
    if params[:post_id]
      redirect_to post_path(params[:post_id])
    else
      redirect_to Comment.find(params[:comment_id]).commentable
    end
  end

  # checking authorization
  def correct_user
    @comment = Comment.find(params[:id])

    unless current_user == @comment.user do
      flash[:danger] = 'Unauthorized'
    end
  end
end
end
