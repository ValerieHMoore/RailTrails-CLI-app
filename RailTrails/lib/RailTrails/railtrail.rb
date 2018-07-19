class RailTrails::RailTrail
  attr_accessor :name, :url, :length, :state, :surface
  
  @@all = []
  
  def initialize(name,url,length,state,surface)
    base_url = "https://www.traillink.com"
    self.name = name
    self.url = base_url + url
    self.length = "Length: " + length
    self.state = "State: " + state
    self.surface = "Surface: " + surface
  end
  
  def self.all
    @@all
  end
  
  def save
    self.class.all.push(self)
  end
  
  def self.create(name,url,length,state,surface)
    railtrail = self.new(name,url,length,state,surface)
    railtrail.save
    railtrail
  end

end
