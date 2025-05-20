require 'date'

class Calendar
  def initialize(events)
    @events = events

    # Si au moins un événement, on utilise son mois/année ; sinon on prend le mois courant
    if @events.any?
      @month = @events.first.start_date.month
      @year = @events.first.start_date.year
      first_day = Date.new(@year, @month, 1)
      @start_wday = (first_day.wday + 6) % 7  # Pour que lundi = 0, dimanche = 6

    else
      today = Date.today
      @month = today.month
      @year = today.year
    end

    # Calculer le nombre de jours dans le mois dynamiquement
    @days_in_month = Date.new(@year, @month, -1).day
    @calendar = Array.new(@days_in_month) { [] }

    populate_calendar
  end

  def populate_calendar
    @events.each do |event|
      if event.start_date.month == @month && event.start_date.year == @year
        day_index = event.start_date.day - 1
        @calendar[day_index] << event.title
      end
    end
  end

  def display
    puts "-" * 71
    print_day_headers
    days = []
    @start_wday.times { days << nil } # Jours vides avant le 1er

    (1..@days_in_month).each { |d| days << d }

    # Ajouter des cases vides à la fin pour compléter la dernière semaine
    while days.size % 7 != 0
      days << nil
    end

weeks = days.each_slice(7).to_a
weeks.each { |week| print_week(week) }


    puts "-" * 71
  end

  def print_day_headers
    days = %w[Lun Mar Mer Jeu Ven Sam Dim]
    puts "|" + days.map { |d| d.ljust(9) + "|" }.join
  end

  def print_week(week)
  print "|"
  week.each do |day|
    print (day ? day.to_s : "").ljust(9) + "|"
  end
  puts

  print "|"
  week.each do |day|
    if day && @calendar[day - 1].any?
      print "9:00am".ljust(9) + "|"
    else
      print " ".ljust(9) + "|"
    end
  end
  puts

  print "|"
  week.each do |day|
    if day && @calendar[day - 1].any?
      print @calendar[day - 1].first.to_s[0..8].ljust(9) + "|"
    else
      print " ".ljust(9) + "|"
    end
  end
  puts

  2.times do
    print "|"
    week.each { print " ".ljust(9) + "|" }
    puts
  end

  puts "-" * 71
end
end


