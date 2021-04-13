require "pry"
require "./lib/auray_agency.rb"
require "./lib/vannes_agency.rb"
require "./lib/questembert_agency.rb"
require "./lib/data_sanitizer.rb"

class DataFinder
  def initialize
    @auray_data = AurayAgency.new.find_data_agency
    @vannes_data = VannesAgency.new.find_data_agency
    @questembert_data = QuestembertAgency.new.find_data_agency
  end

  def find_data
    DataSanitizer.new(@auray_data).check_data
    # DataSanitizer.new(@vannes_data).check_data
    # DataSanitizer.new(@questembert_data).check_data
    # puts @auray_data.length
  end
end

DataFinder.new.find_data
