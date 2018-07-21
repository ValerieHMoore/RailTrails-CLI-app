class RailTrails::Scraper

  attr_accessor :homepage
  
  def initialize(homepage_url)
    self.homepage = homepage_url
  end
  
  def scrape
    doc = Nokogiri::HTML(open(self.homepage))
      doc.css("div.trails div.row").each do |trail|
        name = trail.css("div.column.details")[0].css("span")[0].text
        length = trail.css("div.column.details")[0].css("span")[1].text
        url = trail.css("div.column.details a").attr("href").value
        RailTrails::RailTrail.create(name, url, length)
      end
    trail_list
  end

  def trail_list
    RailTrails::RailTrail.all.each.with_index(1) do |trail, index|
      puts "#{index}. #{trail.name} - #{trail.length}"
    end
  end

  def self.scrape_details(trail)
    binding.pry
    page = Nokogiri::HTML(open(trail.url))
      trail.states = page.css("div.column.details")[0].css("span")[3].text
      trail.surface = page.css("div.column.details")[0].css("span")[4].text
      trail.endpoints = page.css("div strong").css("span").text
      trail.description = page.css("trail-description").attr("p").text
  end

end