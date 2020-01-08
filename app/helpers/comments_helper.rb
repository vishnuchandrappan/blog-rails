module CommentsHelper

    def author_name(entity)
        if(current_user == entity.user)
            @author_name = 'You'
        else
            @author_name = entity.user.name
        end
    end

    def is_current_user_author?(entity)
        current_user == entity.user ? true : false
    end

    def get_edit_comment(comment)
        if(comment.commentable_type == 'Post')
            edit_post_comment_path(comment.commentable, comment)
        else
            edit_comment_comment_path(comment.commentable, comment)
        end
    end

    def get_comment(comment)
        if(comment.commentable_type == 'Post')
            post_comment_path(comment.commentable, comment)
        else
            comment_comment_path(comment.commentable, comment)
        end
    end

    def get_post_comment(comment)
        if(comment.commentable_type == 'Post')
            post_comment_path
        else
            comment_comment_path
        end
    end

end
