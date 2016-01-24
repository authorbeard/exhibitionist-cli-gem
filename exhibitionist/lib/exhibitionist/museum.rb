class Museum
  attr_accessor :name, :title, :location, :date, :description, :url, :exhibits, :main_css, :desc_css

  @@all = []

  def initialize(museum_hash)   
    self.build(museum_hash)
    self.save
  end

  def build(museum_hash)
    museum_hash.each{|k, v| self.send(("#{k}="), v)}
    raw = Scraper.scrape(@url, @main_css)
    build_exhibits(parse(raw, @name), @desc_css)
  end

  def parse(nodeset, name)
    case name
    when "brooklyn"
      Scraper.parse_bk(nodeset)
    when "guggenheim"
      Scraper.parse_gugg(nodeset)

    end

  end

  def display_exhibits
    puts "\n"
    puts "Current exhibits for #{@name.capitalize} Museum:\n----------------------\n"
    self.exhibits.each_with_index{|ex, i|
      puts "#{i+1}. #{ex.title} \n   #{ex.date}"}
  end

  def get_exhib(exhibit)
    raw_desc = Scraper.scrape(exhibit.url, exhibit.css)
    case self.name
    when "brooklyn"
      exhibit.desc = raw_desc.text.gsub(/\s{2,10}/, "\n\n")
    when "guggenheim"
      exhibit.desc = raw_desc.first.text
    end
  end


  def build_exhibits(array, css)
    @exhibits = []
    array.each{|ex| 
      @exhibits << Exhibit.new(ex, self, css)
    }
  end

  def self.display_all
    @@all.each_with_index{|m, i| 
      puts "{i+1}. #{m.name.capitalize} Museum"}
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end
end