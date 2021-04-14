# require "./lib/controller"

require "./lib/controller"

class Router
  def controller
    @controller ||= Controller.new
  end

  def call(env)
    path = env["REQUEST_PATH"]
    req = Rack::Request.new(env)
    body = req.body.gets

    params = {}
    params.merge!(body ? JSON.parse(body) : {})
    roots(path, params)
  end

  def roots(path, params)
    case path
    when "/"
      controller.init
    when "/add_data"
      controller.analyze_data_entry(params)
    end
  end
end
