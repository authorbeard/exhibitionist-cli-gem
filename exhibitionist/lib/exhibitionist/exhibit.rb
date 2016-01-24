class Exhibit
  attr_accessor :title, :location, :date, :desc, :url, :css

@@all = []

  def initialize(hash, museum, css)
    @location = museum
    @css = css
    hash.each{|k, v| 
      self.send(("#{k}="), v)}
    self.save

  end

  def save
    @@all << self
  end

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
