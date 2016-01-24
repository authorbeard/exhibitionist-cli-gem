class Scraper
  attr_accessor :blkyn, :gugg, :the_met
 
  def self.scrape(url, css)
    Nokogiri::HTML(open(url)).css(css)
  end


### PARSERS HERE ####

  def self.parse_bk(nodeset)
    nodeset.collect{|ex| 
      {
        :url => ex.at("a")["href"],
        :title => ex.css("h2").text,
        :date => ex.css("h4").text.gsub(/\n( +)?/, "")
      }}
  end


  def self.parse_gugg(nodeset)
    guggs = nodeset.collect {|ex| 
      {
        :url => "http://www.guggenheim.org#{ex.at("a")["href"]}", 
        :title => ex.css("h4").text,
        :date => ex.css(".exh-dateline").text, 
        :ongoing_date => ex.css(".row-text strong").text,
        :online_date => ex.css(".offsite").text
      }
    }
    self.trim_gugg(guggs)
  end

  def self.trim_gugg(array)   
    array.each{|ex|   
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
  end


  def self.parse_met(nodeset)
    nodeset.collect {|ex|

      ##code this later
      }
  end
end

# URL = {
#         :bklyn => "resources/bk.html",#"https://www.brooklynmuseum.org/exhibitions",
#         :gugg => "resources/gugg.html",#"http://www.guggenheim.org/new-york/exhibitions/on-view",
#         :met => "http://www.metmuseum.org/exhibitions/current-exhibitions"
#       }

# CSS = {
#         :bk => {
#                 :main => ".exhibitions .col-md-6, .exhibitions .col-md-4",
#                 :desc => ".exhibition-description"
#                },
#         :gugg => {
#                  :main => ".row-with-pic",
#                  :desc => "#main-three-center p"
#                  },
#         :met => {}

#       }

####  FUTURE FUNCTIONALITY ####

# 1) Way to call the right museum directly, w/o stopping for menu first
# 2) add'l museums
# 3) way to list museums by borough
# 4) way to display exhibits by borough


