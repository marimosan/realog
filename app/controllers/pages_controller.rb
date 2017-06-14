class PagesController < ApplicationController
  def input_auth
    redirect_to log_path if logged_in?
  end

  def check_auth
    password = params[:auth][:pass]
    if Auth.authenticate?(password)
      session[:logged_in] = true
      redirect_to log_path
    else
      flash[:danger] = "パスワードが間違っています"
      redirect_to root_url
    end
  end

  def home
    redirect_to root_url unless logged_in?
    @logs = Log.page(params[:page]).order("id desc")
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def update
    crawl = GetReal::Crawler.new
    crawl.login
    feeds = GetReal::Parser.get_feeds_by_html(crawl.html)
    Log.update_by_feeds(feeds)
    flash[:success] = "更新しました"
    redirect_to root_url
  end
end
