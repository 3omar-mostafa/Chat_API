class DeleteDataWorker < ApplicationWorker
  def perform(klass, id)
    eval "#{klass}.destroy!(#{id})"
  end
end
