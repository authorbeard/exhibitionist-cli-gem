class ExhibitionistCli
  attr_reader :museums, :current 

  def initialize
    @museums = []
    top_menu
  end

  def top_menu
    
    system("clear")
    puts "Hiya. At the moment, here's what you can do:\n\n"
    display_museums

    # puts "1. See the Brooklyn museum's current exhibitions."
    # puts "2. See the Guggenhim's current exhibitions."
    puts "#{MUSEUMS.size + 1}. See everything so far."
    puts "(there's more functionality to come)"
    puts "Or type q to quit."
    input = gets.strip
      if input == "q"
        farewell
      elsif input.to_i == 0
        huh?
      elsif input.to_i > MUSEUMS.size
        under_construction
      else 
        
        # puts "\nWe got the Brooklyn Museum, The Guggenheim and The Met right now. "
        # puts "(type Brooklyn, Guggenheim or Met)"
        # museum = gets.strip.downcase
        #   case museum
        #   when "brooklyn"
              fetching_message
  # binding.pry
  
              # @brooklyn||= Museum.build("brooklyn", URL[:bklyn], CSS[:bk])
              @current = Museum.new(MUSEUMS[input.to_i - 1])
              @museums << @current
  #             @raw = Scraper.scrape(URL[:bklyn], CSS[:bk][:main])
  #             @exh_array = Scraper.parse_bk(@raw)
  # binding.pry
  #             @museum = Museum.new(@exh_array, "brooklyn", CSS[:bk])
              @current.display_exhibits
              detail_menu
      end

              
            
            # sleep 2
            # top_menu

          # when "guggenheim"
            # fetching_message
            # @raw = Scraper.scrape(URL[:gugg], CSS[:gugg][:main])
            # @exh_array = Scraper.parse_gugg(@raw)
            # @museum = Museum.new(@exh_array, museum, CSS[:gugg])
            # @museum.display_exhibits
            # detail_menu
          # else
          #   huh?
          # end

          # when "met"
          #   fetching_message
              # input = Museum.new(Scraper.new.the_met, input)
              # input.display_exhibits(@exhibits)
          #   top_menu

          # end

        
              # fetching_message
              # @gugg||= Museum.build("guggenheim", URL[:gugg], CSS[:gugg]) 
              # @museums << @gugg
              # @current = @gugg
              # # @raw = Scraper.scrape(URL[:gugg], CSS[:gugg][:main])
              # # @exh_array = Scraper.parse_gugg(@raw)
              # # @museum = Museum.new(@exh_array, "guggenheim", CSS[:gugg])
              # @current.display_exhibits
              # detail_menu
        # under_construction
        
          
  end


  def detail_menu
    puts "\n\nEnter a number to fetch a detailed description.\n\n"
    puts "Or:"
    puts "--m for the main menu"
    puts "--q to quit"
    input = gets.strip.downcase

      case input.to_i
      when 0 
        if input == "m"
          top_menu
        elsif input == "q"
          farewell
        else
          huh?
        end
      else
  binding.pry
        @exhibit = @current.exhibits[input.to_i - 1]
binding.pry 
        @exhibit.desc || @current.get_exhib(@exhibit)
# binding.pry
        # @museum.get_exhib(@exhibit, @exhibit.url, @museum.css[:desc])
        system("clear")
        puts "#{@exhibit.title}\n\n #{@exhibit.desc}"
        go_back?         
      end
  end

  def go_back?
    puts "\n\nWhat now?"
    puts "--b to go back to the list"
    puts "--m for main menu"
    puts "--q to quit"
    what_now = gets.strip.downcase
      case what_now 
      when "b"
        @current.display_exhibits
        detail_menu
      when "m"
        top_menu
      when "q"
        farewell
      else
        huh?
        go_back?
      end

  end


  def fetching_message
    puts "\nGotcha. Gimme a second while I ask around.\n"
  end

  def huh?
    puts "I didn't get that. Let's try again"
    sleep 1
    system("clear")
    top_menu
  end

  def farewell
    system("clear")
    puts "Fine. Go watch TV or get drunk, you philistine.\n\n"
    # sleep 1
  end

  def under_construction
    puts "\n\nWelp, this ain't actually built yet. Art takes time."
    puts "But if yer in a hurry for some art, type 'now'"
    now = gets.strip.downcase
      if now == "now"
        %x`open -a Safari http://www.dogsplayingpoker.org/gallery/coolidge/img/a_friend_in_need.jpg`
        sleep 1
        top_menu
      elsif now == 'q'
        farewell
      else
        puts "Okay, check back later."
        sleep 1
        top_menu
      end
  end

  def display_museums
    MUSEUMS.each_with_index{|m, i|
      puts "#{i+1}. See the #{m[:name].capitalize} Museum's current exhibitions"
    }
  end

  # def list_museums
  #   mus_array = []
  #   @@all.each_with_index{|m, i| 
  #     mus_array << "#{i+1}. #{m.name.capitalize} Museum"}
  #   puts mus_array 
  # end


end



=begin

1) welcomes user, calls first menu
2) takes input of museum name and: 
  --calls that scraper
  --Instantiates Museum, which builds exhibits
  --displays events for that museum
  --calls details sub-menu
3) add "top events" option
  --calls each scraper but adds .first

3) needs sub-menus:
  --



=end