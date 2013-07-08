require './job.rb'
require 'rspec'

module Job
  
  describe Order do
    describe 'execute' do
      it 'returns an empty string if provided with an empty string' do
        Order.new.execute('').empty?.should be_true
      end

      it 'returns a string with "a" if receiving a list with the element "a" and no dependencies' do
        Order.new.execute('a =>').should eq ['a']
      end

      it 'returns a string with every received job without dependencies' do
        jobs_string = 'a => \nb => \nc => \n'
        result = Order.new.execute jobs_string
        result.length.should be 3
        %w(a b c).each{ |j| result.include?(j).should be_true }        
      end

      it 'returns a string with every received job with dependencies' do
        jobs_string = 'a => \nb => c\nc => \n'
        result = Order.new.execute jobs_string
        result.length.should be 3
        %w(a b c).each{ |j| result.include?(j).should be_true }        
      end

      it 'returns a string ordered with simple dependencies' do
        jobs_string = 'a => \nb => c\nc => \n'
        result = Order.new.execute jobs_string
        (result.index('c') < result.index('b')).should be_true
      end   

      it 'returns an ordered string with complex dependencies' do
        jobs_string = 'a => \nb => c\nc => f\nd => a\ne => b\nf =>'
        result = Order.new.execute jobs_string
        (result.index('c') < result.index('b')).should be_true
        (result.index('f') < result.index('c')).should be_true
        (result.index('a') < result.index('d')).should be_true
        (result.index('b') < result.index('e')).should be_true        
      end

      it 'raises an error if a job depends on himself' do
        jobs_string = 'a => \nb => \nc => c\n'
        expect{ Order.new.execute jobs_string }.to raise_error
      end

      it 'raises an error if a there is circular dependencies' do
        jobs_string = 'a => \nb => c\nc => f\nd => a\ne => \nf => b'
        expect{ Order.new.execute jobs_string }.to raise_error
      end
    end
  end

end