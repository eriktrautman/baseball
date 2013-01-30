class Person < ActiveRecord::Base
  set_table_name(:master)
  set_primary_key(:lahmanID)

  has_many :playerships, primary_key: "playerID", foreign_key: "playerID"
  has_many :teams, :through => :playerships
  has_many :pitching_lines, primary_key: "playerID", foreign_key: "playerID"
  has_many :batting_lines, primary_key: "playerID", foreign_key: "playerID"
  has_many :salaries, primary_key: "playerID", foreign_key: "playerID"

  has_many :managerships, primary_key: "managerID", foreign_key: "managerID"
  has_many :managed_teams, through: :managerships, source: "team"

  has_many :managed_people, through: :managed_teams, source: "people"


  def self.best_batting_year
    self
      .select("master.*, batting.yearID,
              MAX( batting.H / batting.AB )
                AS best_batting_avg")
      .joins(:batting_lines)
      .group("master.playerID, batting.yearID")
      .order("best_batting_avg DESC")
  end

  def self.with_300_avg_100_bats
    self
      .select("master.*, batting.yearID,
              MAX( batting.H / batting.AB )
                AS best_batting_avg")
      .where("COUNT(batting.")
      .joins(:batting_lines)
      .group("master.playerID, batting.yearID")
      .order("best_batting_avg DESC")
  end

  def self.most_experienced
    self
      .select("master.*, COUNT(DISTINCT(appearances.yearID)) as career_length")
      .joins(:playerships)
      .group("master.playerID")
      .order("career_length DESC")
  end

  def self.managed_most_players
    self
      .select("master.*, COUNT(DISTINCT(managed_people_master.playerID)) AS num_people_managed")
      .joins(:managed_people)
      .group("master.managerID")  ##
      .order("num_people_managed DESC")
  end

  def self.played_for_most_teams_in_one_year #### <<<<< FINISH LATER
    self
      .select("master.*, COUNT(DISTINCT(appearances.teamID)) AS num_teams")
      .joins(:playerships)
      .group("master.playerID")
      .order("num_teams DESC")
  end

  def self.played_for_n_years(n)
    self
      .select("master.*")
      .joins(:playerships)
      .where("appearances.experience >= (?)", n)
      .group("master.playerID")
  end

  def self.played_for_one_team
    self
      .select("master.*")
      .joins(:playerships)
      .group("playerID")
      .having("COUNT(appearances.yearID) = 1")
  end

  def self.played_for_most_teams_in_career
    self
      .select("master.*, COUNT(DISTINCT appearances.teamID) AS teams_played_in")
      .joins(:playerships)
      .group("master.playerID")
      .order("teams_played_in DESC")
  end

end







