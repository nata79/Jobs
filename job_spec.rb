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

      it 'returns a string with every received job without dependencies' do
        jobs_string = 'a => \nb => \nc => \n'
        result = Order.new.execute jobs_string
        result.split(',').length.should be 3
        %w(a b c).each{ |j| result.include?(j).should be_true }        
      end

      it 'returns a string with every received job with dependencies' do
        jobs_string = 'a => \nb => c\nc => \n'
        result = Order.new.execute jobs_string
        result.split(',').length.should be 3
        %w(a b c).each{ |j| result.include?(j).should be_true }        
      end
    end
  end

end