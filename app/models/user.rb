class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  belongs_to :region
  belongs_to :organisation

  def has_role?(role_name)
    !!roles.exists?(slug: role_name)
  end

  def add_role(role_name)
    roles << Role.where(slug: role_name).first! unless roles.exists?(slug: role_name)
  end

  def remove_role(role_name)
    role = Role.where(slug: role_name).first!
    roles.delete role
  end
end