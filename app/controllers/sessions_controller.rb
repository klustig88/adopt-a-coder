class SessionsController < ApplicationController


  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:id] = user.id
      if current_user_candidate
        redirect_to candidate_path(current_user)
      else
        redirect_to donor_path(current_user)
      end
    else
      flash[:notice] = "Incorrect Email or Password"
      redirect_to root_path
    end

  end

  def logout
    session[:id] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to root_path
  end


 

end

