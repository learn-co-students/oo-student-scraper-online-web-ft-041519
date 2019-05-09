require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@students = []

  def self.students
    @@students
  end

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    index.css(".student-card").each do |s|
      @@students << {
        name: s.css(".student-name").text,
        location: s.css(".student-location").text,
        profile_url: s.css("a")[0]["href"]
      }
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)
    Hash.new.tap do |student|
      profile = Nokogiri::HTML(open(profile_url))
      profile.css(".social-icon-container a").each do |element|
        url = element["href"]
        case url
        when /twitter/
          student[:twitter] = url
        when /linkedin/
          student[:linkedin] = url
        when /github/
          student[:github] = url
        when /youtube/
          student[:youtube] = url
        else
          student[:blog] = url
        end
        #binding.pry
      end
      student[:profile_quote] = profile.css(".profile-quote").text
      student[:bio] = profile.css(".description-holder p").text
    end
  end
end
