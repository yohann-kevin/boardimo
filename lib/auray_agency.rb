require "nokogiri"
require "open-uri"
require "pry"

class AurayAgency
  def initialize
    @url = "https://simply-home-cda.herokuapp.com/pages/"
    @files_extension = ".php"
    @data_page = {}
    @all_data = []
  end

  def find_data_agency
    index = 1
    max_page = 15
    while index <= max_page
      html = URI.open("#{@url}#{index}#{@files_extension}")
      page = Nokogiri::HTML(html)
      hash_data(page)
      index += 1
    end
    puts @all_data[14]
  end

  def hash_data(page)
    @data_page = {
      "title" => page.css("#apropos h1").text,
      "size" => page.css("#single-ad-description").children[1].children[1].text,
      "location" => page.css("#single-ad-description").children[1].children[3].text,
      "price" => page.css("#single-ad-description").children[1].children[5].text,
      "energy" => page.css("#single-ad-description").children[1].children[7].text,
      "fundation_years" => page.css("#single-ad-description").children[1].children[9].text,
      "content" => page.css("#single-ad-description").children[3].text
    }
    @all_data << @data_page
  end
end

AurayAgency.new.find_data_agency
