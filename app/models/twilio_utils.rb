# requires ENV vars:
# TWILIO_NUMBER
# TWILIO_ACCOUNT_SID
# TWILIO_AUTHTOKEN
class TwilioUtils

  def self.send_message(to_user, message_body)
    sms_receiver_number = to_user.phone
    sms_sender_number = ENV['TWILIO_NUMBER']
    TwilioUtils.send_sms(sms_receiver_number, sms_sender_number, message_body)
  end

  def self.number_lookup_resource(number)
    return RestClient::Resource.new(
      "https://lookups.twilio.com/v1/PhoneNumbers/#{number}",
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTHTOKEN'])
  end

  private

  def self.send_sms(to_number, from_number, message_text, callback_url = nil)
    resource = TwilioUtils.auth_twilio_resource('Messages.json')
    begin 
      response = resource.post(
        :From => from_number,
        :Body => message_text, 
        :To => to_number,
        :StatusCallback => callback_url)
    rescue => e
      response_error = response.nil? ? nil : JSON.parse(response)
      Rails.logger.error "Message To: #{to_number} From: #{from_number} failed with response: #{response_error}"
    end
    Rails.logger.info "TwilioUtils.send_sms response: #{response.inspect}"
    return JSON.parse(response) if response.present?
  end

  def self.auth_twilio_resource(pathway)
    resource = RestClient::Resource.new(
      "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/#{pathway}",
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_AUTHTOKEN'])
    return resource
  end

end
