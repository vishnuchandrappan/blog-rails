class CommentsController < ApplicationController

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            flash[:success] = "Comment created!"
        else
            flash[:danger] = "comment cannot be created!"
        end
        redirect_to post_path(comment_params[:post_id])
    end

    def destroy
        @comment = Comment.find(params[:id])
        unless current_user == @comment.user
            redirect_to post_path(@comment.post)
            flash[:danger] = "Unauthorized"
        else
            @post  = @comment.post
            @comment.destroy
            flash[:success] = "Comment deleted !"
            redirect_to post_path(@post)
        end
    end

    private

        def comment_params
            {
                content: params[:comment][:content],
                post_id: params[:post_id]
            }
        end

end
