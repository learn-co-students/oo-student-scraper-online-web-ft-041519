class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key,value| self.send(("#{key}="),value)}
        @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|  #iterates over the array lands on a student
      Student.new(student)            #creates new student with |student from scraper|
  end
end

  def add_student_attributes(attributes_hash)
  attributes_hash.each{|key,value| self.send("#{key}=",value)}
  end

  def self.all
    @@all
  end
end
