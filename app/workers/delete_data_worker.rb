class DeleteDataWorker < ApplicationWorker
  def perform(klass, id)
    Sidekiq::Logging.logger.info "Deleted: #{klass} #{id}"
    Sidekiq::Logging.logger.info "************************************************************"

    klass = eval klass
    model = klass.find(id)
    model.delete_redis_data
    model.destroy
  end
end
