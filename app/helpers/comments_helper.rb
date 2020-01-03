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

end
