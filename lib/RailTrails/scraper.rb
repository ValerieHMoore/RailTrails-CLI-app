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
  end

  def self.scrape_details(trail)
    page = Nokogiri::HTML(open(trail.url))
      trail.states = page.css("div.facts").css("span")[0].text
      trail.surface = page.css("div.facts").css("span")[4].text
      trail.endpoints = page.css("div.facts").css("span")[3].text
      trail.description = page.css("main.medium-8").text
  end

end