require "sinatra"
require "./lib/trees_table"
require "gschool_database_connection"
require "rack-flash"

class App < Sinatra::Application
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

  get "/trees/:id" do
    tree = @trees_table.find(params[:id])

    erb :"trees/show", locals: {tree: tree}
  end

  get "/trees/:id/edit" do
    tree = @trees_table.find(params[:id])

    erb :"trees/edit", locals: {tree: tree}
  end

  post "/trees" do
    id = @trees_table.create(
      name: params[:name],
      species: params[:species],
      country: params[:country],
      image: params[:image]
    )

    flash[:notice] = "Tree created"

    redirect "/trees/#{id}"
  end

  patch "/trees/:id" do
    @trees_table.update(params[:id], {
      name: params[:name],
      species: params[:species],
      country: params[:country],
      image: params[:image]
    })

    flash[:notice] = "Tree updated"

    redirect "/trees/#{params[:id]}"
  end
end