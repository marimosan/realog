#require 'nokogiri'
#require 'date'

module GetReal
  class Parser
    def self.get_feeds_by_html(html)
      feeds = Nokogiri::HTML.parse(html).xpath("//*[@id='feed_list']/tbody/tr")
      return_feeds = []
      feeds.each do |feed|
        feed = Nokogiri::HTML.parse(feed.to_html)

        #発言者
        name = feed.css('.name').text

        #本文
        comment = feed.xpath("//*[@class='comment default']/tbody/tr/td").inner_html
        comment = parse_comment(comment)

        #投稿日時
        time = feed.css('.post_time').text
        time = parse_date(time)

        return_feeds << {name: name, content: comment, date: time}
      end
      return_feeds
    end



    private
      #本文を抜き出し後、<br>を改行に変換
      def self.parse_comment(comment)
        /(?<comment>.+)<span class="reference_icn">/ =~ comment
  #      comment.gsub(/<br>/, "¥n")
        comment
      end

      #整形後、Date型に変換
      def self.parse_date(date_string)
        #時間だけ表記の場合、当日の日付を付与
        if /^[0-9][0-9]:[0-9][0-9]/ === date_string
          date_string = Date.today.strftime("%m/%d ")+date_string
        end
        #date_string => 例：06/06 00:10
        Time.strptime(date_string, "%m/%d %H:%M")
      end
  end
end
