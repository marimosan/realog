module PagesHelper
  def logged_in?
    session[:logged_in]
  end

  def wait_time
    60 * 15
  end

  def update_base_time
    (Time.now - Flg.find_by(name: "最終更新日時フラグ")[:updated_at]).round
  end

  def remaining_to_update
    remaining_time = wait_time - update_base_time
    if remaining_time > 60
      min = remaining_time / 60
      sec = remaining_time % 60
      return "#{min}分#{sec}秒"
    else
      sec = remaining_time
      return "#{sec}秒"
    end
  end

end
