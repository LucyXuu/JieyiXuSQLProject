USE INFO_330B_Proj_PolarBears


CREATE TABLE tblMEMBERS (
 MemberID INT IDENTITY(1,1) PRIMARY KEY,
 MemberFName VARCHAR(50),
 MemberLName Varchar(50),
 MemberEmail Varchar(50),
 MemberAge VARCHAR(10)
)
ALTER TABLE tblMEMBERS DROP COLUMN MemberAge
ALTER TABLE tblMEMBERS ADD MemberBDay DATE

CREATE TABLE tblOfficerTitle(
    OfficerTitleID INT IDENTITY(1, 1) PRIMARY KEY,
    OfficerTitleName VARCHAR(50)
)

CREATE TABLE tblOFFICERS(
    OfficerID INT IDENTITY(1, 1) PRIMARY KEY,
    OfficerFName VARCHAR(50),
    OfficerLName VARCHAR(50),
    OfficerEmail VARCHAR(50),
    OfficerPhone INT,
    MemberID INT REFERENCES tblMEMBERS(MemberID),
    OfficerTitleID INT REFERENCES tblOfficerTitle(OfficerTitleID)
)
ALTER TABLE tblOFFICERS
ALTER COLUMN OfficerPhone VARCHAR(20)

CREATE TABLE tblHouses (
HouseID INT IDENTITY(1, 1) PRIMARY KEY,
House VARCHAR(50),
AddressID INT,
AddressCity VARCHAR(80),
AddressState VARCHAR(80),
AddressCountry VARCHAR(80),
AddressPostal INT
)

ALTER TABLE tblHouses DROP COLUMN AddressID
ALTER TABLE tblHouses DROP COLUMN House
ALTER TABLE tblHouses ADD HouseName VARCHAR(80)
ALTER TABLE tblHouses ALTER COLUMN AddressPostal VARCHAR(50)


CREATE TABLE tblTrips(
    TripID INT IDENTITY(1,1) PRIMARY KEY,
    HouseID INT REFERENCES tblHouses(HouseID),
    OfficerID INT REFERENCES tblOFFICERS(OfficerID)
)

CREATE TABLE tblTripStudent(
    TripID INT REFERENCES tblTRIPS(TripID),
    MemberID INT REFERENCES tblMEMBERS(MemberID),
    HouseID INT REFERENCES tblHOUSES(HouseID)
)

CREATE TABLE tblPayments (
PaymentID INT IDENTITY(1, 1) PRIMARY KEY,
MemberID INT REFERENCES tblMEMBERS(MemberID),
PaymentDate DATE,
PaymentAmount DECIMAL(20, 2),
PaymentType VARCHAR(80)
)

CREATE TABLE tblTrips_Payment (
PaymentID INT REFERENCES tblPayments(PaymentID),
TripID INT REFERENCES tblTrips(TripID)
)

CREATE TABLE tblMerch_Type (
MerchTypeID INT IDENTITY(1, 1) PRIMARY KEY,
MerchTypeName VARCHAR(80),
MerchNumOrder INT,
MerchTypeCost DECIMAL(20, 2),
PurchaseTypeID INT
)

ALTER TABLE tblMerch_Type
DROP COLUMN MerchNumOrder

ALTER TABLE tblMerch_Type
DROP COLUMN PurchaseTypeID

CREATE TABLE tblMerch (
MerchID INT IDENTITY(1, 1) PRIMARY KEY,
MerchTypeID INT REFERENCES tblMerch_Type(MerchTypeID),
MerchName VARCHAR(80)
)

CREATE TABLE tblMerchPayment (
PaymentID INT REFERENCES tblPayments(PaymentID),
MerchID INT REFERENCES tblMerch(MerchID)
)

CREATE TABLE tblMountain_Payments(
    MountainID INT IDENTITY (1,1) PRIMARY KEY,
    MountainPayment INT,
    MountainName VARCHAR(50)
)

CREATE TABLE tblGas_Payments(
    GasPaymentID INT IDENTITY(1,1) PRIMARY KEY,
    NumPeopleDriven INT,
    MountainID INT REFERENCES tblMountain_Payments(MountainID),
    DateRequested DATE,
    DatePaid DATE,
    MemberID INT REFERENCES tblMEMBERS(MemberID)
)

-- Create stored procedure to insert data into table Members using the parameters MemberFName, MemberLName,
-- MemberEmail, Member Birthday
GO
CREATE OR ALTER PROCEDURE insert_member
@MemberFName VARCHAR(50),
@MemberLName VARCHAR(50),
@MemberEmail VARCHAR(100),
@MemberBDay DATE
AS
BEGIN TRANSACTION
INSERT INTO tblMEMBERS(MemberFName, MemberLName, MemberEmail, MemberBDay)
VALUES (@MemberFName, @MemberLName, @MemberEmail, @MemberBDay)
COMMIT TRANSACTION
GO

EXECUTE insert_member
@MemberFName = 'Olivia',
@MemberLName = 'Adams',
@MemberEmail = 'oadams@uw.edu',
@MemberBday = '1999-01-01'

EXECUTE insert_member
@MemberFName = 'Alec',
@MemberLName = 'Wostmann',
@MemberEmail = 'awostmann@uw.edu',
@MemberBday = '2000-02-02'

EXECUTE insert_member
@MemberFName = 'Zack',
@MemberLName = 'Steinberg',
@MemberEmail = 'zsteiny@uw.edu',
@MemberBday = '2000-03-03'

EXECUTE insert_member
@MemberFName = 'Sofiya',
@MemberLName = 'Mitchell',
@MemberEmail = 'smitch@uw.edu',
@MemberBday = '2002-04-04'

EXECUTE insert_member
@MemberFName = 'Aidan',
@MemberLName = 'Toney',
@MemberEmail = 'atoney@uw.edu',
@MemberBday = '2001-05-05'

EXECUTE insert_member
@MemberFName = 'Amara',
@MemberLName = 'Coloros',
@MemberEmail = 'acolor@uw.edu',
@MemberBday = '1999-06-06'

EXECUTE insert_member
@MemberFName = 'Riley',
@MemberLName = 'Keeler',
@MemberEmail = 'rkeeler@uw.edu',
@MemberBday = '2004-07-07'

EXECUTE insert_member
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberEmail = 'jcav@uw.edu',
@MemberBday = '2004-08-08'

EXECUTE insert_member
@MemberFName = 'Josh',
@MemberLName = 'Sherbrooke',
@MemberEmail = 'jsherbro@uw.edu',
@MemberBday = '2000-09-09'

EXECUTE insert_member
@MemberFName = 'Elizabeth',
@MemberLName = 'Williams',
@MemberEmail = 'ewill@uw.edu',
@MemberBday = '2003-10-10'

EXECUTE insert_member
@MemberFName = 'Noah',
@MemberLName = 'Roger',
@MemberEmail = 'boaterboy@uw.edu',
@MemberBday = '2004-11-11'

SELECT * FROM tblMEMBERS

-- Create stored procedure to insert data into tblHouses using the parameters
-- @HouseName, @AddressCity, @AddressState, @AddressCountry, @AddressPostal
GO
CREATE OR ALTER PROCEDURE insert_house
@HouseName VARCHAR(80),
@AddressCity VARCHAR(50),
@AddressState VARCHAR(40),
@AddressCountry VARCHAR(100),
@AddressPostal VARCHAR(30)
AS
BEGIN TRANSACTION
INSERT INTO tblHouses(HouseName, AddressCity, AddressState, AddressCountry, AddressPostal)
VALUES (@HouseName, @AddressCity, @AddressState, @AddressCountry, @AddressPostal)
COMMIT TRANSACTION
GO

EXECUTE insert_house
@HouseName = 'Church House',
@AddressCity = 'Revelstoke',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOE OC2'

EXECUTE insert_house
@HouseName = 'Clubhouse',
@AddressCity = 'Revelstoke',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOE OC2'

EXECUTE insert_house
@HouseName = 'Trailer Place',
@AddressCity = 'Trail',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

EXECUTE insert_house
@HouseName = 'Palace',
@AddressCity = 'Rossland',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

EXECUTE insert_house
@HouseName = 'No-Ski House',
@AddressCity = 'Schweitzer',
@AddressState = 'Idaho',
@AddressCountry = 'United States',
@AddressPostal = '83864'

EXECUTE insert_house
@HouseName = 'Hot-Tub Home',
@AddressCity = 'Government Camp',
@AddressState = 'Oregon',
@AddressCountry = 'United States',
@AddressPostal = '97028'

EXECUTE insert_house
@HouseName = 'Couve Couture',
@AddressCity = 'Vancouver',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'V5K OB5'

EXECUTE insert_house
@HouseName = 'Lake Monster',
@AddressCity = 'Banff',
@AddressState = 'Alberta',
@AddressCountry = 'Canada',
@AddressPostal = 'T1L OA1'

EXECUTE insert_house
@HouseName = 'Old People Home',
@AddressCity = 'Baker',
@AddressState = 'Washington',
@AddressCountry = 'United States',
@AddressPostal = '98244'

EXECUTE insert_house
@HouseName = 'Red Treehouse',
@AddressCity = 'Rossland',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

-- Create stored procedure to insert data into Trips and TripsStudent

-- Create stored procedure to insert data into table Members using the parameters MemberFName, MemberLName,
-- MemberEmail, Member Birthday
GO
CREATE OR ALTER PROCEDURE insert_member
@MemberFName VARCHAR(50),
@MemberLName VARCHAR(50),
@MemberEmail VARCHAR(100),
@MemberBDay DATE
AS
BEGIN TRANSACTION
INSERT INTO tblMEMBERS(MemberFName, MemberLName, MemberEmail, MemberBDay)
VALUES (@MemberFName, @MemberLName, @MemberEmail, @MemberBDay)
COMMIT TRANSACTION
GO

EXECUTE insert_member
@MemberFName = 'Olivia',
@MemberLName = 'Adams',
@MemberEmail = 'oadams@uw.edu',
@MemberBday = '1999-01-01'

EXECUTE insert_member
@MemberFName = 'Alec',
@MemberLName = 'Wostmann',
@MemberEmail = 'awostmann@uw.edu',
@MemberBday = '2000-02-02'

EXECUTE insert_member
@MemberFName = 'Zack',
@MemberLName = 'Steinberg',
@MemberEmail = 'zsteiny@uw.edu',
@MemberBday = '2000-03-03'

EXECUTE insert_member
@MemberFName = 'Sofiya',
@MemberLName = 'Mitchell',
@MemberEmail = 'smitch@uw.edu',
@MemberBday = '2002-04-04'

EXECUTE insert_member
@MemberFName = 'Aidan',
@MemberLName = 'Toney',
@MemberEmail = 'atoney@uw.edu',
@MemberBday = '2001-05-05'

EXECUTE insert_member
@MemberFName = 'Amara',
@MemberLName = 'Coloros',
@MemberEmail = 'acolor@uw.edu',
@MemberBday = '1999-06-06'

EXECUTE insert_member
@MemberFName = 'Riley',
@MemberLName = 'Keeler',
@MemberEmail = 'rkeeler@uw.edu',
@MemberBday = '2004-07-07'

EXECUTE insert_member
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberEmail = 'jcav@uw.edu',
@MemberBday = '2004-08-08'

EXECUTE insert_member
@MemberFName = 'Josh',
@MemberLName = 'Sherbrooke',
@MemberEmail = 'jsherbro@uw.edu',
@MemberBday = '2000-09-09'

EXECUTE insert_member
@MemberFName = 'Elizabeth',
@MemberLName = 'Williams',
@MemberEmail = 'ewill@uw.edu',
@MemberBday = '2003-10-10'

EXECUTE insert_member
@MemberFName = 'Noah',
@MemberLName = 'Roger',
@MemberEmail = 'boaterboy@uw.edu',
@MemberBday = '2004-11-11'

SELECT * FROM tblMEMBERS

-- Create stored procedure to insert data into tblHouses using the parameters
-- @HouseName, @AddressCity, @AddressState, @AddressCountry, @AddressPostal
GO
CREATE OR ALTER PROCEDURE insert_house
@HouseName VARCHAR(80),
@AddressCity VARCHAR(50),
@AddressState VARCHAR(40),
@AddressCountry VARCHAR(100),
@AddressPostal VARCHAR(30)
AS
BEGIN TRANSACTION
INSERT INTO tblHouses(HouseName, AddressCity, AddressState, AddressCountry, AddressPostal)
VALUES (@HouseName, @AddressCity, @AddressState, @AddressCountry, @AddressPostal)
COMMIT TRANSACTION
GO

EXECUTE insert_house
@HouseName = 'Church House',
@AddressCity = 'Revelstoke',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOE OC2'

EXECUTE insert_house
@HouseName = 'Clubhouse',
@AddressCity = 'Revelstoke',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOE OC2'

EXECUTE insert_house
@HouseName = 'Trailer Place',
@AddressCity = 'Trail',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

EXECUTE insert_house
@HouseName = 'Palace',
@AddressCity = 'Rossland',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

EXECUTE insert_house
@HouseName = 'No-Ski House',
@AddressCity = 'Schweitzer',
@AddressState = 'Idaho',
@AddressCountry = 'United States',
@AddressPostal = '83864'

EXECUTE insert_house
@HouseName = 'Hot-Tub Home',
@AddressCity = 'Government Camp',
@AddressState = 'Oregon',
@AddressCountry = 'United States',
@AddressPostal = '97028'

EXECUTE insert_house
@HouseName = 'Couve Couture',
@AddressCity = 'Vancouver',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'V5K OB5'

EXECUTE insert_house
@HouseName = 'Lake Monster',
@AddressCity = 'Banff',
@AddressState = 'Alberta',
@AddressCountry = 'Canada',
@AddressPostal = 'T1L OA1'

EXECUTE insert_house
@HouseName = 'Old People Home',
@AddressCity = 'Baker',
@AddressState = 'Washington',
@AddressCountry = 'United States',
@AddressPostal = '98244'

EXECUTE insert_house
@HouseName = 'Red Treehouse',
@AddressCity = 'Rossland',
@AddressState = 'British Columbia',
@AddressCountry = 'Canada',
@AddressPostal = 'VOG OB4'

-- Create stored procedure to insert data into Trips and TripsStudent
GO
CREATE OR ALTER PROCEDURE insert_tripandstudent
@HouseName VARCHAR(50),
@AddressPostal VARCHAR(30),
@MemberFName VARCHAR(50),
@MemberLName VARCHAR(50),
@MemberBDay DATE,
@OfficerFName VARCHAR(50),
@OfficerLName VARCHAR(50),
@OfficerEmail VARCHAR(80)
AS
DECLARE @HouseID INT, @MemberID INT, @OfficerID INT, @TripID INT
SET @HouseID = (SELECT HouseID FROM tblHouses
                WHERE HouseName = @HouseName AND AddressPostal = @AddressPostal)

SET @MemberID = (SELECT MemberID FROM tblMEMBERS
                 WHERE MemberFName = @MemberFName AND MemberLName = @MemberLName
                 AND MemberBDay = @MemberBDay)

SET @OfficerID = (SELECT OfficerID FROM tblOFFICERS o
                  JOIN tblMembers m ON o.MemberID = m.MemberID
                  WHERE m.memberFName = @OfficerFName AND m.MemberLname = @OfficerLName
                  AND m.MemberEmail = @OfficerEmail)

IF NOT EXISTS(
    SELECT *
    FROM tblTrips
    WHERE HouseID = @HouseID
    AND OfficerID = @OfficerID
)
BEGIN
BEGIN TRANSACTION
INSERT INTO tblTRIPS(HouseID, OfficerID)
VALUES(@HouseID, @OfficerID)
COMMIT TRANSACTION
END

SET @TripID = (
    SELECT TripID FROM tblTrips
    WHERE HouseID = @HouseID
    AND OfficerID = @OfficerID
)

BEGIN TRANSACTION
INSERT INTO tblTripStudent
VALUES(@TripID, @MemberID, @HouseID)
COMMIT TRANSACTION
GO

-- Create a procedure to insert data into  tblPayments
GO
CREATE OR ALTER PROCEDURE insert_payments
@memberfname VARCHAR(80),
@memberbday DATE,
@paymentdate DATE,
@paymentamount DECIMAL(20, 2),
@paymenttype VARCHAR(80)
AS

DECLARE @memberid INT, @paymentid INT

SET @memberid =
(SELECT MemberID
FROM tblMembers
WHERE MemberFName = @memberfname
AND MemberBDay = @memberbday)

SET @paymentid =
(SELECT PaymentID
FROM tblPayments
WHERE PaymentDate = @paymentdate
AND PaymentAmount = @paymentamount
AND PaymentType = @paymenttype)

BEGIN TRANSACTION
INSERT INTO tblPayments(MemberID, PaymentDate, PaymentAmount, PaymentType)
VALUES (@memberid, @paymentdate, @paymentamount, @paymenttype)
COMMIT TRANSACTION
GO

EXECUTE insert_payments
@memberfname = 'Olivia',
@memberbday = '1999-01-01',
@paymentdate = '2019-01-01',
@paymentamount = '85.50',
@paymenttype = 'Credit'

EXECUTE insert_payments
@memberfname = 'Alec',
@memberbday = '2000-02-02',
@paymentdate = '2017-05-29',
@paymentamount = '90.00',
@paymenttype = 'Credit'

EXECUTE insert_payments
@memberfname = 'Zack',
@memberbday = '2000-03-03',
@paymentdate = '2017-08-12',
@paymentamount = '85.50',
@paymenttype = 'Debit'

EXECUTE insert_payments
@memberfname = 'Sofiya',
@memberbday = '2002-04-04',
@paymentdate = '2020-06-12',
@paymentamount = '93.20',
@paymenttype = 'Debit'

EXECUTE insert_payments
@memberfname = 'Aidan',
@memberbday = '2001-05-05',
@paymentdate = '2021-05-13',
@paymentamount = '97.50',
@paymenttype = 'Cash'

EXECUTE insert_payments
@memberfname = 'Amara',
@memberbday = '1999-06-06',
@paymentdate = '2019-02-19',
@paymentamount = '98.00',
@paymenttype = 'Cash'

EXECUTE insert_payments
@memberfname = 'Riley',
@memberbday ='2004-07-07',
@paymentdate = '2018-11-15',
@paymentamount = '82.50',
@paymenttype = 'Debit'

EXECUTE insert_payments
@memberfname = 'Jordan',
@memberbday ='2004-08-08',
@paymentdate = '2020-09-11',
@paymentamount = '125.80',
@paymenttype = 'Cash'

EXECUTE insert_payments
@memberfname = 'Josh',
@memberbday = '2000-09-09',
@paymentdate = '2021-05-09',
@paymentamount = '105.70',
@paymenttype = 'Credit'

EXECUTE insert_payments
@memberfname = 'Elizabeth',
@memberbday = '2003-10-10',
@paymentdate = '2020-03-03',
@paymentamount = '225.70',
@paymenttype = 'Cash'

SELECT *
FROM tblPayments

-- Create a procedure to insert data into tblMountain_Payments
GO
CREATE OR ALTER PROCEDURE insert_mountainpayments
@mountainpayment DECIMAL(20, 2),
@mountainname VARCHAR(80)
AS

BEGIN TRANSACTION
INSERT INTO tblMountain_Payments(MountainPayment, MountainName)
VALUES (@mountainpayment, @mountainname)
COMMIT TRANSACTION
GO

EXECUTE insert_mountainpayments
@mountainpayment = '110.50',
@mountainname = 'Mount Rainier'

EXECUTE insert_mountainpayments
@mountainpayment = '125.50',
@mountainname = 'Mount Baker'

EXECUTE insert_mountainpayments
@mountainpayment = '130.00',
@mountainname = 'Crystal Mountain'

EXECUTE insert_mountainpayments
@mountainpayment = '100.00',
@mountainname = 'Stevens Pass'

EXECUTE insert_mountainpayments
@mountainpayment = '100.50',
@mountainname = 'White Pass Ski'

EXECUTE insert_mountainpayments
@mountainpayment = '150.50',
@mountainname = 'WHistler Backcomb'

EXECUTE insert_mountainpayments
@mountainpayment = '98.50',
@mountainname = 'Lake Louise'

EXECUTE insert_mountainpayments
@mountainpayment = '278.50',
@mountainname = 'Sun Peaks'

EXECUTE insert_mountainpayments
@mountainpayment = '145.20',
@mountainname = 'Red Pine'

EXECUTE insert_mountainpayments
@mountainpayment = '120.50',
@mountainname = 'Saint Mary'

SELECT *
FROM tblMountain_Payments


-- Create a procedure to insert data into tblGas_Payments
GO
CREATE OR ALTER PROCEDURE insert_gaspayments
@numpeopledriven INT,
@mountainid INT,
@daterequested DATE,
@datepaid DATE,
@memberid INT
AS

BEGIN TRANSACTION
INSERT INTO tblGas_Payments(NumPeopleDriven, MountainID, DateRequested, DatePaid, MemberID)
VALUES (@numpeopledriven, @mountainid, @daterequested, @datepaid, @memberid)
COMMIT TRANSACTION
GO

EXECUTE insert_gaspayments
@numpeopledriven = '30',
@mountainid = '1',
@daterequested = '2020-12-02',
@datepaid =  '2020-12-26',
@memberid = '1'

EXECUTE insert_gaspayments
@numpeopledriven = '32',
@mountainid = '2',
@daterequested = '2019-09-02',
@datepaid =  '2020-01-03',
@memberid = '2'

EXECUTE insert_gaspayments
@numpeopledriven = '28',
@mountainid = '3',
@daterequested = '2017-11-02',
@datepaid =  '2017-11-19',
@memberid = '3'

EXECUTE insert_gaspayments
@numpeopledriven = '28',
@mountainid = '4',
@daterequested = '2019-08-05',
@datepaid =  '2019-08-09',
@memberid = '4'

EXECUTE insert_gaspayments
@numpeopledriven = '34',
@mountainid = '5',
@daterequested = '2016-04-09',
@datepaid =  '2016-05-02',
@memberid = '5'

EXECUTE insert_gaspayments
@numpeopledriven = '32',
@mountainid = '6',
@daterequested = '2021-01-29',
@datepaid =  '2021-03-01',
@memberid = '6'

EXECUTE insert_gaspayments
@numpeopledriven = '29',
@mountainid = '7',
@daterequested = '2018-03-11',
@datepaid =  '2018-03-25',
@memberid = '7'

EXECUTE insert_gaspayments
@numpeopledriven = '33',
@mountainid = '8',
@daterequested = '2017-02-02',
@datepaid =  '2018-02-06',
@memberid = '8'

EXECUTE insert_gaspayments
@numpeopledriven = '31',
@mountainid = '9',
@daterequested = '2020-06-17',
@datepaid =  '2020-07-01',
@memberid = '9'

EXECUTE insert_gaspayments
@numpeopledriven = '31',
@mountainid = '10',
@daterequested = '2015-09-02',
@datepaid =  '2015-09-22',
@memberid = '10'

SELECT *
FROM tblGas_payments


-- Create procedure and execute a new row into tblMountain_Payments given the input parameters of
-- @mountainpayment, @mountainname, @daterequested, @datepaid, @memberfname, and @memberlname
GO
CREATE OR ALTER PROCEDURE insert_paymentstudents
@mountainpayment DECIMAL(20, 2),
@mountainname VARCHAR(80),
@daterequested DATE,
@datepaid DATE,
@memberfname VARCHAR(80),
@memberlname VARCHAR(80)
AS

DECLARE @mountainid INT, @gaspaymentid INT, @memberid INT

SET @mountainid =
(SELECT MountainID FROM tblMountain_Payments
WHERE MountainPayment = @mountainpayment
AND MountainName = @mountainname)

SET @gaspaymentid =
(SELECT GasPaymentID FROM tblGas_payments
WHERE DateRequested = @daterequested
AND DatePaid = @datepaid)

SET @memberid =
(SELECT MemberID FROM tblMembers
WHERE MemberFName = @memberfname
AND MemberLName = @memberlname)

BEGIN TRANSACTION
INSERT INTO tblMountain_Payments (MountainPayment, MountainName)
VALUES (@mountainpayment, @mountainname)
COMMIT TRANSACTION
GO

EXECUTE insert_paymentstudents
@mountainpayment = '250.50',
@mountainname = 'Panorama',
@daterequested ='2020-10-15',
@datepaid ='2021-11-02',
@memberfname = 'Mary',
@memberlname = 'John'

--inserting the trip and tripstudent with procedure by Michelle, since I populate the officer and
--it is needed in trip info
EXECUTE insert_tripandstudent
@HouseName = 'Red Treehouse',
@AddressPostal = 'VOG OB4',
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberBDay = '2004-08-08',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Red Treehouse',
@AddressPostal = 'VOG OB4',
@MemberFName = 'Noah',
@MemberLName = 'Roger',
@MemberBDay = '2004-11-11',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Trailer Place',
@AddressPostal = 'VOG OB4',
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberBDay = '2004-08-08',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'No-Ski House',
@AddressPostal = '83864',
@MemberFName = 'Aidan',
@MemberLName = 'Toney',
@MemberBDay = '2001-05-05',
@OfficerFName = 'Alec',
@OfficerLName = 'Wostmann',
@OfficerEmail = 'awostmann@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Hot-Tub Home',
@AddressPostal = '97028',
@MemberFName = 'Joy',
@MemberLName = 'Ful',
@MemberBDay = '2006-01-01',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Lake Monster',
@AddressPostal = 'T1L OA1',
@MemberFName = 'Amara',
@MemberLName = 'Coloros',
@MemberBDay = '1999-06-06',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Red Treehouse',
@AddressPostal = 'VOG OB4',
@MemberFName = 'Amara',
@MemberLName = 'Coloros',
@MemberBDay = '1999-06-06',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Old People Home',
@AddressPostal = '98244',
@MemberFName = 'Alec',
@MemberLName = 'Wostmann',
@MemberBDay = '2000-02-02',
@OfficerFName = 'Zack',
@OfficerLName = 'Steinberg',
@OfficerEmail = 'zsteiny@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Couve Couture',
@AddressPostal = 'V5K OB5',
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberBDay = '2004-08-08',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Clubhouse',
@AddressPostal = 'VOE OC2',
@MemberFName = 'Sofiya',
@MemberLName = 'Mitchell',
@MemberBDay = '2002-04-04',
@OfficerFName = 'Olivia',
@OfficerLName = 'Adams',
@OfficerEmail = 'oadams@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Church House',
@AddressPostal = 'VOE OC2',
@MemberFName = 'Olivia',
@MemberLName = 'Adams',
@MemberBDay = '1999-01-01',
@OfficerFName = 'Alec',
@OfficerLName = 'Wostmann',
@OfficerEmail = 'awostmann@uw.edu'

EXECUTE insert_tripandstudent
@HouseName = 'Red Treehouse',
@AddressPostal = 'VOG OB4',
@MemberFName = 'Jordan',
@MemberLName = 'Cavanaugh',
@MemberBDay = '2004-08-08',
@OfficerFName = 'Zack',
@OfficerLName = 'Steinberg',
@OfficerEmail = 'zsteiny@uw.edu'

--Lucy- Insert officer titles
INSERT INTO tblOfficerTitle
VALUES('President'), ('Event planner'), ('Treasurer'), ('Enrollment Director')

GO
--prcedure to insert officers
CREATE OR ALTER PROCEDURE insert_officer
@OFname VARCHAR(30),
@OLname VARCHAR(30),
@Omail VARCHAR(50),
@OPhone VARCHAR(20),
@OTitleName VARCHAR(20)
AS
DECLARE @MemberID INT, @TitleID INT
SET @MemberID = (
    SELECT MemberID
    FROM tblMEMBERS
    WHERE MemberFname = @OFname
    AND MemberLname = @OLname
    AND MemberEmail = @Omail
)
SET @TitleID = (
    Select OfficerTitleID
    FROM tblOfficerTitle
    WHERE OfficerTitleName = @OTitleName
)

BEGIN TRANSACTION
INSERT INTO tblOFFICERS
VALUES(@OPhone, @MemberID, @TitleID)
COMMIT TRANSACTION
GO

--populate the officers table
EXECUTE insert_officer
@OFname = 'Olivia',
@OLname = 'Adams',
@Omail = 'oadams@uw.edu',
@OPhone = '206-332-1894',
@OTitleName = 'President'

EXECUTE insert_officer
@OFname = 'Alec',
@OLname = 'Wostmann',
@Omail = 'awostmann@uw.edu',
@OPhone = '206-798-1167',
@OTitleName = 'Event planner'

EXECUTE insert_officer
@OFname = 'Zack',
@OLname = 'Steinberg',
@Omail = 'zsteiny@uw.edu',
@OPhone = '951-296-7568',
@OTitleName = 'Treasurer'

EXECUTE insert_officer
@OFname = 'Sofiya',
@OLname = 'Mitchell',
@Omail = 'smitch@uw.edu',
@OPhone = '206-672-9971',
@OTitleName = 'Enrollment Director'

SELECT * FROM tblMerch

--insert rows about the merchant types
INSERT INTO tblMerch_Type
VALUES('Hoodie', 70), ('Hat', 30), ('Gloves', 65), ('Waterproof Jacket', 120), ('Super Bundel', 600)

--procedure to insert one merchant
GO
CREATE OR ALTER PROCEDURE insert_merch
@TypeName VARCHAR(30),
@MerchName VARCHAR(50)
AS
DECLARE @TypeID INT
SET @TypeID = (
    SELECT MerchTypeID
    FROM tblMerch_Type
    WHERE MerchTypeName = @TypeName
)

BEGIN TRANSACTION
INSERT INTO tblMerch
VALUES(@TypeID, @MerchName)
COMMIT TRANSACTION
GO

--insert the merches
EXECUTE insert_merch
@TypeName = 'Hoodie',
@MerchName = 'Black Cat Hoodie'

EXECUTE insert_merch
@TypeName = 'Hoodie',
@MerchName = 'Plain White Hoodie'

EXECUTE insert_merch
@TypeName = 'Hat',
@MerchName = 'Wool Winter Hat-Blue'

EXECUTE insert_merch
@TypeName = 'Hat',
@MerchName = 'Wool Winter Hat-pattern'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Split Finger Waterproof Gloves'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Wool Gloves'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Wool Gloves-Blue'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Wool Gloves-White'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Wool Gloves-Black'

EXECUTE insert_merch
@TypeName = 'Gloves',
@MerchName = 'Wool Gloves-Pink'

EXECUTE insert_merch
@TypeName = 'Waterproof Jacket',
@MerchName = 'Waterproof Jacket-White'

EXECUTE insert_merch
@TypeName = 'Waterproof Jacket',
@MerchName = 'Waterproof Jacket-Black'

EXECUTE insert_merch
@TypeName = 'Super Bundel',
@MerchName = 'Bundle type 1'

SELECT * FROM tblMerch

--Procedure to insert some payments and insert it also into MerchPayment
GO
CREATE OR ALTER PROCEDURE insert_merch_pay
@MFname VARCHAR(30),
@MLname VARCHAR(30),
@Mbd DATE,
@Mmail VARCHAR(50),
@Paydate DATE,
@PayAmount FLOAT(2),
@PayType VARCHAR(10),
@MerchName VARCHAR(30)

AS
DECLARE @MemID INT, @PayID INT, @MerchID INT

SET @MemID = (
    SELECT MemberID
    FROM tblMEMBERS
    WHERE MemberFname = @MFname
    AND MemberLname = @MLname
    AND MemberBDay = @Mbd
    AND MemberEmail = @Mmail
)

BEGIN TRANSACTION
INSERT INTO tblPayments
VALUES(@MemID, @PayDate, @PayAmount, @PayType)
COMMIT TRANSACTION

SET @PayID = (
    SELECT PaymentID
    FROM tblPayments
    WHERE MemberID = @MemID
    AND PaymentDate = @Paydate
    AND PaymentAmount = @PayAmount
    AND PaymentType = @PayType
)

SET @MerchID = (
    SELECT MerchID
    FROM tblMerch
    WHERE MerchName = @MerchName
)

BEGIN TRANSACTION
INSERT INTO tblMerchPayment
VALUES(@PayID, @MerchID)
COMMIT TRANSACTION
GO

--insert the rows for payment and their merch_payment
EXECUTE insert_merch_pay
@MFname = 'Noah',
@MLname = 'Roger',
@Mbd = '2004-11-11',
@Mmail = 'boaterboy@uw.edu',
@Paydate = '2022-11-19',
@PayAmount = 70,
@PayType = 'Cash',
@MerchName = 'Black Cat Hoodie'

EXECUTE insert_merch_pay
@MFname = 'Elizabeth',
@MLname = 'Williams',
@Mbd = '2003-10-10',
@Mmail = 'ewill@uw.edu',
@Paydate = '2022-3-12',
@PayAmount = 70,
@PayType = 'Debit',
@MerchName = 'Black Cat Hoodie'

EXECUTE insert_merch_pay
@MFname = 'Josh',
@MLname = 'Sherbrooke',
@Mbd = '2000-09-09',
@Mmail = 'jsherbro@uw.edu',
@Paydate = '2022-11-09',
@PayAmount = 70,
@PayType = 'Cash',
@MerchName = 'Black Cat Hoodie'

EXECUTE insert_merch_pay
@MFname = 'Josh',
@MLname = 'Sherbrooke',
@Mbd = '2000-09-09',
@Mmail = 'jsherbro@uw.edu',
@Paydate = '2022-11-10',
@PayAmount = 70,
@PayType = 'Debit',
@MerchName = 'Plain White Hoodie'

EXECUTE insert_merch_pay
@MFname = 'Sofiya',
@MLname = 'Mitchell',
@Mbd = '2002-04-04',
@Mmail = 'smitch@uw.edu',
@Paydate = '2022-10-29',
@PayAmount = 65,
@PayType = 'Cash',
@MerchName = 'Wool Gloves'

EXECUTE insert_merch_pay
@MFname = 'Aidan',
@MLname = 'Toney',
@Mbd = '2001-05-05',
@Mmail = 'atoney@uw.edu',
@Paydate = '2022-07-14',
@PayAmount = 120,
@PayType = 'Cash',
@MerchName = 'Waterproof Jacket-White'

EXECUTE insert_merch_pay
@MFname = 'Amara',
@MLname = 'Coloros',
@Mbd = '1999-06-06',
@Mmail = 'acolor@uw.edu',
@Paydate = '2021-11-19',
@PayAmount = 120,
@PayType = 'Debit',
@MerchName = 'Waterproof Jacket-White'

EXECUTE insert_merch_pay
@MFname = 'Riley',
@MLname = 'Keeler',
@Mbd = '2004-07-07',
@Mmail = 'rkeeler@uw.edu',
@Paydate = '2022-01-19',
@PayAmount = 65,
@PayType = 'Credit',
@MerchName = 'Wool Gloves'

EXECUTE insert_merch_pay
@MFname = 'Jordan',
@MLname = 'Cavanaugh',
@Mbd = '2004-08-08',
@Mmail = 'jcav@uw.edu',
@Paydate = '2021-12-29',
@PayAmount = 65,
@PayType = 'Debit',
@MerchName = 'Wool Gloves-Pink'

EXECUTE insert_merch_pay
@MFname = 'Noah',
@MLname = 'Roger',
@Mbd = '2004-11-11',
@Mmail = 'boaterboy@uw.edu',
@Paydate = '2022-05-19',
@PayAmount = 65,
@PayType = 'Debit',
@MerchName = 'Split Finger Waterproof Gloves'

--UDF/Business Rule 1: No member under the age of 19 can come on a trip to Canada
GO
CREATE OR ALTER FUNCTION mo_tripmember_restrict()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblMEMBERS m
           JOIN tblTripsStudent ts ON m.MemberID = ts.MemberID
           JOIN tblHouses h ON ts.HouseID = h.HouseID
           WHERE DATEDIFF(year, m.MemberBDay, GETDATE()) > 19
           AND h.AddressCountry = 'Canada')
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblTripsStudent WITH NOCHECK
ADD CONSTRAINT chk_tripmember_restrict
CHECK(dbo.mo_tripmember_restrict() = 0)

-- UDF/Business Rule 2: No House can have more than 30 members
GO
CREATE OR ALTER FUNCTION mo_tripnumber_restrict()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblTripStudent ts
           GROUP BY ts.TripID, ts.HouseID
           HAVING COUNT(ts.MemberID) > 30)
SET @ret = 1
RETURN @ret
END
GO
ALTER TABLE tblTripsStudent WITH NOCHECK
ADD CONSTRAINT chk_tripnumber_restrict
CHECK(dbo.mo_tripnumber_restrict() = 0)

-- UDF/Business Rule 3: create a user define function restriction: Payment amount for trips cannot be under $80
GO
CREATE OR ALTER FUNCTION fn_paymentriprestrict ()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblPayments p
          WHERE p.PaymentAmount < 80)
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblPayments WITH NOCHECK
ADD CONSTRAINT chk_paymenttrips
CHECK(dbo.fn_paymentriprestrict() = 0)

-- UDF/Business Rule 4: create a user define function restriction: All members must have an email address ending in "uw.edu"
GO
CREATE OR ALTER FUNCTION fn_emailaddressrestrict ()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT * FROM tblMembers m
          WHERE m.MemberEmail = '%uw.edu')
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblMembers WITH NOCHECK
ADD CONSTRAINT chk_uwemailaddress
CHECK(dbo.fn_emailaddressrestrict() = 0)

--UDF/Business rule 5: No merch over the price of 500 can be purchased by a member under 18
--                      insert a member under age 18
--UDF for the business rule
INSERT INTO tblMEMBERS
VALUES('Joy', 'Ful', 'jful@uw.edu', '2006-01-01')

GO
CREATE OR ALTER FUNCTION fn_underage18()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS(
    SELECT * FROM tblMEMBERS m
    JOIN tblPayments p ON m.MemberID = p.MemberID
    JOIN tblMerchPayment mp ON p.PaymentID = mp.PaymentID
    JOIN tblMERCH mch ON mp.MerchID = mch.MerchID
    JOIN tblMerch_Type mt ON mch.MerchTypeID = mt.MerchTypeID
    WHERE DateDiff(year, m.MemberBDay, getDate()) < 18
    AND mt.MerchTypeCost > 500
)
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblMerchPayment WITH NOCHECK
ADD CONSTRAINT chk_age
CHECK(dbo.fn_underage18() = 0)

--trying to trigger the constraint
EXECUTE insert_merch_pay
@MFname = 'Joy',
@MLname = 'Ful',
@Mbd = '2006-01-01',
@Mmail = 'jful@uw.edu',
@Paydate = '2021-12-29',
@PayAmount = 600,
@PayType = 'Debit',
@MerchName = 'Bundle type 1'

--UDF/Business Rule 6: One member can only provide one ride (date of request in the ‘gas_payments’ table)
--                      in the same day
GO
CREATE OR ALTER FUNCTION fn_tworideoneday(@MemberID INT)
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF (
    SELECT COUNT(*) FROM tblGas_Payments gp
    WHERE MemberID = @MemberID
    GROUP BY DateRequested
) > 1
SET @ret = 1
RETURN @ret
END
GO
ALTER TABLE tblGas_Payments WITH NOCHECK
ADD CONSTRAINT chk_repete
CHECK(dbo.fn_tworideoneday(MemberID) = 0)

--trying to trigger the chk constraint
INSERT INTO tblGas_Payments
VALUES(30, 1, '2020-12-02', '2020-12-27', 1)

--Output Query 1: How many members under the age of 19 stayed in a house that was not in Canada?
SELECT h.HouseName,  COUNT(ts.MemberID) AS numMembers
FROM tblHouses h
JOIN tblTripsStudent ts ON h.HouseID = ts.HouseID
JOIN tblMEMBERS m ON ts.MemberID = m.MemberID
WHERE DATEDIFF(year, m.MemberBDay, GETDATE()) > 19
AND h.AddressCountry != 'Canada'
GROUP BY h.HouseName
ORDER BY numMembers desc

--Output Query 2: Which mountain was driven to the most (defined by gas payouts) in 2017?
SELECT TOP 1 mp.MountainName, COUNT(g.GasPaymentID) AS numPayments
FROM tblGas_Payments g
JOIN tblMountain_Payments mp ON g.MountainID = g.MountainID
WHERE g.DatePaid BETWEEN '2017-01-01' AND '2017-12-31'
GROUP BY g.MountainID, mp.MountainName
ORDER BY numPayments DESC

-- Output Query 3: How many members over the age of 18 have made only cash payments?
SELECT COUNT(DISTINCT m.MemberID) AS NumMembersCashPay
FROM tblMembers m
JOIN tblPayments p ON m.MemberID = p.MemberID
WHERE m.MemberBDay < '2004-12-01'
AND p.PaymentType ='Cash'
AND m.memberID NOT IN (SELECT m.MemberID
                       FROM tblMembers m
                       JOIN tblPayments p ON m.MemberID = p.MemberID 
                       WHERE p.PaymentType != 'Cash')

SELECT *
FROM tblPayments

SELECT *
FROM tblMembers

-- Output Query 4:  What are the first and last name of members who stayed in a British Columbia home or a
-- Washington home at least one time, including the number of times they stayed? Sort the results by last name.
SELECT m.MemberFName, m.MemberLName, COUNT(*) trips
FROM tblMembers m
JOIN tblTripStudent ts ON m.MemberID = ts.MemberID
JOIN tblHouses h ON ts.HouseID = h.HouseID
WHERE h.AddressState = 'British Columbia'
AND h.AddressCountry = 'Canada'
GROUP BY m.MemberFName, m.MemberLName
UNION
SELECT DISTINCT m.MemberFName, m.MemberLName, COUNT(*) trips
FROM tblMembers m
JOIN tblTripStudent ts ON m.MemberID = ts.MemberID
JOIN tblHouses h ON ts.HouseID = h.HouseID
WHERE h.AddressState = 'Washington'
AND h.AddressCountry = 'United States'
GROUP BY m.MemberFName, m.MemberLName
ORDER BY MemberLName, MemberFName

--Output SQL 5: find which person has been paid by Gas payment the most
SELECT TOP 1 SUM(mp.MountainPayment), gp.MemberID, m.MemberFname, m.MemberLname
FROM tblMEMBERS m
JOIN tblGas_Payments gp ON m.MemberID = gp.MemberID
JOIN tblMountain_Payments mp ON gp.MountainID = mp.MountainID
GROUP BY gp.MemberID, m.MemberFname, m.MemberLname
ORDER BY SUM(mp.MountainPayment) DESC


--Output SQL 6: Which members have joined more than 1 trip
SELECT tp.MemberID, COUNT(TripID)
FROM tblMembers m
JOIN tblTripStudent tp ON m.MemberID = tp.MemberID
GROUP BY tp.MemberID
HAVING COUNT(TripID) > 1
