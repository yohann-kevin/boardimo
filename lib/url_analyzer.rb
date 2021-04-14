require "./db/database"
require "./lib/vannes_agency"
require "./lib/auray_agency"
require "./lib/questembert_agency"
require "./lib/data_serializer"

class UrlAnalyzer
  def initialize(params)
    @arg = params
  end

  def check_url
    analyse_url(@arg["arg"])
  end

  def analyse_url(url)
    name_site = url.tr(":/.", " ").split(" ")[1]
    agency_id = Database.new.find_agency_id_with_name(name_site)
    if agency_id == []
      new_site_detected
    else
      check_agency_id(agency_id[0].to_s.tr("[]", "").to_i)
    end
  end

  def new_site_detected
    puts "it's new site"
  end

  def check_agency_id(id)
    url = @arg["arg"]
    case id
    when 1
      check_title(VannesAgency.new.find_title(url))
    when 2
      check_title(AurayAgency.new.find_title(url))
    else
      check_title(QuestembertAgency.new.find_title(url))
    end
  end

  def check_title(title)
    house_counter = Database.new.find_house_with_title(title)
    house_counter[0].to_s.tr("[]", "").to_i.zero? ? detect_new_house : analyze_house(title)
  end

  def detect_new_house
    puts "this house is not in db"
  end

  def analyze_house(title)
    find_house_data(Database.new.find_house_id_with_title(title))
  end

  def find_house_data(id)
    house_data = Database.new.find_house_with_id(id[0].to_s.tr("[]", "").to_i)
    DataSerializer.new(house_data[0], @arg["arg"]).format_data
  end
end
# vannes
# UrlAnalyzer.new({ "arg" => "https://simply-home.herokuapp.com/house1.php" }).check_url
# auray
# UrlAnalyzer.new({ "arg" => "https://simply-home-cda.herokuapp.com/pages/1.php" }).check_url
# questembert
# UrlAnalyzer.new({ "arg" => "https://simply-home-group.herokuapp.com/questembert1.php" }).check_url
