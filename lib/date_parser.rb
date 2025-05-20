require 'date'

class DateParser
  MONTHS = {
    "janvier" => 1, "février" => 2, "mars" => 3, "avril" => 4, "mai" => 5,
    "juin" => 6, "juillet" => 7, "août" => 8, "septembre" => 9,
    "octobre" => 10, "novembre" => 11, "décembre" => 12
  }

  WEEKDAYS = {
    "lundi" => 1,
    "mardi" => 2,
    "mercredi" => 3,
    "jeudi" => 4,
    "vendredi" => 5,
    "samedi" => 6,
    "dimanche" => 0
  }

  def parse(input)
    input = input.downcase.strip

    # === 1. Gérer le cas : "lundi prochain à 9 h" ===
    if input.match(/^(\w+)\s+prochain\s+à\s+(\d{1,2})\s*h(?:\s*(\d{1,2}))?$/)
      weekday_str = $1
      hour = $2.to_i
      minute = $3 ? $3.to_i : 0

      wday_target = WEEKDAYS[weekday_str]

      unless wday_target
        warn "Jour de la semaine inconnu : #{weekday_str}"
        return nil
      end

      today = Date.today
      days_until = (wday_target - today.wday) % 7
      days_until = 7 if days_until == 0 # s'il est aujourd'hui, on prend la semaine prochaine

      date = today + days_until
      return DateTime.new(date.year, date.month, date.day, hour, minute).new_offset(DateTime.now.offset)
    end

    # === 2. Gérer le cas : "le 14 octobre à 15 h 30" ===
    input.sub!(/^le\s+/, "")
    date_part, time_part = input.split(" à ")

    unless date_part && time_part
      warn "Format invalide. Essayez : 'le 14 octobre à 15 h 30'"
      return nil
    end

    day, month_name = date_part.split
    day = day.to_i
    month = MONTHS[month_name]

    unless month
      warn "Mois inconnu : #{month_name}"
      return nil
    end

    hour, minute = time_part.gsub("h", "").split.map(&:to_i)
    minute ||= 0
    year = Date.today.year

    DateTime.new(year, month, day, hour, minute).new_offset(DateTime.now.offset)
  rescue => e
    warn "Erreur lors du parsing : #{e.message}"
    nil
  end
end

# 🔍 Exemples d'utilisation
parser = DateParser.new
puts parser.parse("le 14 octobre à 15 h 30")          # => DateTime en octobre
puts parser.parse("lundi prochain à 9 h")             # => Date du prochain lundi
puts parser.parse("mercredi prochain à 14 h 15")      # => Prochain mercredi
puts parser.parse("dimanche prochain à 18 h")         # => Prochain dimanche
