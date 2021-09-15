class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :ratings, dependent: :nullify
  has_many :incidents, dependent: :nullify
  has_many :journeys, dependent: :nullify

  has_one_attached :avatar

  accepts_nested_attributes_for :contacts


  include Abyme::Model
  abymize :contacts

  def full_name
    first_name + " " + last_name
  end

end
