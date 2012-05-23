# capture StdIn/StdOut, from Clamp's spec/spec_helper.rb
module OutputCapture

  def self.included(target)
  
    target.before do
      $stdout = @out = StringIO.new
      $stderr = @err = StringIO.new
    end
    
    target.after do
      $stdout = STDOUT
      $stderr = STDERR
    end
    
  end
  
  def stdout
    @out.string
  end
  
  def stderr
    @err.string
  end

end

