class DeleteDataWorker < ApplicationWorker
  def perform(klass, id)
    Sidekiq.logger.info "Deleting: #{klass} #{id}"
    Sidekiq.logger.info "************************************************************"

    klass = eval klass
    klass.destroy(id)
  end
end
