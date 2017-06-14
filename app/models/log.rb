class Log < ApplicationRecord
  def self.update_by_feeds(feed_list)
    #新しいログのみのリストを古い順に取得
    update_list = get_new_feeds(feed_list).reverse
    #リスト内のログをLogモデルに挿入
    update_list.each do |feed|
      Log.push_log(feed)
    end
    Flg.find_by(name: "最終更新日時フラグ").touch
    Flg.find_by(name: "最終更新日時フラグ").save
  end

  def self.push_log(log)
    date = log[:date].strftime('%Y/%m/%d %H:%M')
    self.create(name: log[:name], content: log[:content], date: date)
  end

  private
    def self.get_new_feeds(feed_list)
      last_update_time = Flg.find_by(name: "最終更新日時フラグ")[:updated_at] - 60
      last_update_content = Log.last[:content]
      new_feeds_tmp = []
      feed_list.each do |feed|
        #最終更新以前に書かれたフィードの場合ループ終了
        break if feed[:date] < last_update_time
        new_feeds_tmp << feed
      end

      #取得済みのフィード本文を検査
      new_feeds = []
      new_feeds_tmp.each do |feed|
        break if feed[:content] == last_update_content
        new_feeds << feed
      end
      new_feeds
    end
end
