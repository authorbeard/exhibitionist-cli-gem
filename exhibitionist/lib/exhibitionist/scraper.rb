class Scraper
  attr_accessor :blkyn, :gugg, :the_met

  
  def self.scrape(url, css)
    Nokogiri::HTML(open(url)).css(css)
# binding.pry
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
# binding.pry

    }
    self.trim_gugg(guggs)
    # guggs
# binding.pry
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
  # binding.pry 
    # @gugg_array
  end

  def self.parse_met(nodeset)
    nodeset.collect {|ex|

      ##code this later
      }
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

URL = {
        :bklyn => "resources/bk.html",#"https://www.brooklynmuseum.org/exhibitions",
        :gugg => "resources/gugg.html",#"http://www.guggenheim.org/new-york/exhibitions/on-view",
        :met => "http://www.metmuseum.org/exhibitions/current-exhibitions"
      }

CSS = {
        :bk => {
                :main => ".exhibitions .col-md-6, .exhibitions .col-md-4",
                :desc => ".exhibition-description"
               },
        :gugg => {
                 :main => ".row-with-pic",
                 :desc => "#main-three-center p"
                 },
        :met => {}

      }

MUSEUMS = [
          { :name => "brooklyn",
            :url => "resources/bk.html",#"https://www.brooklynmuseum.org/exhibitions",
            :main_css => ".exhibitions .col-md-6, .exhibitions .col-md-4",
            :desc_css => ".exhibition-description"
          },

          { :name => "guggenheim",
            :url => "resources/gugg.html",#"http://www.guggenheim.org/new-york/exhibitions/on-view",
            :main_css => ".row-with-pic",
            :desc_css => "#main-three-center p"
          }

         ]


####  FUTURE FUNCTIONALITY ####

# 1) Way to call the right museum directly, w/o stopping for menu first
# 2) add'l museums
# 3) way to list museums by borough
# 4) way to display exhibits by borough


