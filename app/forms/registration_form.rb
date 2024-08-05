class RegistrationForm
  include ActiveModel::Model

  attr_accessor :name, :last_name, :email, :password, :password_confirmation, :current_user
  attr_reader :user

  validates :name, :last_name, presence: true
  validates :password, presence: true, confirmation: true, if: :password_required?
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def initialize(params = {})
    @params = params
    super(params)
  end

  def save
    return false unless valid?

    @user = if @params[:id]
              User.find(@params[:id])
            else
              User.new
            end

    @user.assign_attributes(
      name: name,
      last_name: last_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation
    )

    @user.save
  end

  private

  def password_required?
    current_user.nil? || password.present?
  end
end
