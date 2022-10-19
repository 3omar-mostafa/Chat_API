class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def delete_redis_data
    raise NotImplementedError
  end
end
