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

if __FILE__ == $0
  puts "Création d'utilisateurs de test..."

  user1 = User.new("alice@email.com", 30, "Paris")
  user2 = User.new("bob@email.com", 25, "Lyon")

  puts "\nListe des utilisateurs :"
  User.all.each do |user|
    puts "Email: #{user.email}, Âge: #{user.age}, Ville: #{user.city}"
  end

  puts "\nRecherche d'un utilisateur :"
  found_user = User.find_by_email("alice@email.com")
  if found_user
    puts "Utilisateur trouvé : #{found_user.email}, #{found_user.age} ans, #{found_user.city}"
  end
end
