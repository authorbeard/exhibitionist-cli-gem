class Scraper
  attr_accessor :blkyn, :gugg, :the_met

  
  def self.scrape(url, css)
    Nokogiri::HTML(open(url)).css(css)
# binding.pry
  end



  def self.parse_bk(nodeset)
    nodeset.collect{|ex| 
      {
        :url => ex.at("a")["href"],
        :title => ex.css("h2").text,
        :date => ex.css("h4").text.gsub(/\n( +)?/, "")
      }}
  end

  def self.parse_gugg(nodeset)
    nodeset.collect {|ex| 
      @exh_hash = {
        :url => "http://www.guggenheim.org#{ex.at("a")["href"]}", 
        :title => ex.css("h4").text,
        :date => ex.css(".exh-dateline").text, 
        :ongoing_date => ex.css(".row-text strong").text,
        :online_date => ex.css(".offsite").text
      }}
    gugg_trim(@exh_hash)
  end

  def gugg_trim(array)   
    gugg_array.each{|ex|   
      if ex[:date].empty? 
        if ex[:ongoing_date].empty?
          ex[:date] = ex[:online_date]
        else
          ex[:date] = ex[:ongoing_date]
        end
      end
      ex.delete(:online_date)
      ex.delete(:ongoing_date)
      }
   
    @gugg_array
  end


=begin ### CODE HERE WORKS ###
  def self.bklyn
    # doc = Nokogiri::HTML(open(BKLYN_URL)).css(".exhibitions .col-md-6, .exhibitions .col-md-4")
    # test_html = File.read("resources/bk.html")
    # have to grab descriptions right here
    bk_doc = Nokogiri::HTML(open("resources/bk.html")).css(".exhibitions .col-md-6, .exhibitions .col-md-4")

# binding.pry
    bk_doc.collect {|ex| 
      {
    :url => ex.at("a")["href"],
    :title => ex.css("h2").text,
    :date => ex.css("h4").text.gsub(/\n( +)?/, "")
    }
    }
  end

  def self.brooklyn_exhibit(url)
    Nokogiri::HTML(open(url)).css(".exhibition-description").text.gsub(/\s{2,10}/, "\n\n")
  end

  def self.gugg
    gugg_doc = Nokogiri::HTML(open("resources/gugg.html")).css(".row-with-pic")
    
    gugg_array =gugg_doc.collect {|ex|
      {
        :url => "http://www.guggenheim.org#{ex.at("a")["href"]}", ##Guggs just appends something, so I need to build that in
        :title => ex.css("h4").text,
        :date => ex.css(".exh-dateline").text, 
        :ongoing_date => ex.css(".row-text strong").text,
        :online_date => ex.css(".offsite").text
      }
    }
  def gugg_trim(array)   
    gugg_array.each{|ex|   
      if ex[:date].empty? 
        if ex[:ongoing_date].empty?
          ex[:date] = ex[:online_date]
        else
          ex[:date] = ex[:ongoing_date]
        end
      end
      ex.delete(:online_date)
      ex.delete(:ongoing_date)

        }
    
    gugg_array
  end

  def self.gugg_exhibit(url)
    Nokogiri::HTML(open(url)).css("#main-three-center p").first.text
  end
=end



end

### SCRAPERS ####

## 1) MAIN EXHIBIT SCRAPER FOR EACH MUSEUM 

# 2) DETAIL EXHIBIT SCRAPER FOR EACH MUSEUM
##   --feed @url for each listing to the scraper
    # def get_detail(exhibit)
    #   @desc = Nokogiri::HTML(open(exhibit.url)).css(".exhibition-description").text
    #   puts @desc.gsub(/\s{2,10}/, "\n\n")
    #   ##CAN ATTACH GSUB TO SCRAPER, WILL PUTS CORRECTLY##
    # end

# 3) (FUTURE FUNCTIONALITY: ADD'L SCRAPERS FOR UPCOMING, ETC.)

####CSS notes for Exhibit details:
##BKLYN: @desc = Nokogiri::HTML(open(exhibit.url)).css(".exhibition-description").text.gsub(/\s{2,10}/, "\n\n")
    #   -- can just call puts on the above, drop the symbol





#### CONSTANTS ####
## Main Library Exhibits URL
# BKLYN_URL = "https://www.brooklynmuseum.org/exhibitions"
# GUGG_URL = "http://www.guggenheim.org/new-york/exhibitions/on-view"
# MET_URL = "http://www.metmuseum.org/exhibitions/current-exhibitions"

URL = {
        :bklyn => "resources/bk.html",#"https://www.brooklynmuseum.org/exhibitions",
        :gugg => "http://www.guggenheim.org/new-york/exhibitions/on-view",
        :met => "http://www.metmuseum.org/exhibitions/current-exhibitions"
      }

CSS = {
        :bk => {
                :main => ".exhibitions .col-md-6, .exhibitions .col-md-4",
                :desc => "css('.exhibition-description').text.gsub(/\s{2,10}/, '\n\n')"
               },
        :gugg => {
                 :main => ".row-with-pic",
                 :desc => "css.('#main-three-center p').first.text"
                 },
        :met => {}

      }



####  FUTURE FUNCTIONALITY ####

# 1) Way to call the right museum directly, w/o stopping for menu first
# 2) add'l museums
# 3) way to list museums by borough
# 4) way to display exhibits by borough


