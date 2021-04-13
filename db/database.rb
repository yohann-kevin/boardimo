require "sqlite3"
require "pry"

class Database
  def initialize
    @db = SQLite3::Database.open "./db/boardimo.db"
  end

  def find_all_city
    @db.execute "SELECT * FROM city"
    # puts city
  end

  def find_city_id(city_name)
    @db.execute "SELECT id FROM city WHERE name = '#{city_name}'"
    # puts city_id
  end

  def find_agency_id(agency_location)
    @db.execute "SELECT id FROM agency WHERE location = '#{agency_location}'"
    # puts agency_id
  end

  def find_all_agency
    @db.execute "SELECT * FROM agency"
    # puts agency[1][1]
  end

  def add_data_house(data, city_id, agency_id)
    puts data["title"]
    data["city_id"] = city_id.flatten.first
    data["agency_id"] = agency_id.flatten.first
    #{data['title']}, #{data['images']}, #{data['size']}, #{data['location']}, #{city_id}, #{data['price']}, #{data['energy']}, #{data['foundation_years']}, #{data['content']}, #{agency_id}
    @db.execute("INSERT OR IGNORE INTO House VALUES(:id, :title, :images, :size, :location, :city_id, :price, :energy, :foundation_years, :content, :agency_id)", data.transform_keys(&:to_sym))
  end
end

# Database.new.find_city_id("vannes")
# Database.new.find_agency_id("vannes")
