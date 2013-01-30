class BattingLine < ActiveRecord::Base
  set_table_name(:batting)

  belongs_to :person, primary_key: "playerID", foreign_key: "playerID"
end