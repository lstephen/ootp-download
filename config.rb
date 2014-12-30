
OotpDownload.configure do |c|
  c.add League.new :HFTC, 'http://www.hitforthecycle.com/Hit%20For%20The%20Cycle.zip'
  c.add League.new :GABL, 'http://www.goldenageofbaseball.com/commish/gabl.lg.zip'
  c.add League.new :CBL, 'http://www.thecblonline.com/zips/cbl.zip', :create_league_directory => true
end
