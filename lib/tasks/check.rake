task :check => :environment do
  require 'open-uri'

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

  loop do
    Check.create! up: internet_connection?
    sleep 30
  end
end
