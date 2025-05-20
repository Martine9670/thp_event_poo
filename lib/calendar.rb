require 'date'

class Calendar
  def initialize(events)
    @events = events

    # Si au moins un événement, on utilise son mois/année ; sinon on prend le mois courant
    if @events.any?
      @month = @events.first.start_date.month
      @year = @events.first.start_date.year
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
    total_weeks = (@days_in_month.to_f / 7).ceil

    (0...total_weeks).each do |week|
      print_week(week)
    end

    puts "-" * 71
  end

  def print_day_headers
    days = %w[Lun Mar Mer Jeu Ven Sam Dim]
    puts "|" + days.map { |d| d.ljust(9) + "|" }.join
  end

  def print_week(week)
    start_day = week * 7
    end_day = [start_day + 6, @days_in_month - 1].min

    print "|"
    (start_day..end_day).each { |i| print "#{(i + 1).to_s.ljust(9)}|" }
    puts

    print "|"
    (start_day..end_day).each do |i|
      print @calendar[i].any? ? "9:00am  ".ljust(9) + "|" : " ".ljust(9) + "|"
    end
    puts

    print "|"
    (start_day..end_day).each do |i|
      title = @calendar[i].first.to_s[0..8]  # tronque à 9 caractères
      print title.ljust(9) + "|"
    end
    puts

    2.times do
      print "|"
      (start_day..end_day).each { print " ".ljust(9) + "|" }
      puts
    end

    puts "-" * 71
  end
end


