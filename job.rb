module Job
  class Order
    def execute jobs_string
      job_hash = job_string_to_hash jobs_string
      apply_order_algorithm job_hash
    end
  private
    def job_string_to_hash jobs_string
      jobs_hash = Hash.new      
      jobs = jobs_string.split '\n'
      
      jobs.each do |job|
        job = job.split '=>'
        job_name = job[0][0]
        job_dependency = job[1][1] if job[1]
        
        jobs_hash[job_name[0]] = job_dependency
      end

      return jobs_hash
    end

    def apply_order_algorithm jobs_hash
      s = jobs_without_dependencies jobs_hash
      l = []

      while !s.empty? do
        n = s.pop
        l.push n

        nodes_that_depend_on(jobs_hash, n).each do |m|
          jobs_hash[m] = nil
          s.push m
        end
      end

      if as_dependencies? jobs_hash
        raise 'Circular Dependency Found'
      else
        return l
      end
    end

    def jobs_without_dependencies jobs_hash
      jobs_hash.keys.select{ |j| jobs_hash[j].nil? }
    end

    def nodes_that_depend_on jobs_hash, n
      jobs_hash.keys.select{ |j| jobs_hash[j] == n }
    end

    def as_dependencies? jobs_hash
      ! jobs_hash.keys.select{ |j| jobs_hash[j] != nil }.empty?
    end
  end
end