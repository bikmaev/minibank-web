# frozen_string_literal: true

# контроллер сессии
class SessionsController < ApplicationController
  require 'net/http'
  require 'uri'

  def new; end

  def create
    client_params = {
      full_name: params[:full_name],
      login: params[:login],
      email: params[:email],
      password: params[:password]
    }

    uri = URI('http://localhost:8081/login_check')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = client_params.to_json
    response = http.request(request)
    Rails.logger.info("  -- Response  -- 1-- : #{response}")

    if response.code == '200'
      client = JSON.parse(response.body)
      session[:client_id] = client['id']
      flash[:success] = 'Вы успешно вошли'
      redirect_to client_path(client['id']), notice: "Добро пожаловать, #{client['full_name']}!"
    else
      flash.now.alert = 'Неверный email или пароль'
      render 'new'
    end
  end

  def destroy
    # Очистите сессию при выходе
    # session[:client_id] = nil
    reset_session
    # flash[:success] = 'Вы вышли'
    redirect_to root_path, notice: 'Вы успешно вышли'
  end
end
