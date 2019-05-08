require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    # The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url  
    
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
    # The return value of this method should be a hash in which the key/value pairs describe an individual student. Some students don't have a twitter or some other social link. Be sure to be able to handle that. Here is what the hash should look like
    
    doc = Nokogiri::HTML(open(profile_url))   
    student_profile = {}
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content div.description-holder p").text
      
    doc.css("div.social-icon-container a").map do |e| 
      if e.attribute("href").value.include?("twitter")
        student_profile[:twitter] = e.attribute("href").value
      elsif e.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = e.attribute("href").value
      elsif e.attribute("href").value.include?("github")
        student_profile[:github] = e.attribute("href").value
      else
        student_profile[:blog] = e.attribute("href").value
      end
    end
    student_profile
  end


end

