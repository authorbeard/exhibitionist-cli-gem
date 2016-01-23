# Exhibitionist

Exhibitionist gets details on current exhibitions from art museums. As of first release, this only works for the Brooklyn Museum and the Guggenheim. 

See below for instructions on adding a new museum to the current code. 

### Wanna add a museum?

To add a museum, you need to do a couple things (at least as of right now): 
  1) Add the URL for its main exhibitions page to the URL constant contained in lib/exhibitionist/scraper.rb. Pick your own method of establishing 
  2) Finding the right CSS selectors is a pain. So only do it once and save into the relevant locations:
    a. the CSS constant hash in lib/exhibitionist/scraper
      :main =>
      :desc =>
    b. the parser (see #4 below)
  3) Add another item to lib/exhibitionist/cli #top_menu, first in the display up top, then add a "when"
  statement down below. 
    --these need to follow the same pattern as the existing hashes: one for the main, one for exhibits
  4) This is the next pain. You'll probably need to screw around with whatever you scrape. I broke this down into two parts: 
    a) scraper.parse_[MUSEUM] takes in the nodeset you scraped and assigns all the right keys. Sometimes you need additional help (like with .parse_gugg, which has a trim method to account for the funky way they list dates on their website)
    b) Museum.get_exhib, which cleans up the formatting and/or further digs into the CSS to get the right stuff (the Brooklyn Museum description just needed formatting, but the Guggenheim needed further drilling to return the right text). 

### How this works: 

The CLI handles the first sort, getting museums to build themselves by feeding in the correct URL and passing the correct museum's CSS set. 
--Museums then build their own Exhibit objects:
  a) Exhibit.initialize populates exhibit hash & saves it
  b) Exhibit also takes in the CSS to select relevant exhibit description text, though for now this is just so each Exhibit object knows a bit about itself. 
  c) Associates Museums & Exhibits using has_many_owned_by_one

--the CLI#detail_menu is what handles scraping event descriptions:
  a) @current is reset each time a museum is selected. It's set equal to the museum object
  b) The menu uses user input to select an exhibit object from the museum's array. 
  c) The first time through (during each CLI session), it calls on that Museum object's #get_exhib method to populate the @desc for that Exhibit object, handing it the correct CSS from the hash passed through when it was initialized. 
  d) The next time through, it should just rad the @desc attribute for the relevant object. 

--the user can do this for each Exhibition listed on the museum's website or return and select the next museum

### Current issues: 

1) No way to list all of the exhibits. 
2) Need to generate list of museums upon initialization rather than hard-coding it. 
3) Need to make selection less dependent on hard-coding.
4) Cannot browse through all relevant exhibition pages. 
5) Too many steps needed to add a museum. 
6) Can't do anything with the info (no email, add to ical, etc.)
7) No tests written (ASS-BACKWARDS, I KNOW)




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

