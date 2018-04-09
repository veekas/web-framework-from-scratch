class App
  def call(env)
    [200, {}, ["200 OK", "Hash of HTTP headers", "Enumerable of stringable objects such as 'Hello World!'"]]
  end
end

APP = App.new
