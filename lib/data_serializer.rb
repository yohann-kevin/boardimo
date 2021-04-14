class DataSerializer
  def initialize(data, url)
    @url = url
    @initial_data = data
    @serialized_data = {}
  end

  def format_data
    @serialized_data = {
      "title" => @initial_data[1],
      "images" => build_img_roots(@initial_data[2]),
      "size" => @initial_data[3],
      "location" => @initial_data[4],
      "price" => @initial_data[6],
      "energy" => @initial_data[7],
      "foundation_years" => @initial_data[8],
      "content" => @initial_data[9]
    }
    puts @serialized_data
  end

  def build_img_roots(path)
    url_splited = @url.tr(":/.", " ").split(" ")
    "#{url_splited[0]}://#{url_splited[1]}.#{url_splited[2]}.#{url_splited[3]}/#{path}"
  end
end
