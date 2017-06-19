require "#{Rails.root}/app/models/log"
require "#{Rails.root}/app/lib/get_real/crawler"
require "#{Rails.root}/app/lib/get_real/parser"
class Tasks::UpdateLog
  def self.update_log
    sleep(rand(60..900))
    Rails.logger.debug("Start Update Log Auto #{Time.now}")
    crawl = GetReal::Crawler.new
    crawl.login
    feeds = GetReal::Parser.get_feeds_by_html(crawl.html)
    Log.update_by_feeds(feeds)
    Rails.logger.debug("End Update Log Auto #{Time.now}")
  end

  def self.update_log_immediately
    Rails.logger.debug("Start Update Log Manual #{Time.now}")
    crawl = GetReal::Crawler.new
    crawl.login
    feeds = GetReal::Parser.get_feeds_by_html(crawl.html)
    Log.update_by_feeds(feeds)
    Rails.logger.debug("End Update Log Manual#{Time.now}")
  end

end
