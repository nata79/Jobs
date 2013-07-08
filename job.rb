module Job
  class Order
    def execute jobs_string
      job_hash = job_string_to_hash jobs_string
      return job_hash.keys.join ','
    end
  private
    def job_string_to_hash jobs_string
      jobs_hash = Hash.new
      
      jobs_hash[jobs_string[0]] = nil

      return jobs_hash
    end
  end
end