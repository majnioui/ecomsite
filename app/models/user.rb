class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         attr_writer :login
         validate :validate_username
         def login
           @login || self.username || self.email
         end
         def self.find_for_database_authentication(warden_conditions)
          conditions = warden_conditions.dup
          if (login = conditions.delete(:login))
            where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
          elsif conditions.has_key?(:username) || conditions.has_key?(:email)
            where(conditions.to_h).first
          end
        end
        def validate_username
          if User.where(email: username).exists?
            errors.add(:username, :invalid)
          end
        end
  # validate user to have at least 1 role (incase accidentally remove all roles from user)
          validate :must_have_a_role, on: :update
  # middleware to assign default role after creating new user
          after_create :assign_default_role

        def assign_default_role
          if User.count == 1
            add_role(:admin) if roles.blank?
          elsif roles.blank?
            add_role(:user)
          end
        end

        def must_have_a_role
          errors.add(:roles, 'must have at least one role') unless roles.any?
        end
end
