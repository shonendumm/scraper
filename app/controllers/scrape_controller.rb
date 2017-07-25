class ScrapeController < ApplicationController

  def index
  end

  def reddit
    scrape_reddit
  end

  private

  def scrape_reddit
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.reddit.com/", 'User-Agent' => random_agent))

    entries = doc.css('.entry')
    entriesArray = []
    entries.each do |entry|
      title = entry.css('p.title>a').text
      link = entry.css('p.title>a')[0]['href']
      entriesArray << Entry.new(title, link)
    end
    @entries = entriesArray
  end

  def random_agent
    ['Johnnys', 'Cedrica', 'Maryme', 'Rodricky'].sample
  end


end
