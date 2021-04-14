require "tilt"
require "erb"
require "json"

require "./lib/url_analyzer"
require "./lib/house_analyzer"

class Controller
  def initialize
    @data_house = {}
    @analyze = {}
  end

  def analyze_data_entry(params)
    param = { "arg" => "https://simply-home.herokuapp.com/house1.php" }
    @data_house = UrlAnalyzer.new(param).check_url
    [302, { "Location" => "/" }, []]
  end

  def init
    @analyze = HouseAnalyzer.new(@data_house).find_analyze
    data = { "results" => @data_house, "analyze" => @analyze }
    [200, { "Content-Type" => "application/json" }, data.to_json]
  end
end
