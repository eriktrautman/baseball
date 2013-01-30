class Team < ActiveRecord::Base
  set_table_name(:teams)
  set_primary_keys('teamID', 'yearID', 'lgID')

  has_many :playerships, foreign_key: ['teamID', 'yearID', 'lgID']
  has_many :people, through: :playerships

  has_many :managerships, foreign_key: ['teamID', 'yearID', 'lgID']
  has_many :managers, through: :managerships, source: :person



end

=begin
  SELECT teams.*, MAX( x.w - y.w ) AS most_win_diff
    FROM teams
    JOIN teamshalf x
      ON teams.teamID = x.teamID
     AND teams.yearID = x.yearID
     AND teams.lgID = x.lgID
    JOIN teamshalf y
      ON teams.teamID = y.teamID
     AND teams.yearID = y.yearID
     AND teams.lgID = y.lgID
   WHERE x.teamID = y.teamID
     AND x.yearID = y.yearID
     AND x.lgID = y.lgID
     AND x.half = 1
     AND y.half = 2
     AND x.w > y.w
GROUP BY teams.teamID
ORDER BY most_win_diff DESC;
=end