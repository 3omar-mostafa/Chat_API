class UpdateDataWorker < ApplicationWorker
  def perform(klass, id, params)
    Sidekiq::Logging.logger.info "Updating: #{klass} #{id} #{params}"
    Sidekiq::Logging.logger.info "************************************************************"

    klass = eval klass
    params = eval params
    klass.update(id, params)
  end
end
