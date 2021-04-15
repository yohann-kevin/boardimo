require "sqlite3"
require "pry"

class Database
  def initialize
    @db = SQLite3::Database.open "./db/boardimo.db"
  end

  def find_all_city
    @db.execute "SELECT * FROM city"
  end

  def find_city_id(city_name)
    @db.execute "SELECT id FROM city WHERE name = '#{city_name}'"
  end

  def find_agency_id(agency_location)
    @db.execute "SELECT id FROM agency WHERE location = '#{agency_location}'"
  end

  def find_agency_id_with_name(name)
    @db.execute "SELECT id FROM agency WHERE name = '#{name}'"
  end

  def find_all_agency
    @db.execute "SELECT * FROM agency"
  end

  def find_house_with_title(title)
    @db.execute "SELECT count(*) FROM house WHERE title = '#{title}'"
  end

  def find_house_id_with_title(title)
    @db.execute "SELECT id FROM house WHERE title = '#{title}'"
  end

  def find_house_with_id(id)
    @db.execute "SELECT * FROM house WHERE id = #{id}"
  end

  def find_house_price(location)
    @db.execute "SELECT price FROM house WHERE location = '#{location}'"
  end

  def find_house_size(location)
    @db.execute "SELECT size FROM house WHERE location = '#{location}'"
  end

  def find_house_foundation_years(location)
    @db.execute "SELECT foundation_years FROM house WHERE location = '#{location}'"
  end

  def find_average_energy(house_energy)
    @db.execute "SELECT count(*) FROM house WHERE '#{house_energy}' > energy"
  end

  def count_all_house
    @db.execute "SELECT count(*) FROM house"
  end

  def add_data_house(data, city_id, agency_id)
    puts data["title"]
    data["city_id"] = city_id.flatten.first
    data["agency_id"] = agency_id.flatten.first
    @db.execute("INSERT OR IGNORE INTO House VALUES(:id, :title, :images, :size, :location, :city_id, :price, :energy, :foundation_years, :content, :agency_id)", data.transform_keys(&:to_sym))
  end
end
