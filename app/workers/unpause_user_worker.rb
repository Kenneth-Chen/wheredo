class UnpauseUserWorker
  include Sidekiq::Worker

  def perform
    logger.info "UnpauseUserWorker: Running"
    paused_users = User.paused
    # we don't need to do anything if there are no paused users
    return if paused_users.size == 0
    logger.info "UnpauseUserWorker: #{paused_users.size} paused users"
    paused_users.each do |user|
      user.active! if user.paused_until < DateTime.now.utc
    end
  end
end
