class ScrapeController < ApplicationController

  def index
  end

  def reddit
    scrape_reddit
  end

  def diaryland
    scrape_diaryland_pages(scrape_diaryland_index) #to be done next, using upton gem or metainspector
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

  def scrape_diaryland_index
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://orchardroad.diaryland.com/older.html", 'User-Agent' => random_agent))
    links_list = doc.css('a')
    linksArray = []
    links_list.each do |link|
      title = link.text
      link = 'http://orchardroad.diaryland.com/' + link.attributes['href'].value # returns a string, partial url
      linksArray << Entry.new(title, link)
    end
    linksArray
  end

  def scrape_diaryland_pages(linksArray)
    require 'open-uri'
    linksArray.each do |entry|
      # check link if exists in record
      unless Diary.find_by(link: "#{entry.link}")
        doc = Nokogiri::HTML(open("#{entry.link}", 'User-Agent' => random_agent))
        body = doc.css('p')
        Diary.create(title: entry.title, link: entry.link, body: body)
      end
    end
  end



end
