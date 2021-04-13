require "pry"

class DataSanitizer
  def initialize(data)
    @initial_data = data
    @invalid_data = false
  end

  def check_data
    check_data_type
    check_data_size
    return run_data unless @invalid_data
    # @invalid_data
  end

  def check_data_type
    @invalid_data = true if @initial_data.class != Array
    @invalid_data = true if @initial_data[0].class != Hash
  end

  def check_data_size
    @invalid_data = true if @initial_data.length != 15
    @initial_data = true if @initial_data[0].length != 8
  end

  def run_data
    @initial_data.each do |el|
      begin
        transform_data(el)
      rescue StandardError => e
        puts e
      end
    end
    # puts @initial_data[0]
    @initial_data
  end

  def transform_data(data)
    data["images"] = rewrite_image_root(data["images"])
    data["size"] = data["size"][0...-1].tr("m²", "").to_i
    data["location"] = data["location"].tr("1234567890 ", "").downcase
    data["price"] = data["price"].tr("€* ", "").to_i
    data["energy"] = data["energy"].tr(" ", "")
    data["foundation_years"] = data["foundation_years"].tr(" ", "").to_i
    data["content"] = data["content"].squeeze("  ").strip
  end

  def rewrite_image_root(img_rules)
    if img_rules[2] == "/"
      img_rules.slice!(img_rules["../"])
    elsif img_rules[1] == "/"
      img_rules.slice!(img_rules["./"])
    end
    img_rules
  end
end
