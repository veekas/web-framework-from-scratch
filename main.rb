require_relative 'framework'

APP = App.new do
  get '/' do
    "this is the root"
  end

  get '/users/:username' do
    'this is the user'
  end
end
