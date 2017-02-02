class TwilioWebhooksController < ActionController::Base

  skip_before_filter :verify_authenticity_token

  def driver_sms
    from_number = params['From']
    message_body = params['Body']
    Rails.logger.info "TwilioWebhooksController: FROM: #{from_number}"
    Rails.logger.info "TwilioWebhooksController: BODY: #{message_body}"
    if from_number.blank?
      Rails.logger.warn "TwilioWebhooksController: Missing From number."
      return render nothing: true, status: 400
    end
    if message_body.blank?
      Rails.logger.warn "TwilioWebhooksController: Missing message body."
      return render nothing: true, status: 400
    end
    user = User.find_by(phone: from_number)
    if user.nil?
      Rails.logger.warn "TwilioWebhooksController: Could not find User with phone: #{from_number}."
      return render nothing: true, status: 400
    end
    if message_body.downcase == "stop"
      if user.inactive!
        TwilioUtils.send_message(user, "You've been unsubscribed from the WhereDoIDrive service.")
      else
        Rails.logger.error "TwilioWebhooksController: Failed to unsubscribe user id #{user.id}."
        TwilioUtils.send_message(user, "A system error occurred. Please contact technical support for assistance at support@wheredoidrive.com")
      end
      return render nothing: true, status: 200
    end
    if /pause (.+) days?/ =~ message_body.downcase
      days = $1.to_i
      if days == 0
        TwilioUtils.send_message(user, "Unable to understand. Format of pause command is: 'pause X days', where X is a number.")
        return render nothing: true, status: 200
      end
      if user.pause_for!(days)
        TwilioUtils.send_message(user, "Paused notifications for #{days} days.")
      else
        Rails.logger.error "TwilioWebhooksController: Failed to pause user id #{user.id} for #{days} days."
        TwilioUtils.send_message(user, "A system error occurred. Please contact technical support for assistance at support@wheredoidrive.com")
      end
      return render nothing: true, status: 200
    end
  end

end
