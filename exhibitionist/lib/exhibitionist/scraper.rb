##PLACE IN LIB/EXHIBITIONIST

class Scraper

  attr_accessor :blkyn, :gugg, :the_met


### MAIN SCRAPERS ###
### I created separate scrapers to make calling them a bit more intuitive for now. 
### 

  def bklyn
    @bklyn = Nokogiri::HTML(open(BKLYN_URL)).css("h2 a")
    
# binding.pry
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
# 3) (FUTURE FUNCTIONALITY: ADD'L SCRAPERS FOR UPCOMING, ETC.)





#### CONSTANTS ####

# 1) MAIN LIBRARY EXHIBIT URLS
# 2) LIBRARY EXHIBIT DETAIL URLS


####  FUTURE FUNCTIONALITY ####

# 1) Way to call the right museum directly, w/o stopping for menu first
# 2) add'l museums
# 3) way to list museums by borough
# 4) way to display exhibits by borough