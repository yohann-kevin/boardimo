require "pry"
require "./lib/auray_agency.rb"
require "./lib/vannes_agency.rb"
require "./lib/questembert_agency.rb"
require "./lib/data_sanitizer.rb"
require "./db/database.rb"

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
  end

  def post_data(data, location_agency)
    data_city_id = @database.find_city_id(data[0]["location"])
    puts data_city_id
    data_agency_id = @database.find_agency_id(location_agency)
    puts data_agency_id
    @database.add_data_house(data[0], data_city_id, data_agency_id)
  end
end

DataFinder.new.find_data
