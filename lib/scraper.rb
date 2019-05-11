require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_index_pg = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      new_hsh = {}
      new_hsh[:name] = card.css(".student-name").text
      new_hsh[:location] = card.css(".student-location").text
      new_hsh[:profile_url] = card.css("a").attribute("href").value
      scraped_index_pg << new_hsh
    end
    scraped_index_pg
  end

  def self.scrape_profile_page(profile_url)
    new_hsh = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.social-icon-container a").each do |x|
      if x.attribute("href").value.include?("twitter")
        new_hsh[:twitter] = x.attribute("href").value
      elsif x.attribute("href").value.include?("linkedin")
        new_hsh[:linkedin] = x.attribute("href").value
      elsif x.attribute("href").value.include?("github")
        new_hsh[:github] = x.attribute("href").value
      else
        new_hsh[:blog] = x.attribute("href").value
      end
    end
    new_hsh[:profile_quote] = doc.css("div.profile-quote").text
    new_hsh[:bio] = doc.css("div.description-holder p").text
    new_hsh
  end

end