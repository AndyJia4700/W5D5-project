def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where("yr between 1980 and 1989").where("score between 3 and 5")
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.

#  group movies by the year they were made
# then go through the score each movie got
# if in an entire year, a movie did not score higher than an 8
# return that year
# all movies < 8
# somemovie > 8
# 
  Movie.group(:yr).having("MAX(score) < 8").pluck(:yr)  #COUNT(score > 8) = 0 
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select(:id, :name).joins(:movies).where(movies: {title: title}).order("castings.ord")
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select(:id, :title, "actors.name").joins(:actors).where("movies.director_id = actors.id AND castings.ord = 1")

end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor.select(:id, :name, "castings.ord").joins(:castings).group("actors.name").order("COUNT(castings.ord > 1) DESC").limit(2)
end
