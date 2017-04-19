class UsersController < ApplicationController
    def index
    end


    def login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to '/events'
        else
            flash[:messages] = ["invalid login information"]
            redirect_to :back
        end
    end


    def logout
        session[:user_id] = nil
        redirect_to '/'
    end



    def register
        @newUser = User.create(new_user_params)
        if @newUser.valid?
            session[:user_id] = @newUser.id
            redirect_to '/events'
        else
            flash[:messages] = @newUser.errors.full_messages
            redirect_to :back
        end
    end

    def edit
        @user = User.find(session[:user_id])
        render 'profile_edit'
    end


    def profile_edit
        @user = User.find(session[:user_id])
        @user.update(update_params)
        redirect_to '/events'
    end



    def add_event
        Event.create(name: params[:name], date: params[:date], city: params[:city], state: params[:state], user_id: session[:user_id])
        redirect_to :back
    end

    def events_dashboard
        @current_user = User.find(session[:user_id])
        @events_in_users_state = Event.where(state: @current_user.state)
        @events_not_in_users_state = Event.where.not(state: @current_user.state)

        # @events_owned = Owner.where(user_id: session[:user_id])


    end

    def event_detail
        @event = Event.find(params[:id])
        @attendees = Event.find(params[:id]).users
        @comments = Comment.where(event_id: @event.id)
    end

    def edit_event
        @current_event = Event.find(params[:event_id])
    end

    def destroy_event
        current_event = Event.find(params[:event_id])
        current_event.destroy
        redirect_to '/events'
    end

    def update_event
        current_event = Event.find(params[:event_id])
        current_event.update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
        redirect_to '/events'
    end




    def add_comment
        comment = Comment.create(content: params[:comment], user_id: session[:user_id], event_id: params[:event_id])
        redirect_to :back
    end

# join event
    def join_event
        owner = Owner.create(user_id: session[:user_id], event_id: params[:event_id])
        redirect_to :back
    end

# cancel joining event
    def cancel
        owner = Owner.where(user_id: session[:user_id], event_id: params[:event_id]).first
        owner.destroy
        redirect_to :back
    end







    private
        def new_user_params
            params.require(:register).permit(:first_name, :last_name, :email, :password, :password_confirmation, :city, :state)
        end

        def update_params
            params.require(:update).permit(:first_name, :last_name, :email, :city, :state)
        end
end
