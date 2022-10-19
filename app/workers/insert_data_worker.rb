class InsertDataWorker < ApplicationWorker
  def perform(klass, params)
    Sidekiq::Logging.logger.info "Inserted: #{klass} #{params}"
    Sidekiq::Logging.logger.info "************************************************************"

    klass = eval klass
    params = eval params
    klass.create(params)
  end
end
