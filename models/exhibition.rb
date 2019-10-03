require('date')
require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Exhibition
  attr_reader(:id, :title, :description, :start_date, :end_date, :artists)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @description = options['description'] if options['description']
    @start_date = options['start_date']
    @end_date = options['end_date']
    @artists = options['artists'] if options['artists']
  end

  def save()
    sql = "INSERT INTO exhibitions(title, description, start_date, end_date)
            VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@title, @description, @start_date.to_s, @end_date.to_s]
    sql_result = SqlRunner.run(sql, values)
    @id = sql_result.first['id'].to_i

    # saved in db: now save relationship to artist
    save_artist_relationship() if @artists
  end

  def update()
      sql = "UPDATE exhibitions SET (title, description, start_date, end_date) = ($1, $2, $3, $4) WHERE id = $5"
      values = [@title, @description, @start_date, @end_date, @id]
      SqlRunner.run(sql, values)
  end

  def delete()
        sql = "DELETE FROM exhibitions WHERE id = $1"
        SqlRunner.run(sql, [@id])
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
    sql = "SELECT * FROM exhibitions
            WHERE id = $1"
    values = [id]
    exhibition = SqlRunner.run(sql, values)
    result = Exhibition.new(exhibition.first)
    return result
  end
end
