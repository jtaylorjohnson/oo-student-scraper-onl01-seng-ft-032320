require 'open-uri'
require 'pry'
require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    
    html = Nokogiri::HTML(open(index_url))
    
    html.css(".student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css("h4").text
      student_info[:location] = student.css("p").text
      student_info[:profile_url] = student.css("a").attribute("href").value
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    
    html = Nokogiri::HTML(open(profile_url))
binding.pry
    html.css("social-icon-container").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end
  end
# Twitter URL, LinkedIn URL, GitHub URL, 
# blog URL, profile quote, and bio
# html = Nokogiri::HTML(open(https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html))
# html.css("social-icon-container").first.value
end
html.css("d.social-icon-container a").first
html.css("div.main-wrapper.profile .social-icon-container a").first.attribute("href").value