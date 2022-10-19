class ApplicationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3, backtrace: true, queue: :chat_queue

end
