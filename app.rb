require "sinatra"
require "./lib/trees_table"
require "gschool_database_connection"
require "rack-flash"

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @trees_table = TreesTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))
  end

  get "/" do
    trees = @trees_table.all

    erb :home, locals: {trees: trees}
  end

  get "/trees/new" do
    erb :"trees/new"
  end

  post "/trees" do
    @trees_table.create(
      name: params[:name],
      species: params[:species],
      country: params[:country],
      image: params[:image]
    )

    flash[:notice] = "Tree created"

    redirect "/"
  end
end