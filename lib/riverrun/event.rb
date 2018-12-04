require 'date'
require 'time'

class RiverRun::Event
  attr_accessor :name, :url
  attr_writer :date

  def date
    if @date.size == 1
      @date[0].strftime("%m/%d")
    elsif @date.size == 2
      "#{@date[0].strftime("%m/%d")} & #{@date[1].strftime("%m/%d")}"
    end
  end

  def self.today
    scrape_hash = self.scrape_riverrun
    # {
    #   "RUMBLE -- free Indie Lens Pop-Up screening 12/3!" => "https://riverrunfilm.com/rumbleitvs/",
    #   "Holiday Affair with actor Gordon Gebert on 11/17 & 11/18!" => "https://riverrunfilm.com/holiday-affair/",
    #   "RiverRun presents \"The Best of the 2018 Greensboro 48 Hour Film Project\" on 11/13!" => "https://riverrunfilm.com/48hr/"
    # }


    event_1 = self.new
    mini_array = scrape_hash.shift
    namedate_string = mini_array[0].dup
    event_1.date = namedate_string.slice!(/\so?n?\s?\d\d?\/.*$/).scan(/\d{2}\/\d\d?/).map {|d| DateTime.parse(d)}
    event_1.name = namedate_string
    event_1.url = mini_array[1]

    event_2 = self.new
    mini_array = scrape_hash.shift
    namedate_string = mini_array[0].dup
    event_2.date = namedate_string.slice!(/\so?n?\s?\d\d?\/.*$/).scan(/\d{2}\/\d\d?/).map {|d| DateTime.parse(d)}
    event_2.name = namedate_string
    event_2.url = mini_array[1]

    event_3 = self.new
    mini_array = scrape_hash.shift
    namedate_string = mini_array[0].dup
    event_3.date = namedate_string.slice!(/\so?n?\s?\d\d?\/.*$/).scan(/\d{2}\/\d\d?/).map {|d| DateTime.parse(d)}
    event_3.name = namedate_string
    event_3.url = mini_array

    [event_1, event_2, event_3]
  end

  def self.scrape_riverrun
    doc = Nokogiri::HTML(open("https://riverrunfilm.com/year-round-events-and-screenings/"))
    scrape_hash = {}
    doc.search("h3.film-title > a").slice(0..2).each {|x| scrape_hash[x.text] = x.values[0] }
    # binding.pry
    scrape_hash
  end

end
