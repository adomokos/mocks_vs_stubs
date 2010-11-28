class User < ActiveRecord::Base
  def to_param
    screen_name
  end

  def self.save_user!(parameters)
    user = User.find_by_screen_name(parameters[:screen_name])
    if user
      user.attributes = parameters
    else
      user = User.new(parameters)
    end
    if user.save!
      return user
    end

    nil
  end
end
