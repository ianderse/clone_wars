class User

  def initialize
    @username = "Admin"
    @password = "pass"
  end


  def valid?(username, password)
    return true if username == @username && password == @password
  end
end
