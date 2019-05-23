/*	Purpose:	Query the AV Research Weather DB
	Author:		Brian Laureijs
	Date:		September 2018	*/

-- Show all temperature readings for station 40 in January 2004, sorted by date
select avgairtemp,maxairtemp,minairtemp,avgsoiltemp 
from reading
where stationid = 40 and readingdate > '2003-12-31' and readingdate < '2004-02-01'
order by readingdate
;

-- show weather station ids, names, and coordinates for "Tower/Tripod" stations, sort by station number
select s.stationid,s.stationname,s.utmzone,s.easting,s.northing,s.elevation
from station s
join stationtype st
on s.stationtype = st.stationtypeid
where st.description like 'Tower Tripod'
order by stationid
;

-- List property street address and station ids and names for stations taht have readins in feb 2004, sort by station id
select p.streetaddress, s.stationid, s.stationname
from property p 
join station s
on p.propertyid = s.propertyid
join reading r
on s.stationid = r.stationid
where r.readingdate > '2004-01-31' and readingdate < '2004-03-01'
order by stationid
;

-- outer join: list all weather station types and any weather stations names associated with the types, sorted by type and description
select st.description,s.stationname
from stationtype st
left join station s
on s.stationtype = st.stationtypeid
order by st.stationtypeid,st.description
;

-- what is the average total rainfall for all stations between day 200 and day 300?
select avg(totalrainfall)::numeric(5,2) "Avg Total Rainfall"
from reading
where dayofyear > 200 and dayofyear < 300
;