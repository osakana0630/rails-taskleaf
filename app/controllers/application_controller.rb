class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private
  def current_user
    #   ||=  「||」演算子の自己代入演算子。a が 偽 か 未定義 なら a に xxx を代入する、という意味になります。
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  #アプリケーションの全てのアクション処理の前にこのメソッドが呼ばれる
  # ログインしていないユーザーに利用制限を設ける
  def login_required
    redirect_to login_url unless current_user
  end
end
