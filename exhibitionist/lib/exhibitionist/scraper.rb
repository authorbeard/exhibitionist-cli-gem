##PLACE IN LIB/EXHIBITIONIST

class Scraper

  attr_accessor :blkyn, :gugg, :the_met


### MAIN SCRAPERS ###
### I created separate scrapers to make calling them a bit more intuitive for now. 
### 

  def bklyn
    doc = Nokogiri::HTML(open(BKLYN_URL)).css(".exhibitions .col-md-6, .exhibitions .col-md-4")
    doc.collect {|ex| 
      {
    :url => ex.at("a")["href"],
    :title => ex.css("h2").text,
    :date => ex.css("h4").text.gsub(/\n( +)?/, "")
    }
    }
    # @bklyn_current
    ## This builds an array of the current exhibitions. Now Museum needs to 
# binding.pry
    ## I can have CLI pass this directly into Museum.new along with name = input.
  end

  def gugg
    gugg = Nokogiri::HTML(open(GUGG)).css(".row-with-pic")
  end

  def the_met
    the_met = Nokogiri::HTML(open(MET))##NEED TO SELECT 2 TYPES
  end

### DETAIL SCRAPERS ###




end

### SCRAPERS ####

## 1) MAIN EXHIBIT SCRAPER FOR EACH MUSEUM 
BKLYN_URL = "https://www.brooklynmuseum.org/exhibitions"
# 2) DETAIL EXHIBIT SCRAPER FOR EACH MUSEUM
##   --feed @url for each listing to the scraper
# 3) (FUTURE FUNCTIONALITY: ADD'L SCRAPERS FOR UPCOMING, ETC.)





#### CONSTANTS ####

# 1) MAIN LIBRARY EXHIBIT URLS
# 2) LIBRARY EXHIBIT DETAIL URLS


####  FUTURE FUNCTIONALITY ####

# 1) Way to call the right museum directly, w/o stopping for menu first
# 2) add'l museums
# 3) way to list museums by borough
# 4) way to display exhibits by borough