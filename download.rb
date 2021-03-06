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
      :OOTP5 => ["/Applications/OOTP5.app/drive_c/Program Files/Out of the Park Developments/OOTP5"],
      :OOTP6 => ["/Applications/OOTP6.app/drive_c/Program Files/Out of the Park Developments/OOTP 6"],
      :OOTP65 => ["/Applications/OOTP6.5.app/drive_c/Program Files/Out of the Park Developments/OOTP 6.5"]
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
    extract(league, logger)
    logger.info(league_name) { "Done." }
  end

  def self.download(league)
    file = ENV["LEAGUE_FILE"] || league.file
    raise 'No league file set' unless file
    cmd = "curl -L #{league.file} -o #{league.name}.zip"
    `#{cmd}`
  end

  def self.extract(league, logger = nil)
    extract_to = @@config.directory(league.version).detect { |d| Dir.exists?(d) }

    if league.create_league_directory then
      extract_to = "#{extract_to}/#{league.name}.lg"
      `mkdir "#{extract_to}"`
    end

    logger.info(league.name) { "Extracting to #{extract_to}" } unless logger.nil?

    cmd = "unzip -o #{league.name}.zip -d \"#{extract_to}\""
    `#{cmd}`
  end
end

load 'config.rb'

OotpDownload.run ARGV.first



