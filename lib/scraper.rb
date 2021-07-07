require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = [] 
    
    doc.css(".student-card").each do |student| 
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value 
      }
      students << student_hash 
    end 
    students 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))   
    student_profile = {}

    doc.css("div.social-icon-container a").map do |x| 
      if x.attribute("href").value.include?("twitter")
        student_profile[:twitter] = x.attribute("href").value
      elsif x.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = x.attribute("href").value
      elsif x.attribute("href").value.include?("github")
        student_profile[:github] = x.attribute("href").value
      else
        student_profile[:blog] = x.attribute("href").value
      end
    end
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content div.description-holder p").text
    student_profile
  end
end

