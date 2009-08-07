# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  
  has_many :follows
  has_many :twits, :through=>'follows'
  
  # new columns need to be added here to be writable through mass assignment
  #  attr_accessible :username, :email, :password, :password_confirmation
  attr_accessible :phone, :twitter
  attr_accessor :twitter
  
#  attr_writer :twitter
  
  # attr_accessor :password
  before_validation :prepare_phone
  before_save       :generate_code
  
  validates_presence_of :twitter
  
  validates_presence_of :phone
  validates_uniqueness_of :phone
  validates_length_of :phone, :minimum => 11
  validates_format_of :phone, :with => /^[0-9]+$/i,  :message => "should only contain numbers"

  # validates_presence_of :username
  # validates_uniqueness_of :username, :email, :allow_blank => true
  # validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  # validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  # validates_presence_of :password, :on => :create
  # validates_confirmation_of :password
  # validates_length_of :password, :minimum => 4, :allow_blank => true
  
  # login can be either username or email address
  # def self.authenticate(login, pass)
  #   user = find_by_username(login) || find_by_email(login)
  #   return user if user && user.matching_password?(pass)
  # end
  
  # def matching_password?(pass)
  #   self.password_hash == encrypt_password(pass)
  # end
  
#  def twitter
#    params[:user][:twitter]
#    'asdasd'
#  end
  
  private
  
  def prepare_phone
    phone.sub!(/[^0-9]/,'')
  end
  
  def generate_code
    # TODO Сделать нормальную генерацию кода
    self.phone_code=rand(1000)
  end
  
  # def prepare_password
  #   unless password.blank?
  #     self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
  #     self.password_hash = encrypt_password(password)
  #   end
  # end
  
  # def encrypt_password(pass)
  #   Digest::SHA1.hexdigest([pass, password_salt].join)
  # end
end
