#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))+'/lib')

require 'viaggiatreno'
require 'net/http'

# un argomento numerico: query by numero treno

if ARGV[0].match("[0-9]+")
	train=Train.new(ARGV[0])
	puts train.status 
	puts train.lastStop
	puts train.trainStops
	exit
end

# più argomenti: query per stazione di partenza e destinazione
from=ARGV[0]
to=ARGV[1]

station=Station.new(from,to)

if station.station_select.size > 0
	puts station.station_select
	exit
end

if ! to
	puts station 
	exit
end

station.trains.each do |k,v|
	match_con_partenza=false
	match_con_arrivo=false
	printed=false
	train=Train.new(k)

	stop1 = nil
	train.trainStops.each do |stop|
		stop2=nil
		if stop.trainStation.match(station.stationFrom)
	 		match_con_partenza=true
	 		stop1=stop
	 	end
	 	if match_con_partenza && stop.trainStation.match(station.stationTo)
	 		match_con_arrivo=true
	 		stop2=stop
	 	end

		if match_con_arrivo && match_con_partenza 
			if ! printed
			puts "#{v} - "+train.status
			puts stop1 if stop1
			printed=true
			end
			puts stop2 if stop2
		end		
	end
	puts "="*80 if match_con_partenza && match_con_arrivo
end