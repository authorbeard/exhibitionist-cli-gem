class Museum
  attr_accessor :name, :title, :location, :date, :description, :url, :events

  def initialize(hash, name="brooklyn")
    @name = name
    @events = []
    puts "This museum is called #{@name.capitalize}"
    puts "It has this many events: #{@events.size}"
    puts "here's where I'll call #event_builder"
    puts "(you won't see it, but I'll also wind up with a bunch of Events objects that know who owns them.)"
    puts "\n\nLet's see if we got the hash in here correctly:\n\n"
    @bklyn.each{|a| puts a.text}
    sleep 1
    puts "now back to the CLI."


  end





end


=begin
 
needs to initialize with a museum name 
needs an array of events
needs to create event hashes
needs to save those hashes to the @events array



=end