class Museum
  attr_accessor :name, :title, :location, :date, :description, :url, :exhibits, :css, :detail

  @@all = []

=begin
TODO:
1) associate museum exibits with exhibit objects (prob in build_exhibits)
 
=end

  def initialize(nodeset, name, css)
    @name = name
    @css = css
    array = parse(nodeset, name)
# binding.pry
    build_exhibits(array, @css[:desc])
    self.save
    # sleep 1
# binding.pry
    
# binding.pry

  end

  def self.build(museum_name, url, css_hash)
    @raw = Scraper.scrape(url, css_hash[:main])
    # @exh_array = Scraper.parse_bk(@raw)
    Museum.new(@raw, museum_name, css_hash)
# binding.pry
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

  def get_exhib(exh_obj, exh_url, desc_css)
    raw_desc = Scraper.scrape(exh_url, desc_css)
    case self.name
    when "brooklyn"
  # binding.pry
      exh_obj.desc = raw_desc.text.gsub(/\s{2,10}/, "\n\n")
# binding.pry
      ##send this to Exhibit for CLI to read
    when "guggenheim"
      exh_obj.desc = raw_desc.first.text
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