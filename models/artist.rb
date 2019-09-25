require_relative('./exhibition.rb')
require_relative('../db/sql_runner')

class Artist
    attr_reader(:id, :name, :year_born, :hometown)

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @year_born = options['year_born'].to_i if options['year_born']
        @hometown = options['hometown'] if options['hometown']
    end

    def save()
        sql = "INSERT INTO artists(name, year_born, hometown)
                VALUES ($1, $2, $3) RETURNING id"
        values = [@name, @year_born, @hometown ]
        sql_result = SqlRunner.run(sql, values)
        @id = sql_result.first()['id'].to_i
    end

    def update()
        sql = "UPDATE artists SET (name, year_born, hometown) = ($1, $2, $3) WHERE id = $4"
        values = [@name, @year_born, @hometown, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM artists WHERE id = $1"
        SqlRunner.run(sql, [@id])
    end

    def get_exhibitions()
        sql = 'SELECT exhibitions.* FROM exhibitions INNER JOIN artist_exhibitions ON exhibitions.id = artist_exhibitions.exhibition_id 
                WHERE artist_id = $1'
        sql_result = SqlRunner.run(sql, [@id])
        result = sql_result.map { |exhibition| Exhibition.new(exhibition) }
        return result
    end


    # class methods:
    def self.all()
        sql = 'SELECT * FROM artists'
        artists = SqlRunner.run(sql)
        result = artists.map { |artist| Artist.new(artist) }
        result
    end

    def self.find(id)
        sql = "SELECT * FROM artists
                WHERE id = $1"
        values = [id]
        artist = SqlRunner.run(sql, values)
        result = Artist.new(artist.first)
        result
    end
end
