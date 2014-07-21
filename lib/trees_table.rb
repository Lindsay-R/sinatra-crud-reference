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

    database_connection.sql(insert_sql).first["id"]
  end

  def all
    database_connection.sql("SELECT * FROM trees")
  end

  def find(id)
    database_connection.sql("SELECT * FROM trees WHERE id = #{id}").first
  end

  def update(id, attributes)
    update_sql = <<-SQL
    UPDATE trees
    SET name = '#{attributes[:name]}',
    species = '#{attributes[:species]}',
    country = '#{attributes[:country]}',
    image = '#{attributes[:image]}'
    WHERE id = #{id};
    SQL

    database_connection.sql(update_sql)
  end

  def delete(id)
    delete_sql = <<-SQL
    DELETE
    FROM trees
    WHERE id = #{id}
    SQL

    database_connection.sql(delete_sql)
  end
end
