class ExhibitionistCli

  def initialize
    puts "Hello. Which exhibits would you like me to fetch?\n\n"
    top_menu

  end

  def top_menu
    puts "1. What's on at your favorite museum"
    puts "2. Top exhibits open right now"
    puts "3. All exhibits open right now"
    puts "And type q at any time to quit."
    input = gets.strip
      case input
      when "1"
        puts "We got the Brooklyn Museum, The Guggenheim and The Met right now. "
        puts "(type Brooklyn, Guggenheim or Met)"
        museum = gets.strip.downcase
          case museum
          when "brooklyn"
            fetching_message

            top_menu

          when "guggenheim"
            fetching_message
            top_menu

          when "met"
            fetching_message
            top_menu

          else
            puts "I didn't get that. Let's try again"
            sleep 1
            top_menu

          end

      when "2"
        under_construction

      when "3"
        under_construction

      when "q"
          farewell

      end

  end


  def detail_menu
    puts "at some point, you'll be able to select an exhibit from here to get its details"
    # --This needs to be dynamic, but since display will be each_with_index (probs)
    #   can prob just use "input.to_i" and feed that back into whatever array is used to 
    #   generate the display options
  end


  def fetching_message
    puts "Getting your exhibits now. This might take a second."
  end

  def farewell
    system("clear")
    puts "Fine. Go watch TV or get drunk, you philistine.\n\n"
    sleep 1
  end

  def under_construction
    puts "Art takes time and this feature ain't built yet."
    puts "But if yer in a hurry for some art, type 'now'"
    now = gets.strip.downcase
      if now == "now"
        %x`open -a Safari http://www.dogsplayingpoker.org/gallery/coolidge/img/a_friend_in_need.jpg`
      else
        puts "Okay, check back later."
        top_menu
      end
  end



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