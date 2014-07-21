require "gschool_database_connection"
require "trees_table"

describe TreesTable do

  let(:database_connection) { GschoolDatabaseConnection::DatabaseConnection.establish("test") }

  let(:trees_table) { TreesTable.new(database_connection) }

  describe "#create" do
    it "creates a new trees" do
      expect(database_connection.sql("SELECT count(*) FROM trees").first["count"]).to eq("0")

      trees_table.create(
        name: "The Great Banyan",
        species: "Banyan",
        country: "India",
        image: "http://example.com/image.jpg"
      )

      expect(database_connection.sql("SELECT count(*) FROM trees").first["count"]).to eq("1")
    end
  end

  describe "#find" do
    it "returns the tree when found" do
      id = trees_table.create(
        name: "The Great Banyan",
        species: "Banyan",
        country: "India",
        image: "http://example.com/image.jpg"
      )

      tree = trees_table.find(id)

      expect(tree["name"]).to eq("The Great Banyan")
      expect(tree["species"]).to eq("Banyan")
      expect(tree["country"]).to eq("India")
      expect(tree["image"]).to eq("http://example.com/image.jpg")
    end

    it "returns nil when no tree is found" do
      expect(trees_table.find(1)).to eq(nil)
    end
  end

  describe "#all" do
    it "returns all trees" do
      trees_table.create(
        name: "The Great Banyan",
        species: "Banyan",
        country: "India",
        image: "http://example.com/image.jpg"
      )

      trees_table.create(
        name: "Tree of Life",
        species: "Mesquite",
        country: "Bahrain",
        image: "http://example.com/treeoflife.jpg"
      )

      expected_tree_names = ["The Great Banyan", "Tree of Life"]

      expect(trees_table.all.map { |tree| tree["name"] }).to eq(expected_tree_names)
    end
  end

  describe "#update" do
    it "updates the tree" do
      tree_id = trees_table.create(
        name: "The Great Banyan",
        species: "Banyan",
        country: "India",
        image: "http://example.com/image.jpg"
      )

      trees_table.update(tree_id, {
        name: "The Really Great Banyan",
        species: "Banyana",
        country: "Indiana",
        image: "http://example.com/newimage.jpg"
      })

      updated_tree = trees_table.find(tree_id)

      expect(updated_tree["name"]).to eq("The Really Great Banyan")
      expect(updated_tree["species"]).to eq("Banyana")
      expect(updated_tree["country"]).to eq("Indiana")
      expect(updated_tree["image"]).to eq("http://example.com/newimage.jpg")
    end
  end

  describe "#delete" do
    it "deletes the tree" do
      tree_id = trees_table.create(
        name: "The Great Banyan",
        species: "Banyan",
        country: "India",
        image: "http://example.com/image.jpg"
      )

      trees_table.delete(tree_id)

      expect(database_connection.sql("SELECT count(*) FROM trees").first["count"]).to eq("0")
    end
  end
end