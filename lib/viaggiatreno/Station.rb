require_relative 'ScraperStation.rb'

class Station
	attr_accessor  :stationFrom, :stationTo, :station_select, :trains
	
def initialize(stationFrom, stationTo = nil)
	@stationFrom = stationFrom.upcase
	@stationTo = stationTo.upcase if stationTo
	@trains = Hash.new()
	@destinations = Array.new()
	self.update()
end

	def update()
		scraper = ScraperStation.new(@stationFrom,@stationTo)
		scraper.updateStation()
		@trains=scraper.trains
		@destinations=scraper.destinations.uniq
		@station_select=scraper.station_select.uniq
	end

def to_s
	retval=""
	@trains.each do |k,v|
		retval += "#{v}\n"
	end
	return retval
end


end