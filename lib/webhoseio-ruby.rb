require 'json'
require 'net/https'

class Webhoseio
  def initialize(token)
    @next = ''
    @token = token
  end

  def query(end_point_str, param_dict = {})
    param_dict[:token] ||= @token
    param_dict[:format] ||= 'json'
    @next = URI::parse('https://webhose.io/' + end_point_str + '?' + URI.encode_www_form(param_dict))
    get_next
  end

  def get_next
    response = Net::HTTP.get_response(@next)

    unless response.kind_of? Net::HTTPSuccess
      raise 'Server replied with status code ' + response.code
    end

    json = JSON.parse(response.body)
    @next = URI::parse('https://webhose.io' + json['next'])
    json
  end
end
