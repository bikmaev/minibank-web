# frozen_string_literal: true

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
        render json: { error: "Ошибка создания клиента.#{response}" }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Некорректные параметры создания клиента.' }, status: :unprocessable_entity
    end
  end

  def login
    client_params = {
      full_name: params[:full_name],
      login: params[:login],
      email: params[:email],
      password: params[:password]
    }
    Rails.logger.info("Полученные параметры: #{params}")

    # if valid_params?(client_params)
    uri = URI('http://localhost:8081/search')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = client_params.to_json
    response = http.request(request)
    Rails.logger.info("Клиент для сохранения: #{response.inspect}")

    if response.code == '200'
      render json: { message: '200.' }, status: :ok
    else
      render json: { error: "not 201.#{response}" }, status: :unprocessable_entity
    end
    # else
    #  render json: { error: 'invalid data.' }, status: :unprocessable_entity
    # end
  end

  def show
    uri = URI("http://localhost:8081/clients/#{params[:id]}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.path, 'Content-Type' => 'application/json')
    # request.body = client_params.to_json
    response = http.request(request)

    return unless response.code == '200'

    client_data = JSON.parse(response.body)
    @client = Client.new(id: client_data['id'], full_name: client_data['full_name'], login: client_data['login'],
                         email: client_data['email'])
                    .else
    flash.now.alert = 'Нет клиента по заданным параметрам'
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
