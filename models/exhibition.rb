require('date')
require_relative('../db/sql_runner.rb')

class Exhibition
  attr_reader(:id, :title, :description)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @description = options['description'].to_i if options['description']
    @start_date = options['start_date']
    @artists = options['start_date'] if options['artists']
  end

  def save()
    sql = "INSERT INTO artists(name, year_born, hometown)
            VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @year_born, @hometown]
    sql_result = SqlRunner.run(sql, values)
    @id = sql_result.first['id'].to_i

    # saved in db: now save relationship to artist
    save_artist_relationship()
  end

  def save_artist_relationship()
    for artist in @artists
        sql = "INSERT INTO artist_exhibitions (artist_id, exhibition_id)
                VALUES ($1, $2)"
        values = [artist.id, @id]
        SqlRunner.run(sql, values)
    end
  end

  def get_artists()
    sql = 'SELECT artists.* FROM artists INNER JOIN artist_exhibitions ON artists.id = artist_exhibitions.artist_id
            WHERE exhibition_id = $1'
    sql_result = SqlRunner.run(sql, [@id])
    result = sql_result.map { |exhibition| Artist.new(exhibition) }
    return result
  end

  # class methods:
  def self.all
    sql = 'SELECT * FROM exhibitions ORDER BY start_date'
    pg_result = SqlRunner.run(sql)
    result = pg_result.map { |exhibition| Exhibition.new(exhibition) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM artists
            WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, values)
    result = Artist.new(artist.first)
    return result
  end
end
