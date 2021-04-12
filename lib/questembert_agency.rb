require "nokogiri"
require "open-uri"
require "pry"

class QuestembertAgency
  def initialize
    @url = "https://simply-home-group.herokuapp.com/"
    @url_location = "questembert"
    @files_extension = ".php"
    @data_page = {}
    @all_data = []
  end

  def find_data_agency
    index = 1
    counter = 0
    max_page = 15
    while index <= max_page
      if index > 5 && index < 11
        counter = 5
        @url_location = "maison_vannes_"
      elsif index > 10
        counter = 10
        @url_location = "sene"
      end
      html = URI.open("#{@url}#{@url_location}#{index - counter}#{@files_extension}")
      page = Nokogiri::HTML(html)
      hash_data(page)
      index += 1
    end
    puts @all_data[1]
  end

  def hash_data(page)
    @data_page = {
      "title" => page.css(".houseSingle .title").text,
      "size" => page.css(".houseSingle .surface").children.text,
      "location" => page.css(".houseSingle .city").children.text,
      "price" => page.css(".houseSingle .price").children.text,
      "energy" => page.css(".houseSingle .energetic").children.text,
      "foundation_years" => page.css(".houseSingle .year").children.text,
      "content" => page.css(".houseInfoBlock").children[5].text
    }
    @all_data << @data_page
  end
end

QuestembertAgency.new.find_data_agency
