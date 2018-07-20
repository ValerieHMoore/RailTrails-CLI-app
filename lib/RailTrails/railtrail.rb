class RailTrails::RailTrail
  attr_accessor :name, :url, :length, :states, :surface, :endpoints, :description
  
  @@all = []
  
  def initialize(name,url,length)
    base_url = "https://www.traillink.com"
    self.name = name
    self.url = base_url + url
    self.length = length
  end
  
  def self.all
    @@all
  end
  
  def save
    self.class.all.push(self)
  end
  
  def self.create(name,url,length)
    railtrail = self.new(name,url,length)
    railtrail.save
    railtrail
  end

end
