/*	Project:	AV Research
	Purpose:	Populate tables for AV Research database.
	Author:		Brian Laureijs
	Date:		October 2018	                               */
	
-- Delete existing data (child tables first)
delete from Maintenance;
delete from Researcher;
delete from ResearcherPosition;
delete from Reading;
delete from Station;
delete from StationType;
delete from Property;
delete from Volunteer;
delete from Town;
delete from County;

-- Add data into Town reference table
insert into Town values
	(11,'Wolfville'),
	(12,'Kentville'),
	(13,'Berwick'),
	(14,'Greenwood'),
	(21,'Middleton'),
	(22,'Lawrencetown'),
	(23,'Annapolis Royal'),
	(31,'Digby'),
	(32,'Weymouth'),
	(41,'Yarmouth'),
	(51,'Shelburne'),
	(61,'Caledonia'),
	(62,'Liverpool');

-- Add data into County reference table
insert into County values
	('KIN','Kings'),
	('ANA','Annapolis'),
	('DIG','Digby'),
	('YAR','Yarmouth'),
	('SHE','Shelburne'),
	('QUE','Queens');

-- Add data into Volunteer table
insert into Volunteer values
	(01,'Ben','Kenobi','77 Gaspereau Avenue',11,'KIN','B3P4Y7','9021234567'),
	(02,'Leia','Organa','26 Belcher Street',12,'KIN','B3U6P9','9029876543'),
	(03,'Luke','Skywalker','77 Gaspereau Avenue',11,'KIN','B3P4Y7','9021234567'),
	(04,'Sheev','Palpatine','82 Union Street',13,'KIN','B3P5H3','9022347890'),
	(05,'Lando','Calrissian','56 Middle Road',22,'ANA','B0P2M5','9021294768'),
	(06,'Han','Solo','24 Water Street',31,'DIG','B0T3R6','9024039487'),
	(07,'Mace','Windu','87 Argyle Street',41,'YAR','B0P4T7','9029384762'),
	(08,'Jyn','Erso','12 Westfield Road',61,'QUE','B4P6D3','9022534857');

-- Add data into Property table
insert into Property values
	(101,'55 Commercial Street',13,'KIN','B4P7J4',01),
	(102,'73 Forest Road',14,'KIN','B4P8R6',02),
	(103,'83 Long Road',51,'SHE','B4P8F0',04),
	(104,'65 Wickwire Avenue',41,'YAR','B0T7J4',07),
	(105,'22 Water Street',31,'DIG','B9W7J4',06),
	(106,'1287 Hwy 1',32,'DIG','B8G7J4',06),
	(107,'2344 Route 201',23,'ANA','B0M2S5',05),
	(108,'155 Major Street',62,'QUE','B4P8F3',08),
	(109,'123 Test Street',13,'KIN','B4P2P3',01);

-- Add data into StationType reference table
insert into StationType values
	('TD','Temperature Datalogger'),
	('DW','DryWet Bulb'),
	('TT','Tower Tripod'),
	('MS','Meteorological Station');

-- Add data into Station table
insert into Station values
	(10,'Alpha','20T',363125,4990197,18.9,'7/14/2013','TD',101),
	(20,'Beta','20T',349254,4981155,20.5,'5/18/2012','DW',102),
	(30,'Gamma','20T',314159,4849320,10.3,'7/14/2013','TT',103),
	(40,'Delta','19T',733862,4858613,5.8,'4/17/2015','MS',104),
	(50,'Epsilon','20T',279999,4944555,27.1,'3/19/2013','MS',105),
	(60,'Zeta','20T',283409,4942839,12.9,'7/18/2015','TT',106),
	(70,'Eta','20T',303199,4957167,16.1,'7/14/2013','TD',107),
	(80,'Theta','20T',360768,4878276,12.9,'7/14/2013','DW',108),
	(90,'Iota','20T',360243,4877886,17.9,'7/14/2013','TD',108);

-- Add data to Researcher Position reference table 
insert into ResearcherPosition values
	('LM','Lead Meteorologist'),
	('MT','Meteorology Technician'),
	('BI','Biologist'),
	('EC','Ecologist'),
	('GS','Geographic Information Systems Technician');

-- Add data to Researcher table
insert into Researcher values
	(01,'John','Snow','LM','jsnow@avresearch.ca','9023103030'),
	(02,'Arya','Stark','BI','astark@avresearch.ca','9024296666'),
	(03,'Jamie','Lannister','EC','jlannister@avresearch.ca','9024256666'),
	(04,'Stannis','Baratheon','GS','sbaratheon@avresearch.ca','9023333030'),
	(05,'Brienne','Tarth','MT','btarth@avresearch.ca','9023111030'),
	(06,'Sam','Tarly','MT','starly@avresearch.ca','9023103045'),
	(07,'Davos','Seaworth','GS','dseaworth@avresearch.ca','9023103067');

-- Add data into Maintenance table
insert into Maintenance(researcherID,stationID,maintenancedate) values
	(06,10,'3/01/2018'),
	(06,20,'3/01/2018'),
	(06,20,'3/01/2018'),
	(04,30,'3/02/2018'),
	(05,40,'3/03/2018'),
	(05,40,'3/03/2018'),
	(03,50,'3/04/2018'),
	(07,60,'3/04/2018'),
	(07,70,'3/05/2018');

-- Add data into Reading table using CSV import tool
copy Reading(readingdate,stationID,dayofyear,avgairtemp,maxairtemp,minairtemp,avgrh,maxwind,avgsolar,totalsolar,avgbp,avgsoiltemp,totalrainfall)
	from 'D:\postgres\WeatherDataSample.csv' delimiter ',' csv header;
