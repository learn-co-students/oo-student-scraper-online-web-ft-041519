require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(students_array)
    # iterates through each element of the array
    students_array.each do |student|
      # creates a new student from the passed hash
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

end
#
# stud_hash = {:name => "Jimmers", :location => "Round Lake", :profile_quote => "'Pikachu' - Pikachu"}
#
# array = [stud_hash, stud_hash]
#
# stud = Student.create_from_collection(array)
# puts Student.all.first.name
