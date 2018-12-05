class RiverRun::Event
  attr_accessor :name, :url, :more_info
  attr_writer :date

  # @@events = []
  #
  # def initialize
  #   @@events << self
  # end

  def date
    if @date.size == 1
      @date[0].strftime("%m/%d")
    elsif @date.size == 2
      "#{@date[0].strftime("%m/%d")} & #{@date[1].strftime("%m/%d")}"
    end
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
      event.more_info = event.scrape_more_info # array
    end

    [event_1, event_2, event_3]
  end

  def self.scrape_riverrun
    doc = Nokogiri::HTML(open("https://riverrunfilm.com/year-round-events-and-screenings/"))
    scrape_hash = {}
    doc.search("h3.film-title > a").slice(0..2).each {|x| scrape_hash[x.text] = x.values[0] }
    scrape_hash
  end

  def scrape_more_info
    more_info_array = []
    doc = Nokogiri::HTML(open(self.url))
    doc.search("main p").each {|p| more_info_array << p.text }
    more_info_array.delete_if {|p| p.empty? }
  end

end
