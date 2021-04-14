require "./db/database"

class HouseAnalyzer
  def initialize(data)
    @size = data["size"]
    @price = data["price"]
    @location = data["location"]
    @foundation_years = data["foundation_years"]
    @energy = data["energy"]
  end

  def compute_price_average
    all_price = Database.new.find_house_price(@location)
    all_size = Database.new.find_house_size(@location)
    total_price = 0
    i = 0
    while i < all_size.length
      total_price += all_price[i][0] / all_size[i][0]
      i += 1
    end
    # price average
    total_price / all_size.length
  end

  def compute_foundation_years_average
    all_foundation_years = Database.new.find_house_foundation_years(@location)
    house_age_average = 0
    all_foundation_years.each do |year|
      year.to_s.tr("[]", "").to_i
      year[0].zero? || year[0] < 1600 ? all_foundation_years.delete(year) : house_age_average += (2021 - year[0])
    end
    # house age average
    house_age_average /= all_foundation_years.length
  end

  def compute_house_age
    age = 2021 - @foundation_years
    if age < 20
      compute_house_age_economy(age)
    else
      compute_house_age_expanse(age)
    end
  end

  def compute_house_age_economy(age)
    age < 10 ? [245 * @size, true] : [105 * size, true]
  end

  def compute_house_age_expanse(age)
    age < 40 ? [95 * @size, false] : [355 * @size, false]
  end

  def check_energetic_note
    # result = [energy economy or expanse, is_economy true or false]
    if @energy == "A" || @energy == "B" || @energy == "C"
      compute_energy_economy
    else
      compute_energy_expanse
    end
  end

  def compute_energy_economy
    economy = case @energy
              when "A"
                216.6 * @size
              when "B"
                161.5 * @size
              else
                81.7 * @size
              end
    [economy, true]
  end

  def compute_energy_expanse
    expanse = case @energy
              when "D"
                30.4 * @size
              when "E"
                76 * @size
              when "F"
                188.1 * @size
              else
                340 * @size
              end
    [expanse, false]
  end
end
