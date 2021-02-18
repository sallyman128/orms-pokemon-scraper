class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
      SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      SQL

    row = db.execute(sql, id)[0]

    new_pokemon = self.new({})
    new_pokemon.id = row[0]
    new_pokemon.name = row[1]
    new_pokemon.type = row[2]
    new_pokemon
  end
end
