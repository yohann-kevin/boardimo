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
    roots(path)
  end

  def roots(path)
    case path
    when "/"
      controller.init
    end
  end
end
