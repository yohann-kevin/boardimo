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
    return @all_data
  end

  def hash_data(page)
    @data_page = {
      "title" => page.css(".houseSingle .title").text,
      "images" => page.css(".houseSingle .houseImg img").attr("src").value,
      "size" => page.css(".houseSingle .surface").children.text.tr("Surface :", ""),
      "location" => page.css(".houseSingle .city").children.text.delete_prefix("Ville :"),
      "price" => page.css(".houseSingle .price").children.text.tr("Prix :", ""),
      "energy" => page.css(".houseSingle .energetic").children.text.delete_prefix("Classe énergie :"),
      "foundation_years" => page.css(".houseSingle .year").children.text.tr("Année :", ""),
      "content" => page.css(".houseSingle .houseDescription").text
    }
    @all_data << @data_page
  end
end

QuestembertAgency.new.find_data_agency
