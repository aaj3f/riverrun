require 'date'
require 'time'

class RiverRun::Event
  attr_accessor :name, :url
  attr_writer :date

  @@events = []

  def initialize
    @@events << self
  end

  def date
    if @date.size == 1
      @date[0].strftime("%m/%d")
    elsif @date.size == 2
      "#{@date[0].strftime("%m/%d")} & #{@date[1].strftime("%m/%d")}"
    end
  end

  def info
    # Needs to return heredoc of scraped info about specific Event object that it's called on
    #
  end

  def self.today
    scrape_hash = self.scrape_riverrun

    event_1 = self.new
    event_2 = self.new
    event_3 = self.new

    [event_1, event_2, event_3].each do |event|
      mini_array = scrape_hash.shift
      namedate_string = mini_array[0].dup
      event.date = namedate_string.slice!(/\so?n?\s?\d\d?\/.*$/).scan(/\d{2}\/\d\d?/).map {|d| DateTime.parse(d)}
      event.name = namedate_string
      event.url = mini_array[1]
    end

    [event_1, event_2, event_3]
  end

  def self.scrape_riverrun
    doc = Nokogiri::HTML(open("https://riverrunfilm.com/year-round-events-and-screenings/"))
    scrape_hash = {}
    doc.search("h3.film-title > a").slice(0..2).each {|x| scrape_hash[x.text] = x.values[0] }
    scrape_hash
  end

  def

end
