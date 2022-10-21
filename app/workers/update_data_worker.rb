class UpdateDataWorker < ApplicationWorker
  def perform(klass, id, params)
    Sidekiq.logger.info "Updating: #{klass} #{id} #{params}"
    Sidekiq.logger.info "************************************************************"

    klass = eval klass
    params = eval params
    klass.update(id, params)
  end
end
