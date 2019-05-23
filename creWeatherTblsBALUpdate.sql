/*	Project:	AV Research
	Purpose:	Create tables for AV Reasearch Weather DB using refined DB model.
				Include reference tables and resolve M:N relationships.
	Author:		Brian Laureijs
	Date:		October 2018	                                                  */

--delete existing tables if necessary
DROP TABLE IF EXISTS Maintenance cascade;
DROP TABLE IF EXISTS Researcher cascade;
DROP TABLE IF EXISTS Reading cascade;
DROP TABLE IF EXISTS Station cascade;
DROP TABLE IF EXISTS StationType cascade;
DROP TABLE IF EXISTS Property cascade;
DROP TABLE IF EXISTS Volunteer cascade;
DROP TABLE IF EXISTS Town cascade;
DROP TABLE IF EXISTS County cascade;

--create Town reference entity
create table Town
	(	townID smallint primary key,
		townname varchar(50) not null unique
	);

--create County reference entity
create table County
	(	countyID char(3) primary key,
		countyname varchar(50) not null unique
	);

--create Volunteer table
create table Volunteer
	(	volunteerID smallint primary key,
		firstname varchar(50),
		lastname varchar(50) not null,
	 	streetaddress varchar(50),
	 	townID smallint references Town(townID) not null,
		countyID char(3) references County(countyID) not null,
	 	postcode char(6),
	 	phone numeric(10)
	);

--create Property table
create table Property
	(	propertyID smallint primary key,
	 	streetaddress varchar(50),
	 	townID smallint references Town(townID) not null,
	 	county char(3) references County(countyID) not null,
	 	postcode char(6),
	 	volunteerID smallint references Volunteer(volunteerID) not null
	);

--create Station Type reference entity
--Two letter abbreviation of type will be used as ID
create table StationType
	(	stationtypeID char(2) primary key,
	 	description varchar(30) not null unique
	);

--create Station table
create table Station
	(	stationID numeric(3) primary key,
	 	stationname	varchar(50) not null,
	 	utmzone char(3),
		easting numeric(11,3),
	 	northing numeric(11,3),
	 	elevation numeric(7,3),
	 	deployed date,
	 	stationtype char(2) references StationType(stationtypeID) not null,
	 	propertyID smallint references Property(propertyID) not null
	);
	
--create Reading table
create table Reading
	(	readingID serial primary key,
	 	readingdate date,
	 	stationID numeric(3) references Station(stationID) not null,
	 	dayofyear numeric(3),
	 	avgairtemp numeric(4,2),
	 	maxairtemp numeric(4,2),
	 	minairtemp numeric(4,2),
	 	avgrh numeric(5,2),
	 	maxwind numeric(5,2),
	 	avgsolar numeric(3,2),
	 	totalsolar numeric(5,2),
	 	avgbp numeric(4),
	 	avgsoiltemp numeric(5,3),
	 	totalrainfall numeric(5,1) 	
	);

--create ResearcherPosition reference entity
create table ResearcherPosition
	(	positionID char(2) primary key,
		title varchar(50) not null
	);

--create Researcher table
create table Researcher
	(	researcherID smallint primary key,
	 	firstname varchar(50),
		lastname varchar(50) not NULL,
	 	researchposition char(2) references ResearcherPosition(positionID),
	 	email varchar(50),
	 	phone numeric(10)
	);
	
--create Maintenance table
create table Maintenance
	(	recordID serial primary key,
	 	researcherID smallint references Researcher(researcherID) not null,
		stationID numeric(3) references Station(stationID) not null,
	 	maintenancedate date not null
	);