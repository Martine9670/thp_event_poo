require 'time' # Pour pouvoir utiliser Time.parse
require 'pry'

class Event
    @@all_events = []
    attr_accessor :start_date, :duration, :title, :attendees


  def initialize(start_date, duration, title, attendees)
    @start_date = start_date.is_a?(String) ? Time.parse(start_date) : start_date    
    @duration = duration.to_i # en minutes
    @title = title
    @attendees = attendees
    @@all_events << self
  end

  def self.all
    @@all_events
  end

  def postpone_24h
    @start_date += 86400 # Ajoute 24 heures en secondes
  end

  def end_date
    @start_date + (@duration * 60) # Convertit la durée en secondes
  end

  def is_past?
    @start_date < Time.now
  end

  def is_future?
    !is_past?
  end

  def is_soon?
    time_diff = @start_date - Time.now
    time_diff > 0 && time_diff <= 30 * 60 # entre maintenant et +30 minutes
  end

  def to_s
  <<~OUTPUT
  > Titre : #{@title}
  > Date de début : #{@start_date.strftime("%Y-%m-%d %H:%M")}
  > Durée : #{@duration} minutes
  > Invités : #{@attendees.join(', ')}
  OUTPUT
    end
end

# Test de création d'un événement
event = Event.new("2025-07-14 15:00", 120, "Balade", ["pierre@email.com"])

# Affiche les informations de l'événement
puts event.to_s

# Affiche tous les événements
puts "\nTous les événements :"
puts Event.all

# Tester la méthode pour savoir si l'événement est dans le futur
puts "\nL'événement est dans le futur ? #{event.is_future?}"

# Tester la méthode de report de 24h
event.postpone_24h
puts "\nNouvelle date après report de 24h : #{event.start_date}"

# Tester la méthode pour savoir si l'événement est bientôt
puts "\nL'événement est-il prévu bientôt ? #{event.is_soon?}"

