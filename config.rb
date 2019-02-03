
OotpDownload.configure do |c|
  c.add League.new :CBL, 'http://www.thecblonline.com/zips/cbl.zip', :create_league_directory => true
  c.add League.new :GABL, 'http://www.goldenageofbaseball.com/commish/gabl.lg.zip'
  c.add League.new :HFTC, 'http://www.hitforthecycle.com/Hit%20For%20The%20Cycle.zip'
  #c.add League.new :LBB, 'http://bbs56.net/LBB/file/LBB.lg.zip'
  c.add League.new :LBB, 'http://drive.google.com/file/d/1xg7KqIvKsSwlMCtcU4JMWkiAKiBy2YO3/view?usp=sharing' # 'http://www.hoffbl.com/lbb/LBB.lg.zip'
  c.add League.new :SAVOY, 'http://www.thecblonline.com/savoy/zips/Savoy.zip', :create_league_directory => true

  c.add League.new :TWML, 'http://www.darowski.com/twml/OOTP6Reports/TWML%202.0.lg.zip', :version => :OOTP6 #, :create_league_directory => true

  c.add League.new :BTH, 'http://bthbaseball.allsimbaseball10.com/game/lgexports/BTH.lg.zip', :version => :OOTP65
  c.add League.new :OLDBTH, 'bthbaseball.allsimbaseball10.com/game/oldbth/oldBTH.lg.zip', :version => :OOTP65
end
