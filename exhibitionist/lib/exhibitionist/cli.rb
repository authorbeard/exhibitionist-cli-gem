class ExhibitionistCli
  attr_reader :museums, :current 

  MUSEUMS = [
          { :name => "brooklyn",
            :url => "https://www.brooklynmuseum.org/exhibitions", #"resources/bk.html",
            :main_css => ".exhibitions .col-md-6, .exhibitions .col-md-4",
            :desc_css => ".exhibition-description"
          },

          { :name => "guggenheim",
            :url => "http://www.guggenheim.org/new-york/exhibitions/on-view", #"resources/gugg.html",
            :main_css => ".row-with-pic",
            :desc_css => "#main-three-center p"
          }

         ]

  def initialize
    @museums = []
    top_menu
  end

  def top_menu
    
    system("clear")
    puts "Hiya. At the moment, here's what you can do:\n\n"
    display_museums
    puts "#{MUSEUMS.size + 1}. See everything so far."
    puts "(there's more functionality to come)"
    puts "Or type q to quit."
    input = gets.strip
      if input == "q"
        farewell
      elsif input.to_i == 0
        huh?
      elsif input.to_i > MUSEUMS.size
        system("clear")
        fetching_message
        
        MUSEUMS.each{|m|
          @current = Museum.new(m)
        
        current.display_exhibits}
        detail_menu
        # under_construction
      else 
        fetching_message
        @current = Museum.new(MUSEUMS[input.to_i - 1])
        @museums << @current
        system("clear")
        @current.display_exhibits
        detail_menu
      end 
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
        @exhibit = @current.exhibits[input.to_i - 1] 
        @exhibit.desc || @current.get_exhib(@exhibit)
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
    puts "\n\n\n\nFine. Go watch TV or get drunk, you philistine.\n\n\n\n\n"
    sleep 1
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
end
