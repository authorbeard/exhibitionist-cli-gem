# Exhibitionist

Exhibitionist gets details on current exhibitions from art museums. As of first release, this only works for the Brooklyn Museum and the Guggenheim. 

See below for instructions on adding a new museum to the current code. 

### Wanna add a museum?

To add a museum, you need to do a couple things (at least as of right now): 

  1) Add your museum to the MUSEUMS constant array:  
      -- URL for the main list of exhibitions  
      -- the CSS for Nokogiri to sort through and select the bits of info you want (see the attr_accessors in lib/exhibitionist/museum.rb for guidance)  
      -- the CSS for getting the exhibition's description from each exhibition's page  

  2) The main scraper usually isn't good enough. This is where Scraper#parse comes in:  
      -- create a parse method that deals with whatever Nokogiri::HTML(open(URL)).css(CSS) returns. Name it appropriately.  
      -- Sometimes, you need to go even further. I just created a helper method to clean up the Guggenheim's listings, then called that from within the parser:  

      {% highlight ruby %}
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
      {% endhighlight %}
      --go to Museum#parse, add another term to the case statement to select the right museum  

  3) Then go down to Museum#get_exhib and do the same thing for each exhibition's description.   

### How this works: 

1) The CLI gets called from the executable. It builds the menu based on how many museums have been added.
2) #top_menu generates the list of current museums.  
3) The user's input selects the the hash containing the museum's name, URL & CSS sets, then hands them on to the Museum class.  
4) Museum#initialize builds the museum, which builds the exhibits.  
5) top_menu then slaps on #detail_menu, which lets a user choose which event to scrape and lets the user navigate back to the museum's list of exhibitions or all the way back to the top menu. 


### Current issues: 

1) I don't think either top_menu or detail_menu checks first to see if the pages have already been scraped. This makes things slower.  
2) There's not much to do with the listings yet, other than look at text descriptions.  
3) There's only the two museums. 



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exhibitionist'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exhibitionist

## Usage

This has a pretty straightforward CLI built in. Just run bin/exhibitionist and the menu will walk you through it. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/authorbeard/exhibitionist. This is where they put in some boilerplate about code of conduct stuff, but I can't imagine that being necessare. Feel free to read mine, but you won't find it very useful. 


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

