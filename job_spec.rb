require './job.rb'
require 'rspec'

module Job
  
  describe Order do
    describe 'execute' do
      it 'returns an empty string if provided with an empty string' do
        Order.new.execute('').empty?.should be_true
      end
    end
  end

end