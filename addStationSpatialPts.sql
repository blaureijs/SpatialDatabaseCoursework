/*	Project:	AV Research
	Purpose:	Add Spatial Points for AV Weather Station table
	Author:		Brian Laureijs
	Date:		December 2018	                               */
	
-- Load the PostGIS extension
drop extension if exists postgis cascade;
create extension postgis;

-- Check to make sure the extension was successfully loaded
select postgis_full_version();

-- Drop column for rerunnability
alter table station
drop column if exists shape cascade;

-- Add shape column to station table
alter table station
add column shape geometry('POINTZ',32620,2);

-- Update shape column for UTM zone 20
update station
set	shape=ST_GeomFromText('POINTZ('||easting||' '||northing||' '||elevation||')',32620)
where utmzone like '20T';

-- Update shape column for UTM zone 19, transform to zone 20
update station
set	shape=ST_Transform(ST_GeomFromText('POINTZ('||easting||' '||northing||' '||elevation||')',32619),32620)
where utmzone like '19T';

-- Select station
select stationid,stationname,utmzone,easting,northing,elevation,deployed,stationtype,propertyid,st_astext(shape) from station;