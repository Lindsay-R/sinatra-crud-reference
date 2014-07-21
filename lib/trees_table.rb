class TreesTable
  attr_reader :database_connection

  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(attributes)
    insert_sql = <<-SQL
    INSERT INTO trees (name, species, country, image)
    VALUES ('#{attributes[:name]}', '#{attributes[:species]}', '#{attributes[:country]}', '#{attributes[:image]}')
    RETURNING id
    SQL

    database_connection.sql(insert_sql)
  end

  def all
    database_connection.sql("SELECT * FROM trees")
  end
end