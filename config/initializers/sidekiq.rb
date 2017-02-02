def configure_cron
  rails_root = File.dirname(__FILE__) + '/../..'
  schedule_file = rails_root + "/config/sidekiq_schedule.yml"
  if File.exists?(schedule_file)
    sidekiq_cron = YAML.load_file(schedule_file)
    Sidekiq::Cron::Job.load_from_hash sidekiq_cron[Rails.env]
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/1', namespace: ENV['REDIS_SIDEKIQ_NAMESPACE'] || 'cargo' }
  configure_cron
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/1', namespace: ENV['REDIS_SIDEKIQ_NAMESPACE'] || 'cargo' }
end
