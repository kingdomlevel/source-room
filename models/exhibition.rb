require('date')
require('pry')
require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Exhibition
  attr_reader(:id, :title, :description, :start_date, :end_date)
  attr_accessor(:artists)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @description = options['description'] if options['description']
    @start_date = Date.parse(options['start_date'])
    @end_date = Date.parse(options['end_date'])
    if options['artists']
      @artists = options['artists']
    else
      @artists = []
    end
  end

  def save()
    sql = "INSERT INTO exhibitions(title, description, start_date, end_date)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@title, @description, @start_date.to_s, @end_date.to_s]
    sql_result = SqlRunner.run(sql, values)
    @id = sql_result.first['id'].to_i

    # saved in db: now save relationship to artist
    save_artist_relationship() if @artists.length > 0
  end

  def update()
    sql = "UPDATE exhibitions SET (title, description, start_date, end_date) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@title, @description, @start_date, @end_date, @id]
    SqlRunner.run(sql, values)

    # # updated in db: now update relationship to artist
    # update_artist_relationship() if @artists
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

  def update_artist_relationship()
    sql = "DELETE FROM artist_exhibitions WHERE exhibition_id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    save_artist_relationship()
  end

  def get_artists()
    sql = 'SELECT artists.* FROM artists INNER JOIN artist_exhibitions ON artists.id = artist_exhibitions.artist_id
    WHERE exhibition_id = $1'
    sql_result = SqlRunner.run(sql, [@id])
    result = sql_result.map { |exhibition| Artist.new(exhibition) }
    return result
  end

  def insert_exhibition_image(image_url)
    sql = "INSERT INTO exhibition_images (exhibition_id, image_url) VALUES ($1, $2) "
    values = [@id, image_url]
    SqlRunner.run(sql, values)
  end

  def get_exhibition_images()
    sql = "SELECT exhibition_images.image_url FROM exhibition_images WHERE exhibition_id = $1"
    sql_result = SqlRunner.run(sql, [@id])

    if sql_result.first
      result = sql_result.map { |image| image["image_url"]}
      return result
    else
      return []
    end
  end

  def add_artist(artist)
    @artists.push(artist)
  end

  def artist_in_show?(artist)
    return @artists.any? { |current_artist| current_artist.id == artist.id }
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
    result.artists = result.get_artists
    return result
  end

end
