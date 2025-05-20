require 'pry'

class User

    attr_accessor :email, :age, :city

    # on stocke les users dans cette variable
    @@all_users = []

    def initialize(email, age, city)
        @email = email
        @age = age
        @city = city

    # on ajoute chaque nouveau user à la variable
        @@all_users << self
    end

    # méthode pour accéder à tous les users
    def self.all
        @@all_users
    end

    def self.find_by_email(email)
    user = @@all_users.find { |user| user.email == email }
    unless user
    puts "Aucun utilisateur trouvé avec l'email #{email}"
    return nil
  end
  user
end

end
