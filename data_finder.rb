require "pry"
require "./lib/auray_agency"
require "./lib/vannes_agency"
require "./lib/questembert_agency"
require "./lib/data_sanitizer"
require "./db/database"

class DataFinder
  def initialize
    @auray_data = AurayAgency.new.find_data_agency
    @vannes_data = VannesAgency.new.find_data_agency
    @questembert_data = QuestembertAgency.new.find_data_agency
    @database = Database.new
    @agency_location = ["auray", "vannes", "questembert"]
  end

  def find_data
    data_auray = DataSanitizer.new(@auray_data).check_data
    post_data(data_auray, @agency_location[0])
    data_vannes = DataSanitizer.new(@vannes_data).check_data
    post_data(data_vannes, @agency_location[1])
    data_questembert = DataSanitizer.new(@questembert_data).check_data
    post_data(data_questembert, @agency_location[2])
  end

  def post_data(data, location_agency)
    data.each do |el|
      data_city_id = @database.find_city_id(el["location"])
      data_agency_id = @database.find_agency_id(location_agency)
      @database.add_data_house(el, data_city_id, data_agency_id)
    end
  end
end

DataFinder.new.find_data
