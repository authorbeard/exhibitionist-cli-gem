##PLACE IN LIB/EXHIBITIONIST

class Exhibit
  attr_accessor :title, :location, :date, :desc, :url

@@all = []

  def initialize(hash, location)
    @location = location
  # binding.pry
    hash.each{|k, v| self.send(("#{k}="), v)}

    self.save
  binding.pry

  end


  def description=(doc)
    ## --parses results of detail scrape
    ## --assigns appropriate text to @description
    ## --creates @detail_title, hands that on:
    ## --searches through @@all for @title == @detail_title, adds @description=>
    ## --returns that hash to the CLI to format/print
    ## --shouldn't need ||= b/c should only be called after an exhibit has been displayed (no other way 
    ##   to choose it, and it's created before it's displayed )
    ## --actually might need this, in case someone selects "top events," then wants to see all for a 
    ##     specific museum or see all events

  end





  def save
    @@all << self
  end


### Class Methods ###

  def self.all
    @@all
  end

  def self.list_all
    ex_array = []
    @@all.each{|ex|
      ex_array << "#{ex.title} -- Museum: #{ex.location.name}"}

    puts ex_array
   
  end





end


###NOTES
=begin

###  FUTURE FUNCTIONALITY ###

--sort exhibits by date ending
--sort exhibits by upcoming



=end
