class Auth < ApplicationRecord
  def self.authenticate?(password)
    self.first.pass == Digest::MD5.hexdigest(password + "real")
  end

end
