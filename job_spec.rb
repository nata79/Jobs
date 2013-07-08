require './job.rb'
require 'rspec'

module Job
  
  describe Order do
    describe 'execute' do
      it 'returns an empty string if provided with an empty string' do
        Order.new.execute('').empty?.should be_true
      end

      it 'returns a string with "a" if receiving a list with the element "a" and no dependencies' do
        Order.new.execute('a =>').should eq 'a'
      end 
    end
  end

end