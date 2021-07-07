require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []

    doc = Nokogiri::HTML(open(index_url))
      doc.css(".student-card a").each do |student_card|
        st_name = student_card.css(".student-name").text
        st_location = student_card.css(".student-location").text
        st_profile_url = "#{student_card.attr('href')}"
        scraped_students << {name: st_name, location: st_location, profile_url: st_profile_url}
      end

  scraped_students

  end
  
  def self.scrape_profile_page(profile_url)
    
    profile_page = Nokogiri::HTML(open(profile_url))
    
    prof_link = {}
    tweet = nil
    linkedin = nil
    github = nil
    blog = nil
    
    profile_page.css('.social-icon-container a').each do |x| 

      if x.attr('href').include?("twitter")
        tweet = x.attr('href')
        prof_link[:twitter] = tweet
        next 
      elsif x.attr('href').include?("linkedin")
        linkedin = x.attr('href')
        prof_link[:linkedin] = linkedin
        next
      elsif x.attr('href').include?("github")
        github = x.attr('href')
        prof_link[:github] = github
        next
      else
        blog = x.attr('href')
        prof_link[:blog] = blog
        next
      end 
      
    end 
    
    prof_link[:profile_quote] = profile_page.css('.profile-quote').text
    prof_link[:bio] = profile_page.css(".description-holder p").text
    
    prof_link
    
  end

end
