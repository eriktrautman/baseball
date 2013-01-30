class Salary < ActiveRecord::Base
  set_table_name(:salaries)

  belongs_to :person, primary_key: "playerID", foreign_key: "playerID"

end