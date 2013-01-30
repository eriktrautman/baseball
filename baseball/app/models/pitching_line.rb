class PitchingLine < ActiveRecord::Base
  set_table_name(:pitching)

  belongs_to :person, primary_key: "playerID", foreign_key: "playerID"

end