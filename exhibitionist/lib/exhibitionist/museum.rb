class Museum
  attr_accessor :name, :title, :location, :date, :description, :url, :exhibits, :main_css, :desc_css

  @@all = []

=begin
TODO:
1) associate museum exibits with exhibit objects (prob in build_exhibits)
 
=end

  def initialize(museum_hash)
binding.pry    
    self.build(museum_hash)

    
#     raw = Scraper.scrape(@url, @main_css)
#     array = parse(nodeset, name)

#     build_exhibits(array, @css[:desc])
    self.save
    # sleep 1
# binding.pry
    
# binding.pry

  end

  def build(museum_hash)
    museum_hash.each{|k, v| self.send(("#{k}="), v)}
# binding.pry
    raw = Scraper.scrape(@url, @main_css)
    # @exh_array = Scraper.parse_bk(@raw)
    # parse(raw, name)
    build_exhibits(parse(raw, @name), @desc_css)
binding.pry
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
# binding.pry
    system("clear")
    puts "Current exhibits for #{@name.capitalize} Museum:\n----------------------\n"
    self.exhibits.each_with_index{|ex, i|
      puts "#{i+1}. #{ex.title} \n   #{ex.date}"}

  ## This probably needs to be called from CLI so it doesn't mistakenly display these exhibits
  ## when someone just chooses one of the other options. 
  end

  def get_exhib(exhibit)
    raw_desc = Scraper.scrape(exhibit.url, exhibit.css)
    case self.name
    when "brooklyn"
  # binding.pry
      exhibit.desc = raw_desc.text.gsub(/\s{2,10}/, "\n\n")
# binding.pry
      ##send this to Exhibit for CLI to read
    when "guggenheim"
      exhibit.desc = raw_desc.first.text
      ##send this to Exhibit for CLI to read


    # when "met"
# binding.pry

    end



  end


  def build_exhibits(array, css)
    @exhibits = []
# binding.pry
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

  # def self.list_museums
  #   mus_array = []
  #   @@all.each_with_index{|m, i| 
  #     mus_array << "#{i+1}. #{m.name} Museum"}
  #   puts mus_array 
  # end


end


=begin
 
needs to initialize with a museum name 
needs an array of exhibits
needs to create event hashes
needs to save those hashes to the @exhibits array



=end