class ClientsController < ApplicationController
  require 'net/http'
  require 'uri'

  def create
    client_params = {
      full_name: params[:full_name],
      login: params[:login],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    }

    Rails.logger.info("Полученные параметры: #{client_params}")

    if valid_params?(client_params)
      uri = URI('http://localhost:8081/clients')
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      request.body = client_params.to_json
      response = http.request(request)

      if response.code == '201'
        render json: { message: 'Клиент успешно создан =).' }, status: :created
      else
        render json: { error: "Ошибка создания клиента.#{response.to_s}" }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Некорректные параметры создания клиента.' }, status: :unprocessable_entity
    end
  end

  private

  def valid_params?(params)
    Rails.logger.info("Validating parameters: #{params}")
    params[:full_name].present? &&
      params[:login].present? &&
      params[:email].present? &&
      params[:password].present? &&
      params[:password_confirmation].present?
  end
end