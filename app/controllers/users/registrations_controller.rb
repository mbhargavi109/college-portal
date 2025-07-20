class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :role, :semester, :roll_number,
                                 :department_id, :subject_id)
  end
end
