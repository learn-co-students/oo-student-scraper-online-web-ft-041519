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
    end
    binding.pry
    student_arr
  end

  def self.scrape_profile_page(profile_url)

  end

end
