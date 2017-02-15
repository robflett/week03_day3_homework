require_relative('./sql_runner')

class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end


  def save

    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    saved_artists = SqlRunner.run(sql)
    artist_object = saved_artists.map {|artist| Artist.new(artist)}
    id_string = artist_object[0].id
    @id = id_string.to_i
  end

  def self.list_all
    sql = "SELECT * FROM artists;"
    list_hash = SqlRunner.run(sql)
    list_object = list_hash.map { |artist| Artist.new(artist)}
    return list_object
  end


end