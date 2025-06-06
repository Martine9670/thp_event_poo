require_relative 'event'
require_relative 'date_parser'
require_relative 'work_event'

class EventCreator
  def self.run
    puts "Salut, tu veux créer un événement ? Cool !"

    puts "Commençons. Quel est le nom de l'événement ?"
    title = gets.chomp

    puts "Super. Quand aura-t-il lieu et à quelle heure?"
    date = gets.chomp

    puts "Au top. Combien de temps va-t-il durer (en minutes) ?"
    duration = gets.chomp.to_i

    puts "Génial. Qui va participer ? Balance leurs e-mails (séparés par un point-virgule)"
    emails_input = gets.chomp
    attendees = emails_input.split(";")

    puts "Où cela va t'il se passer ?"
    location = gets.chomp

    event = WorkEvent.new(date, duration, title, attendees, location)

    puts "Super, c'est noté, ton évènement a été créé !"
    puts
    puts "Voici les détails :"
    puts event.to_s

    #  PLACE CETTE LIGNE ICI (DANS LA MÉTHODE)
    $all_events << event
  end
end