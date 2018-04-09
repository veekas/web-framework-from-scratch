class App
  def initialize(&block)
    @routes = RouteTable.new(block)
  end

  # env has rack stuff, http headers, etc
  # rack request has more convenient naming
  def call(env)
    request = Rack::Request.new(env)
    @routes.each do |route|
      content = route.match(request)
      return [200, {}, [content]] if content
    end
    [404, {}, ["not found oh no"]]
  end

  class RouteTable
    def initialize(block)
      @routes = []
      instance_eval(&block)
    end

    def get(route_spec, &block)
      @routes << Route.new(route_spec, block)
    end

    def each(&block)
      @routes.each(&block)
    end
  end

  class Route < Struct.new(:route_spec, :block)
    def match(request)
      if request.path == route_spec
        block.call
      else
        nil
      end
    end
  end
end
