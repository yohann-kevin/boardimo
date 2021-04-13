require "nokogiri"
require "open-uri"
require "pry"

class VannesAgency
  def initialize
    @url = "https://simply-home.herokuapp.com/house"
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
    return @all_data
  end

  def hash_data(page)
    @data_page = {
      "title" => page.css("#titleSingleArticle").children[1].text,
      "images" => page.css("#singleArticleImage img").attr("src").value,
      "size" => page.css("#singleArticle .size").text,
      "location" => page.css("#singleArticle .location").text,
      "price" => page.css("#singleArticle .price").text,
      "energy" => page.css("#singleArticle .energy").text,
      "foundation_years" => page.css("#singleArticle .foundation-years").text,
      "content" => page.css("#singleArticle #articleContent").text
    }
    @all_data << @data_page
  end
end

VannesAgency.new.find_data_agency
