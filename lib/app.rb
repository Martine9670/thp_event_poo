$all_events = []
require "pry"

# lignes qui appellent les fichiers lib/user.rb et lib/event.rb
# comme ça, tu peux faire User.new dans ce fichier d'application. Top.
require_relative 'user'
require_relative 'event'
require_relative 'event_creator'
require_relative 'calendar'
require_relative 'date_parser'


# Maintenant c'est open bar pour tester ton application. Tous les fichiers importants sont chargés
# Tu peux faire User.new, Event.new, binding.pry, User.all, etc.


# Création de quelques utilisateurs
julie = User.new("julie@email.com", 32, "Paris")
jean = User.new("jean@maimail.com", 27, "Avignon")
pierre = User.new("pierre@email.com", 28, "Dijon")
bob = User.new("bob@email.com", 41, "Nice")

my_event = Event.new("2019-01-13 09:00", 10, "standup quotidien", [julie, jean])

my_event.age_analysis #j'exécute la nouvelle méthode que j'ai écrite

# Récupérer tous les utilisateurs,
all_users = User.all
all_users.each do |user|
  puts "Email: #{user.email}, Age: #{user.age}, City: #{user.city}"
end

# Exemple d'utilisation pour la classe Event,
event = Event.new("2019-01-13 09:00", 10, "standup quotidien", ["truc@machin.com", "bidule@chose.fr"])
puts event.to_s

# Demander un email à l'utilisateur via la console,
puts "Entrez l'email de l'utilisateur que vous cherchez :"
input_email = gets.chomp

# Recherche,
user_found = User.find_by_email(input_email)

# Affichage du résultat,
if user_found
  puts "Utilisateur trouvé :"
  puts "Email : #{user_found.email}"
  puts "Âge : #{user_found.age}"
  puts "City : #{user_found.city}"
  
else
  puts "Aucun utilisateur trouvé avec l'email #{input_email}."
end

  # Création d’un événement avec EventCreator,
  puts "\nSouhaites-tu créer un événement ? (oui/non)"
  response = gets.chomp.downcase

  if response == "oui"
    EventCreator.run
  else
    puts "Très bien, à une prochaine fois pour créer un événement !"
  end

  puts "\nSouhaites-tu afficher le calendrier ? (oui/non)"
  answer = gets.chomp.downcase

  if answer == "oui"
    require_relative 'calendar'
    Calendar.new($all_events).display
  else
    puts "D'accord, à une prochaine fois pour consulter le calendrier !"
end

# Pause pour debugger (si tu as la gem 'pry' installée)
# binding.pry

binding.pry
puts "end of file"