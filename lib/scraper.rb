
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_slug)
    hash = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        hash[:linkedin] = link
      elsif link.include?("github")
        hash[:github] = link
      elsif link.include?("twitter")
        hash[:twitter] = link
      else
        hash[:blog] = link
      end
    end 
    hash[:profile_quote] = profile_page.css("div.profile-quote").text if profile_page.css("div.profile-quote")
    hash[:bio] = profile_page.css(".bio-block.details-block .description-holder p").text if profile_page.css(".bio-block.details-block .description-holder p")
    hash
  end
end
    
