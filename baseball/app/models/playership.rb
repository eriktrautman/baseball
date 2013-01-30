class Playership < ActiveRecord::Base
  set_table_name(:appearances)

  belongs_to :person, primary_key: "playerID", foreign_key: "playerID"
  belongs_to :team, foreign_key: ['teamID', 'yearID', 'lgID']

end