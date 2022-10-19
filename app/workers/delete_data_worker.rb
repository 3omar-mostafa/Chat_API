class DeleteDataWorker < ApplicationWorker
  def perform(klass, id)
    Sidekiq::Logging.logger.info "Deleting: #{klass} #{id}"
    Sidekiq::Logging.logger.info "************************************************************"

    klass = eval klass
    klass.destroy(id)
  end
end
