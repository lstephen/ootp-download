#!/usr/bin/env ruby

require 'logger'

class League
  attr_reader :name
  attr_reader :file
  attr_reader :version
  attr_reader :create_league_directory

  def initialize(name, file, options = {})
    @file = file
    @name = name
    @create_league_directory = options[:create_league_directory] || false
    @version = options[:version] || :OOTP5
  end
end

class Cfg
  attr_reader :league

  def initialize
    @league = {}

    @directory = {
      :OOTP5 => "#{Dir.home()}/Applications/Wineskin/OOTP5.app/drive_c/Program Files/Out of the Park Developments/OOTP5",
      :OOTP6 => "#{Dir.home()}/Applications/Wineskin/OOTP6.app/drive_c/Program Files/Out of the Park Developments/OOTP 6",
      :OOTP65 => "#{Dir.home()}/Applications/Wineskin/OOTP6.5.app/drive_c/Program Files/Out of the Park Developments/OOTP 6.5"
    }
  end

  def add(league)
    @league[league.name.to_s] = league
  end

  def directory(version)
    @directory[version]
  end
end


class OotpDownload
  @@config = Cfg.new

  def self.configure
    yield( @@config )
  end

  def self.run(league_name)
    logger = Logger.new(STDOUT)
    league = @@config.league[league_name]
    logger.info(league_name) { "Downloading..." }
    download(league)
    logger.info(league_name) { "Extracting..." }
    extract(league)
    logger.info(league_name) { "Done." }
  end

  def self.download(league)
    raise 'No league file set' if league.file.nil?
    cmd = "curl #{league.file} -o #{league.name}.zip"
    `#{cmd}`
  end

  def self.extract(league)
    extract_to = @@config.directory(league.version)

    if league.create_league_directory then
      extract_to = "#{extract_to}/#{league.name}.lg"
      `mkdir "#{extract_to}"`
    end

    cmd = "unzip -o #{league.name}.zip -d \"#{extract_to}\""
    `#{cmd}`
  end
end

load 'config.rb'

#OotpDownload.configure do |c|
#  c.league["HFTC"] = League.new :HFTC, 'http://www.hitforthecycle.com/Hit%20For%20The%20Cycle.zip'
#end

#HFTC = League.new :HFTC
#GABL = League.new :GABL
#CBL = League.new :CBL, :create_league_directory => true

$league_files = {
  :HFTC => 'http://www.hitforthecycle.com/Hit%20For%20The%20Cycle.zip',
  :GABL => 'http://www.goldenageofbaseball.com/commish/gabl.lg.zip',
  :CBL => 'http://www.thecblonline.com/zips/cbl.zip'
}



ARGV.each do |league_name|
  OotpDownload.run(league_name)
end



