# lib/json_web_token.rb
class JsonWebToken
  SECRET_KEY =  Rails.application.secrets.secret_key_base

  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload,SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)
  end

  def self.valid_payload(payload)
    !(expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud])
  end

  def self.meta
    {
      exp: 1.day.from_now.to_i,
      iss: 'issuer_name',
      aud: 'client',
    }
  end

  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end
