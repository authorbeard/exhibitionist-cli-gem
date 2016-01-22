class Museum
  attr_accessor :name, :title, :location, :date, :description, :url, :exhibits

  @@all = []

=begin
TODO:
1) associate museum exibits with exhibit objects (prob in build_exhibits)
 
=end

  def initialize(array, name)
    @name = name
    build_exhibits(array)
    self.save
    # sleep 1
  # binding.pry
    
  # binding.pry

  end

  def display_exhibits(array)
# binding.pry
    system("clear")
    puts "Current exhibits for #{@name.capitalize} Museum:\n----------------------\n"
    self.exhibits.each_with_index{|ex, i|
      puts "#{i+1}. #{ex.title} \n   #{ex.date}"}

  ## This probably needs to be called from CLI so it doesn't mistakenly display these exhibits
  ## when someone just chooses one of the other options. 
  end


  def build_exhibits(exhibit_array)
    @exhibits = []
    exhibit_array.each{|ex| 
      @exhibits << Exhibit.new(ex, self)
    }


  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.list_museums
    mus_array = []
    @@all.each_with_index{|m, i| 
      mus_array << "#{i+1}. #{m.name} Museum"}
    puts mus_array 
  end


end


=begin
 
needs to initialize with a museum name 
needs an array of exhibits
needs to create event hashes
needs to save those hashes to the @exhibits array



=end