class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        
    end

    def follow 
        @user = current_user
        
        if @user.follow(User.find(params[:followed_user_id]))
            redirect_to root_path
        end
        # hoặc sử dụng 
        #     @user.followings << User.find(params[:followed_user_id])
    end

    def follower 
        user_ids = current_user.follower_ids
        @users  = User.where(id: user_ids)

    end

    def following

    end
    


end
