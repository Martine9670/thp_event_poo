require 'date'

class DateParser
  MONTHS = {
    "janvier" => 1, "février" => 2, "mars" => 3, "avril" => 4, "mai" => 5,
    "juin" => 6, "juillet" => 7, "août" => 8, "septembre" => 9,
    "octobre" => 10, "novembre" => 11, "décembre" => 12
  }

  def parse(input)
    begin
      input = input.downcase.strip
      # Enlever le préfixe "le" du début
      input.sub!(/^le\s+/, "")

      # Diviser la date et l'heure
      date_part, time_part = input.split(" à ")

      # Extraire jour et mois
      day, month_name = date_part.split
      day = day.to_i
      month = MONTHS[month_name]

      # Extraire heure et minute
      hour, minute = time_part.gsub("h", "").split.map(&:to_i)
      minute ||= 0  # Si minute est absent, on le met à 0

      # Récupérer l'année courante
      year = Date.today.year

      # Créer un objet DateTime avec l'année, le mois, le jour, l'heure et la minute
      date_time = DateTime.new(year, month, day, hour, minute)

      # Retourner l'objet DateTime avec le fuseau horaire local
      date_time.new_offset(DateTime.now.offset)
    rescue => e
      puts "Erreur lors du parsing : #{e.message}"
      nil
    end
  end
end

# Exemple d'utilisation :
parser = DateParser.new
puts parser.parse("le 14 octobre à 15 h 30")  # => 2025-10-14T15:30:00+01:00
