class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def new
        @post = current_user.posts.new
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Post created!"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
        unless current_user == @post.user
            redirect_to root_path
            flash[:danger] = "Unauthorized"
        end
    end

    def update
        @post = Post.find(params[:id])
        if current_user == @post.user
            if @post.update_attributes(post_params)
                flash[:success] = "Changes saved !"
                redirect_to @post
            else
                render 'edit'
            end
        else
            redirect_to root_path
            flash[:danger] = "Unauthorized"
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if current_user == @post.user
            unless current_user == @post.user
                redirect_to root_path
                flash[:danger] = "Unauthorized"
            end
            @post.destroy
            flash[:success] = "Post deleted !"
            redirect_to @current_user
        else
            redirect_to root_path
            flash[:danger] = "Unauthorized"
        end
    end

    private

        def post_params
            params.require(:post).permit(:title, :body)
        end

end
