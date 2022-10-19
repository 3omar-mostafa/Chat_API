class UpdateDataWorker < ApplicationWorker
  def perform(klass, id, params)
    eval "#{klass}.update!(#{id}, #{params})"
  end
end
