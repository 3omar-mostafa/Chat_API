class InsertDataWorker < ApplicationWorker
  def perform(klass, params)
    Sidekiq.logger.info "Inserting: #{klass} #{params}"
    Sidekiq.logger.info "************************************************************"

    klass = eval klass
    params = eval params
    klass.create(params)
  end
end
