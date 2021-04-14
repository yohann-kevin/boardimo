require "tilt"
require "erb"
require "json"

require "./lib/url_analyzer"

class Controller
  def initialize
    @data_house = {}
  end

  # def index
  #   template = Tilt.new("./views/index.html.erb")
  #   [200, { "Content-Type" => "text/html" }, template.render(
  #     self,
  #     basket: @basket_ui,
  #     result: @result
  #   )]
  # end

  # def add(params)
  #   reduction = Reduction.instance
  #   price = Price.instance(reduction)
  #   @result = price.get_price(params.values[0], @money_format, @format_change)
  #   @format_change = false
  #   @basket_ui = price.find_basket
  #   [302, { "Location" => "/" }, []]
  # end

  # def select(params)
  #   @format_change = true if params != @money_format && @money_format != ""
  #   @money_format = params.values[0]
  #   [302, { "Location" => "/" }, []]
  # end

  # def not_found
  #   template = Tilt.new("./views/not_found.html.erb")
  #   [404, { "Content-Type" => "text/html" }, template.render]
  # end

  # def post_data
  #   fruits = {}
  #   data = @toto.find_products
  #   i = 0
  #   while i < data&.length
  #     fruits [data[i][1].to_s.downcase] = data[i][2]
  #     i += 1
  #   end
  #   products = { "products" => fruits, "results" => @result, "basket" => @basket_ui, "symbol" => @all_symbol }
  #   [200, { "Content-Type" => "application/json" }, products.to_json]
  # end

  def analyze_data_entry(params)
    @data_house = UrlAnalyzer.new(params).check_url
    [302, { "Location" => "/" }, []]
  end

  def init
    puts "plop"
  end
end
