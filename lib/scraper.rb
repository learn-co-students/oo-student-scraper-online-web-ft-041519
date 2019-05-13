require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_arr = []
    doc = Nokogiri::HTML(File.read(index_url))
    doc.css("div.student-card").each do |student|
      new_student = {
        :profile_url => student.css("a").attribute('href').value,
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text
      }
      student_arr << new_student
      new_student
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    link_arr = []
    doc = Nokogiri::HTML(File.read(profile_url))
    links = doc.css("div.social-icon-container")
    links.css("a").each { |link| link_arr << link.attribute('href').value }
    link_arr.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include? ("linkedin")
        student[:linkedin] = link
      else
        student[:blog] = link
      end
    end
    bio = doc.css("div.description-holder")
    student[:bio] = bio.css("p").text
    student[:profile_quote] = doc.css("div.profile-quote").text
    student
  end

end
