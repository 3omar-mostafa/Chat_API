class InsertDataWorker < ApplicationWorker
  def perform(klass, params)
    eval "#{klass}.create!(#{params})"
  end
end
