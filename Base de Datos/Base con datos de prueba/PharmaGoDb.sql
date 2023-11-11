
-- Pharmacys definition

-- Drop table

-- DROP TABLE Pharmacys;

CREATE TABLE Pharmacys (
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Address nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Pharmacys PRIMARY KEY (Id)
);


-- Presentations definition

-- Drop table

-- DROP TABLE Presentations;

CREATE TABLE Presentations (
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Deleted bit NOT NULL,
	CONSTRAINT PK_Presentations PRIMARY KEY (Id)
);


-- Purchases definition

-- Drop table

-- DROP TABLE Purchases;

CREATE TABLE Purchases (
	Id int IDENTITY(1,1) NOT NULL,
	PurchaseDate datetime2 NOT NULL,
	TotalAmount decimal(14,2) NOT NULL,
	BuyerEmail nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TrackingCode nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Purchases PRIMARY KEY (Id)
);


-- Roles definition

-- Drop table

-- DROP TABLE Roles;

CREATE TABLE Roles (
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Roles PRIMARY KEY (Id)
);


-- Sessions definition

-- Drop table

-- DROP TABLE Sessions;

CREATE TABLE Sessions (
	Id int IDENTITY(1,1) NOT NULL,
	Token uniqueidentifier NOT NULL,
	UserId int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Sessions PRIMARY KEY (Id)
);


-- UnitMeasures definition

-- Drop table

-- DROP TABLE UnitMeasures;

CREATE TABLE UnitMeasures (
	Id int IDENTITY(1,1) NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Deleted bit NOT NULL,
	CONSTRAINT PK_UnitMeasures PRIMARY KEY (Id)
);


-- [__EFMigrationsHistory] definition

-- Drop table

-- DROP TABLE [__EFMigrationsHistory];

CREATE TABLE [__EFMigrationsHistory] (
	MigrationId nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ProductVersion nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK___EFMigrationsHistory PRIMARY KEY (MigrationId)
);


-- Drugs definition

-- Drop table

-- DROP TABLE Drugs;

CREATE TABLE Drugs (
	Id int IDENTITY(1,1) NOT NULL,
	Code nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Symptom nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Quantity int NOT NULL,
	Price decimal(14,2) NOT NULL,
	Stock int NOT NULL,
	Prescription bit NOT NULL,
	Deleted bit NOT NULL,
	UnitMeasureId int NULL,
	PresentationId int NULL,
	PharmacyId int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Drugs PRIMARY KEY (Id),
	CONSTRAINT FK_Drugs_Pharmacys_PharmacyId FOREIGN KEY (PharmacyId) REFERENCES Pharmacys(Id),
	CONSTRAINT FK_Drugs_Presentations_PresentationId FOREIGN KEY (PresentationId) REFERENCES Presentations(Id),
	CONSTRAINT FK_Drugs_UnitMeasures_UnitMeasureId FOREIGN KEY (UnitMeasureId) REFERENCES UnitMeasures(Id)
);


-- Invitations definition

-- Drop table

-- DROP TABLE Invitations;

CREATE TABLE Invitations (
	Id int IDENTITY(1,1) NOT NULL,
	UserName nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Created datetime2 NOT NULL,
	PharmacyId int NULL,
	RoleId int NULL,
	UserCode nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit DEFAULT CONVERT([bit],(0)) NOT NULL,
	CONSTRAINT PK_Invitations PRIMARY KEY (Id),
	CONSTRAINT FK_Invitations_Pharmacys_PharmacyId FOREIGN KEY (PharmacyId) REFERENCES Pharmacys(Id),
	CONSTRAINT FK_Invitations_Roles_RoleId FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);


-- Pruducts definition

-- Drop table

-- DROP TABLE Pruducts;

CREATE TABLE Pruducts (
	Id int IDENTITY(1,1) NOT NULL,
	Code int NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Price decimal(14,2) NOT NULL,
	Deleted bit NOT NULL,
	PharmacyId int NULL,
	CONSTRAINT PK_Pruducts PRIMARY KEY (Id),
	CONSTRAINT FK_Pruducts_Pharmacys_PharmacyId FOREIGN KEY (PharmacyId) REFERENCES Pharmacys(Id)
);
 CREATE NONCLUSTERED INDEX IX_Pruducts_PharmacyId ON dbo.Pruducts (  PharmacyId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- PurchaseDetails definition

-- Drop table

-- DROP TABLE PurchaseDetails;

CREATE TABLE PurchaseDetails (
	Id int IDENTITY(1,1) NOT NULL,
	DrugId int NULL,
	Quantity int NOT NULL,
	Price decimal(14,2) NOT NULL,
	PurchaseId int NULL,
	PharmacyId int NULL,
	Status nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductId int NULL,
	CONSTRAINT PK_PurchaseDetails PRIMARY KEY (Id),
	CONSTRAINT FK_PurchaseDetails_Drugs_DrugId FOREIGN KEY (DrugId) REFERENCES Drugs(Id),
	CONSTRAINT FK_PurchaseDetails_Pharmacys_PharmacyId FOREIGN KEY (PharmacyId) REFERENCES Pharmacys(Id),
	CONSTRAINT FK_PurchaseDetails_Pruducts_ProductId FOREIGN KEY (ProductId) REFERENCES Pruducts(Id),
	CONSTRAINT FK_PurchaseDetails_Purchases_PurchaseId FOREIGN KEY (PurchaseId) REFERENCES Purchases(Id)
);
 CREATE NONCLUSTERED INDEX IX_PurchaseDetails_ProductId ON dbo.PurchaseDetails (  ProductId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- Users definition

-- Drop table

-- DROP TABLE Users;

CREATE TABLE Users (
	Id int IDENTITY(1,1) NOT NULL,
	UserName nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Password nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Address nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RegistrationDate datetime2 NULL,
	RoleId int NULL,
	PharmacyId int NULL,
	CONSTRAINT PK_Users PRIMARY KEY (Id),
	CONSTRAINT FK_Users_Pharmacys_PharmacyId FOREIGN KEY (PharmacyId) REFERENCES Pharmacys(Id),
	CONSTRAINT FK_Users_Roles_RoleId FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);


-- StockRequests definition

-- Drop table

-- DROP TABLE StockRequests;

CREATE TABLE StockRequests (
	Id int IDENTITY(1,1) NOT NULL,
	Status int NOT NULL,
	RequestDate datetime2 NOT NULL,
	EmployeeId int NULL,
	CONSTRAINT PK_StockRequests PRIMARY KEY (Id),
	CONSTRAINT FK_StockRequests_Users_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Users(Id)
);


-- StockRequestDetails definition

-- Drop table

-- DROP TABLE StockRequestDetails;

CREATE TABLE StockRequestDetails (
	Id int IDENTITY(1,1) NOT NULL,
	DrugId int NULL,
	Quantity int NOT NULL,
	StockRequestId int NULL,
	CONSTRAINT PK_StockRequestDetails PRIMARY KEY (Id),
	CONSTRAINT FK_StockRequestDetails_Drugs_DrugId FOREIGN KEY (DrugId) REFERENCES Drugs(Id),
	CONSTRAINT FK_StockRequestDetails_StockRequests_StockRequestId FOREIGN KEY (StockRequestId) REFERENCES StockRequests(Id)
);





INSERT INTO [__EFMigrationsHistory] (MigrationId,ProductVersion) VALUES
	 (N'20220910212258_InitialCreate',N'6.0.8'),
	 (N'20220917182456_AddSession',N'6.0.8'),
	 (N'20220917191530_ChangeSession',N'6.0.8'),
	 (N'20220917232725_CheckSession',N'6.0.8'),
	 (N'20220918192623_RemoveUseCodeFromUserEntity',N'6.0.8'),
	 (N'20221001173323_UpdateUserAndInvitationEntity',N'6.0.8'),
	 (N'20221001183953_UnitMeasurePresentationConversions',N'6.0.8'),
	 (N'20221002194836_nullablePharmacyOfDrug',N'6.0.8'),
	 (N'20221010173819_PurchaseV2',N'6.0.8'),
	 (N'20221013003816_RemoveEnums',N'6.0.8');
INSERT INTO [__EFMigrationsHistory] (MigrationId,ProductVersion) VALUES
	 (N'20231021182640_Products–IgnoreChanges',N'6.0.8'),
	 (N'20231021232538_ProductInPurchaseDetail',N'6.0.8');

SET IDENTITY_INSERT UnitMeasures ON;

INSERT INTO UnitMeasures (Id,Name,Deleted) VALUES
	 (1,N'mg',0),
	 (2,N'g',0),
	 (3,N'ml',0),
	 (4,N'l',0);

SET IDENTITY_INSERT UnitMeasures OFF;
SET IDENTITY_INSERT Roles ON;

INSERT INTO Roles (Id,Name) VALUES
	 (1,N'Administrator'),
	 (2,N'Employee'),
	 (3,N'Owner');

SET IDENTITY_INSERT Roles OFF;
SET IDENTITY_INSERT Presentations ON;

INSERT INTO Presentations (Id,Name,Deleted) VALUES
	 (1,N'capsules',0),
	 (2,N'tablet',0),
	 (3,N'liquid',0),
	 (4,N'patches',0),
	 (5,N'injections',0);

SET IDENTITY_INSERT Presentations OFF;
SET IDENTITY_INSERT Pharmacys ON;


INSERT INTO Pharmacys (Id,Name,Address) VALUES
	 (1,N'Farmacia 1234',N'Av Uruguay 23223'),
	 (2,N'Farmacia Av. Italia',N'Av Italia 9822'),
	 (3,N'San Roque Pocitos',N'Pocitos 12345');

SET IDENTITY_INSERT Pharmacys OFF;
SET IDENTITY_INSERT Invitations ON;

INSERT INTO Invitations (Id,UserName,Created,PharmacyId,RoleId,UserCode,IsActive) VALUES
	 (1,N'admin1','2022-10-06 16:37:17.7558876',NULL,1,N'391668',0),
	 (2,N'employee1','2022-10-06 16:38:41.2817995',1,2,N'026041',0),
	 (3,N'owner1','2022-10-06 16:38:55.3009591',1,3,N'138667',0),
	 (4,N'employee20','2022-11-05 14:54:40.7669183',2,2,N'006527',0),
	 (5,N'admin20','2022-11-05 15:08:27.4899589',NULL,1,N'747342',0),
	 (6,N'admin30','2022-11-05 15:31:29.4721078',2,2,N'273477',1),
	 (7,N'admin45','2022-11-05 15:32:21.7292276',2,2,N'789377',1),
	 (8,N'wwwww','2022-11-05 15:35:54.1796876',2,2,N'555396',1),
	 (9,N'owner2022','2022-11-05 15:44:28.0028757',1,3,N'305555',1),
	 (10,N'admin333','2022-11-13 15:12:39.9130849',3,2,N'415768',1);
INSERT INTO Invitations (Id,UserName,Created,PharmacyId,RoleId,UserCode,IsActive) VALUES
	 (11,N'marcelo','2022-11-13 15:13:29.3672875',1,2,N'417578',1),
	 (12,N'employee2','2022-11-16 18:38:07.7323243',3,2,N'054245',0),
	 (13,N'owner2','2022-11-16 18:38:19.2029982',3,3,N'811601',0),
	 (14,N'Test invi','2023-09-16 19:52:49.0842502',1,2,N'926515',0),
	 (15,N'Test invi 2','2023-09-16 19:53:22.2883183',3,2,N'188418',1),
	 (1014,N'123','2023-09-17 15:06:56.3982430',NULL,1,N'721279',0),
	 (1015,N'12345','2023-09-17 15:24:19.5214619',1,2,N'426816',0);


SET IDENTITY_INSERT Invitations OFF;
SET IDENTITY_INSERT Drugs ON;


INSERT INTO Drugs (Id,Code,Name,Symptom,Quantity,Price,Stock,Prescription,Deleted,UnitMeasureId,PresentationId,PharmacyId) VALUES
	 (1,N'XDEA',N'Novemina',N'Dolor de cabeza',1000,50.00,1824,0,1,1,1,1),
	 (2,N'ABCD',N'Perifar Flex',N'Fiebre',1000,125.00,1101,1,1,1,2,1),
	 (3,N'ZASW',N'Aspirina',N'Dolor en general',2000,25.00,199958,1,1,1,2,1),
	 (4,N'XDEA',N'Aspirineta',N'Dolor en general',2000,50.00,148,0,0,1,1,2),
	 (5,N'ZZDEA',N'Aspirineta',N'Dolor en general',2000,50.00,0,0,0,1,1,2),
	 (6,N'ZQDEA',N'Aspirineta',N'Dolor en general',2000,50.00,0,0,0,1,1,2),
	 (7,N'ZXC',N'Redoxon zinc 10 Comprimidos Efervescente',N'REDOXON+ZINC 10 COMPRIMIDOS EFERVESCENTE',250,500.00,0,1,0,1,2,2),
	 (8,N'ABR',N'Abrilar Jarabe 100 Ml',N'Tos',1000,250.00,0,0,0,2,3,2),
	 (9,N'BIO',N'Bio Grip Plus 8 Comprimidos',N'Gripe',10000,1250.00,0,0,1,2,1,1),
	 (10,N'ASCX',N'aaaaa',N'eeeeeeee',100,120.00,0,0,1,1,1,1);
INSERT INTO Drugs (Id,Code,Name,Symptom,Quantity,Price,Stock,Prescription,Deleted,UnitMeasureId,PresentationId,PharmacyId) VALUES
	 (11,N'ZXZ',N'qwewr',N'asdda',100,40.00,0,0,1,1,1,1),
	 (12,N'WWW',N'asdasasfasf',N'sadsadasd',23,500.00,0,1,1,2,1,1),
	 (13,N'VVVVV',N'wwwwww',N'aasdasdasd adasdasdasd',120,50.00,0,0,1,3,3,2),
	 (14,N'GFR',N'Novemina Fuerte',N'Dolor general',1000,100.00,1099,0,0,1,1,1),
	 (15,N'VGT',N'Paracetamol 1 Gr 10 Comprimidos ',N'Gripe, Fiebre, Dolor de cabeza',100,150.00,100,0,0,1,1,1),
	 (16,N'ZAQ',N'Teofilina Efa 250 Mg 30 Comprimidos',N'Metilxantina broncodilatadora indicada en las crisis asmáticas y otras situaciones que cursen con broncoespasmo.',1000,750.00,100,0,0,1,2,1),
	 (17,N'FRE',N'Alerfedine 120 Mg 10',N'Antialérgico.',10000,200.00,100,0,0,1,4,1),
	 (18,N'JBT',N'Mucotosil Adultos Jarabe 120 Ml',N'Mucolítico',2000,450.00,99,1,0,3,3,1),
	 (19,N'WER',N'Lordex 10 Comprimidos',N'Asociación antialérgica de un antihistamínico con corticoides',5000,300.00,99,1,0,2,4,3),
	 (20,N'GRT',N'Histacetin 10 Comprimidos',N'Antialérgico. Antihistamínico H1 de acción prolongada sin efecto sedante.',3000,1000.00,100,1,0,1,1,3);
INSERT INTO Drugs (Id,Code,Name,Symptom,Quantity,Price,Stock,Prescription,Deleted,UnitMeasureId,PresentationId,PharmacyId) VALUES
	 (21,N'TOS',N'Tosilar Jarabe 100 Ml',N'Espasmolítico',54000,1200.00,100,1,0,4,3,3),
	 (22,N'HND',N'Kalitron Fuerte 10 Grageas',N'Asociación antialérgica de un antihistamínico con corticoides.',4000,550.00,100,0,0,1,2,3),
	 (23,N'LOR',N'Loratadina Ion Solucion 30 Ml',N'Antialérgico.',5000,1100.00,100,0,0,3,3,3),
	 (24,N'ABC',N'Prueba test 1',N'Sintoma 1',1,50.00,0,0,1,1,1,2),
	 (25,N'ABC',N'Prueba test 2',N'Sintoma 2',1,50.00,9,0,1,1,1,1),
	 (1024,N'VVVVV',N'1',N'1',1,1.00,0,1,0,1,1,1);

SET IDENTITY_INSERT Drugs OFF;
SET IDENTITY_INSERT Pruducts ON;

INSERT INTO Pruducts (Id,Code,Name,Description,Price,Deleted,PharmacyId) VALUES
	 (1,11111,N'Dale vida a tu pelo!',N'Shampoo',100.00,0,1),
	 (2,12345,N'Nuevo prod 2',N'Nuevo prod 2',444.00,1,1),
	 (3,14444,N'Hilo dental',N'Hilo dental',75.00,0,1),
	 (4,14323,N'Enjuague bucal',N'Enjuague bucal',500.00,0,2),
	 (111,41796,N'test',N'test',100.00,1,1),
	 (112,91626,N'Shampoo',N'Dale vida a tu pelo!',100.00,0,1),
	 (113,55280,N'Shampoo 2',N'Dale vida a tu pelo! 2',1002.00,0,1);


SET IDENTITY_INSERT Pruducts OFF;
SET IDENTITY_INSERT Purchases ON;


INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (4,'2022-10-05 10:21:31.8160000',3375.00,N'santi@gmail.com',N'FROR7HWPUH5JWW4C'),
	 (5,'2022-10-05 10:21:31.8160000',3575.00,N'santi@gmail.com',N'BOOHZPI9QR9B3UW9'),
	 (6,'2022-10-05 10:21:31.8160000',3575.00,N'santi@gmail.com',N'1FM5EVO6RJQQ5YX2'),
	 (7,'2022-10-21 02:28:38.8520000',100.00,N'marcelo@gmail.com',N'WX7P2ZWUMO667UD0'),
	 (8,'2022-10-21 02:39:22.6540000',150.00,N'marcelo@gmail.com',N'WAAWV9MRXJ8SA2P7'),
	 (9,'2022-10-21 02:42:33.2970000',125.00,N'marcelo@gmail.com',N'13HMDDQN3ITVG0QT'),
	 (10,'2022-10-21 02:47:38.8170000',50.00,N'marcelo@gmail.com',N'HE8O04PT6IRMCDUM'),
	 (11,'2022-10-21 02:54:56.5450000',50.00,N'marcelo@gmail.com',N'8N5OEVQAVBI2LSPI'),
	 (12,'2022-10-21 13:44:27.0830000',1250.00,N'pedro@gmail.com',N'2ANW1V94FMSW9AEM'),
	 (13,'2022-10-22 14:35:32.8420000',-50.00,N'marcelo@gmail.com',N'VY0MW2PYEYTAWLNZ');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (14,'2022-10-22 18:02:15.5280000',-550.00,N'mm@gmail.com',N'QSEOVBVDLNU4SAP3'),
	 (15,'2022-10-22 18:04:14.1970000',-2875.00,N'asd@gmail.com',N'O3EOO59860X7PRV2'),
	 (16,'2022-10-22 18:13:46.6310000',25.00,N'asd@gmail.com',N'LH196WOL68APCI6A'),
	 (17,'2022-10-24 01:26:01.3980000',-600.00,N'jose@gmail.com',N'5IAFLYD6ZPZL8IVU'),
	 (18,'2022-10-24 01:30:07.4630000',325.00,N'jose2@gmail.com',N'89JT7QBT3M64EO1R'),
	 (19,'2022-10-24 03:10:51.8700000',375.00,N'jose3@gmail.com',N'7T14V5UI5Z7JE3RD'),
	 (20,'2022-10-24 03:13:51.0880000',750.00,N'jose4@gmail.com',N'814V4R04F5ZBKSLL'),
	 (21,'2022-10-27 23:41:05.8030000',100.00,N'pedro@gmail.com',N'WE0VJ5XKKYS3CNIT'),
	 (22,'2022-11-05 17:35:02.8140000',100.00,N'carlitos@gmail.com',N'WCQQILD1NWWY1DNV'),
	 (23,'2022-11-13 18:21:48.4480000',100.00,N'felipe.rodriguez@gmail.com',N'QWKTKH8BT5OJCW9S');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (24,'2022-11-13 19:01:01.4800000',50100.00,N'fernando@gmail.com',N'ZE7Y2YYPT1JXSYWM'),
	 (25,'2022-11-14 00:48:49.9610000',50.00,N'marcelo@gmail.com',N'23FAG5ZVCUZS4V3I'),
	 (26,'2022-11-14 00:51:15.0700000',250.00,N'mariano@gmail.com',N'DLNZ6N5X80AXWBLS'),
	 (27,'2022-11-16 21:45:14.8500000',800.00,N'felipe@gmail.com',N'85PXZXQ7FRNT0M4D'),
	 (28,'2023-09-16 21:57:20.7750000',5000.00,N'sebastianbandera17@gmail.com',N'FL46TL0FGR4SHVA6'),
	 (29,'2023-09-16 22:14:10.6370000',0.00,N'sebastianbandera17@gmail.com',N'FHJP52SLNXCN57I2'),
	 (30,'2023-09-16 22:49:55.9040000',100.00,N'sebastianbandera17@gmail.com',N'B0C4UPE7EI9Z9FHG'),
	 (31,'2023-09-16 22:50:57.6200000',5000.00,N'sebastianbandera17@gmail.com',N'NJW3G21KLWVALSE1'),
	 (32,'2023-09-16 22:51:37.7270000',50.00,N'sebastianbandera17@gmail.com',N'QQIEV6QVGGDAUTTQ'),
	 (1029,'2023-09-17 18:33:29.4230000',150.00,N'sebastianbandera17@gmail.com',N'2AR1FZT6G5QRXQK8');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (1030,'2023-09-25 22:18:52.1790000',10000000000.00,N'sebastianbandera17@gmail.com',N'YG5WI9X3HX5JNA1W'),
	 (2030,'2023-10-21 20:36:16.1850000',250.00,N'sebastianbandera17@gmail.com',N'DSG4XFZAQ9O4ZE6V'),
	 (2031,'2023-10-23 00:40:56.3880000',150.00,N'sebastianbandera17@gmail.com',N'XZI1LEV87OJVAJ1H'),
	 (2032,'2023-10-23 00:41:19.2420000',150.00,N'sebastianbandera17@gmail.com',N'JLVI6GY9Q4WOYD99'),
	 (2033,'2023-10-23 00:44:35.3500000',150.00,N'sebastianbandera17@gmail.com',N'INLMSGTQZK4NV4XE'),
	 (2034,'2023-10-23 00:52:38.8090000',2500.00,N'sebastianbandera17@gmail.com',N'9X01762461YLOS24'),
	 (2035,'2023-10-23 00:55:24.4790000',175.00,N'sebastianbandera17@gmail.com',N'HAADNT20W1KFWLRT'),
	 (2036,'2023-10-24 21:28:55.1200000',50.00,N'sebastianbandera17@gmail.com',N'3NZKYFIO37NUJY9F'),
	 (2037,'2023-10-24 21:30:22.0550000',50.00,N'sebastianbandera17@gmail.com',N'SKDPFR3W0TSU1ZPU'),
	 (2038,'2023-10-24 21:32:09.4480000',50.00,N'sebastianbandera17@gmail.com',N'C54G0H3QX4OOX2HW');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2039,'2023-10-24 21:42:01.8190000',50.00,N'sebastianbandera17@gmail.com',N'3QD3BGV8CU7TEMI3'),
	 (2040,'2023-10-24 21:42:31.0370000',50.00,N'sebastianbandera17@gmail.com',N'THN03WME9D00GKSD'),
	 (2041,'2023-10-24 21:45:52.2430000',50.00,N'sebastianbandera17@gmail.com',N'VJD9QKVVMZKHSA2I'),
	 (2042,'2023-10-24 21:46:08.9600000',50.00,N'sebastianbandera17@gmail.com',N'UQ7F2QT3MTO2N1BT'),
	 (2043,'2023-10-24 21:47:26.9880000',50.00,N'sebastianbandera17@gmail.com',N'IHJV88Z7LI1CIZVW'),
	 (2044,'2023-10-24 21:50:50.8680000',50.00,N'sebastianbandera17@gmail.com',N'LDZ9MRU90ZVV1X40'),
	 (2045,'2023-10-24 21:51:06.8810000',50.00,N'sebastianbandera17@gmail.com',N'V3532WNNMKW2C0EH'),
	 (2046,'2023-10-24 21:51:18.0110000',50.00,N'sebastianbandera17@gmail.com',N'6SLM35PYI7UC90I3'),
	 (2047,'2023-10-24 21:51:25.9990000',50.00,N'sebastianbandera17@gmail.com',N'ZRCMJ7AJA9618JGQ'),
	 (2048,'2023-10-24 21:52:46.5590000',50.00,N'sebastianbandera17@gmail.com',N'RGHHN2AIPIWZPI73');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2049,'2023-10-24 22:12:10.7210000',50.00,N'sebastianbandera17@gmail.com',N'AJ0HEJ2PNOWKZ7LM'),
	 (2050,'2023-10-24 22:12:55.5200000',50.00,N'sebastianbandera17@gmail.com',N'OCP3XQVBV9HTZOCH'),
	 (2051,'2023-10-24 22:14:28.7970000',50.00,N'sebastianbandera17@gmail.com',N'PPQ874BI92JNAJ8N'),
	 (2052,'2023-10-24 22:35:29.5110000',250.00,N'sebastianbandera17@gmail.com',N'32CAKTGM3LORPQBR'),
	 (2053,'2023-10-24 22:37:06.3210000',200.00,N'sebastianbandera17@gmail.com',N'4G5HMTVUZRLCOPNX'),
	 (2054,'2023-10-24 22:37:41.2580000',150.00,N'sebastianbandera17@gmail.com',N'5XEUE5S108Y6UQ4E'),
	 (2055,'2023-10-24 22:37:52.6720000',150.00,N'sebastianbandera17@gmail.com',N'TE51HPTWYKOGIGVB'),
	 (2056,'2023-10-24 22:38:00.1420000',150.00,N'sebastianbandera17@gmail.com',N'Z0PEB2JWOV2KOZMS'),
	 (2057,'2023-10-28 00:07:30.5370000',100.00,N'sebastianbandera17@gmail.com',N'M277FO0L8IRX5Z5O'),
	 (2058,'2023-10-28 00:08:59.3160000',100.00,N'sebastianbandera17@gmail.com',N'R5AY0YX69VP1X558');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2059,'2023-10-28 00:12:33.6820000',200.00,N'sebastianbandera17@gmail.com',N'Y5VF75V9FE5PTL1F'),
	 (2060,'2023-10-28 00:16:34.0940000',175.00,N'sebastianbandera17@gmail.com',N'7VW9MZCLSTBVCSNH'),
	 (2061,'2023-10-28 00:18:02.5620000',175.00,N'sebastianbandera17@gmail.com',N'W97CZDBBDW9UOK3Y'),
	 (2062,'2023-10-28 00:18:16.2550000',175.00,N'sebastianbandera17@gmail.com',N'HK2A37W2G0J2ZS9U'),
	 (2063,'2023-10-28 00:20:19.4920000',575.00,N'sebastianbandera17@gmail.com',N'A6XU9Q07COB8Z422'),
	 (2064,'2023-10-28 00:21:12.3410000',575.00,N'sebastianbandera17@gmail.com',N'AIM0TZM2WIU78IMC'),
	 (2065,'2023-10-28 00:21:25.2960000',575.00,N'sebastianbandera17@gmail.com',N'W7PBFMTE7AUA0V5N'),
	 (2066,'2023-10-28 00:21:54.2480000',50.00,N'sebastianbandera17@gmail.com',N'BSSYK7PWV6CEO5SC'),
	 (2067,'2023-10-28 00:21:58.1940000',150.00,N'sebastianbandera17@gmail.com',N'4GUHULTIXK1QRGK3'),
	 (2068,'2023-10-28 00:22:02.3610000',575.00,N'sebastianbandera17@gmail.com',N'66W2D603YZRYCBXG');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2069,'2023-10-28 00:22:06.4070000',175.00,N'sebastianbandera17@gmail.com',N'GX5KTGIWMAJBTII9'),
	 (2070,'2023-10-28 00:22:10.0480000',100.00,N'sebastianbandera17@gmail.com',N'5UVDYG57F50OC49U'),
	 (2071,'2023-10-28 00:22:13.5990000',100.00,N'sebastianbandera17@gmail.com',N'GAD7EPECWRLSIV5E'),
	 (2072,'2023-10-28 00:32:25.5040000',175.00,N'sebastianbandera17@gmail.com',N'AJS5N2Z7QC90MPXP'),
	 (2073,'2023-10-28 00:32:39.4540000',575.00,N'sebastianbandera17@gmail.com',N'CC8TZMT0B1DM8121'),
	 (2074,'2023-10-28 00:33:35.2930000',1200.00,N'sebastianbandera17@gmail.com',N'Q0FQ5OLS0O8X7VKD'),
	 (2075,'2023-10-28 00:34:17.7660000',1200.00,N'sebastianbandera17@gmail.com',N'7IUAG459FC8UHYOV'),
	 (2076,'2023-10-28 18:00:26.8720000',50.00,N'sebastianbandera17@gmail.com',N'18TTWFKL78EU2VXT'),
	 (2077,'2023-10-28 18:02:43.5740000',575.00,N'sebastianbandera17@gmail.com',N'NXP30NEU4IJVF6E7'),
	 (2078,'2023-10-28 18:02:55.9410000',50.00,N'sebastianbandera17@gmail.com',N'IA199UAFCP58J11K');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2079,'2023-10-28 18:03:16.6750000',50.00,N'sebastianbandera17@gmail.com',N'IB8SWIRDM0X4M2T3'),
	 (2080,'2023-10-28 18:03:20.5650000',150.00,N'sebastianbandera17@gmail.com',N'2XL7FTFZEP2GWYV4'),
	 (2081,'2023-10-28 18:03:24.7100000',575.00,N'sebastianbandera17@gmail.com',N'T3YX3GH2JHDS3D91'),
	 (2082,'2023-10-28 18:03:28.6140000',175.00,N'sebastianbandera17@gmail.com',N'0STLH886NX6ZCDZT'),
	 (2083,'2023-10-28 18:03:32.5640000',1200.00,N'sebastianbandera17@gmail.com',N'O43LJGO1J678BT89'),
	 (2084,'2023-10-28 18:03:35.9260000',100.00,N'sebastianbandera17@gmail.com',N'BZ7N37GXXW5HOVDF'),
	 (2085,'2023-10-28 18:03:39.2960000',100.00,N'sebastianbandera17@gmail.com',N'G76P1222ME8CKRR8'),
	 (2086,'2023-10-28 18:23:27.1450000',50.00,N'sebastianbandera17@gmail.com',N'21Q5OASGG3EVBV14'),
	 (2087,'2023-10-28 18:23:44.9860000',250.00,N'sebastianbandera17@gmail.com',N'IO2DHR5BF8NSZ20G'),
	 (2088,'2023-10-28 18:24:14.7550000',50.00,N'sebastianbandera17@gmail.com',N'O3CNNPP3HGFA4JKP');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2089,'2023-10-28 18:24:19.0690000',150.00,N'sebastianbandera17@gmail.com',N'KF4QCA02ENSJZ2T9'),
	 (2090,'2023-10-28 18:24:21.6600000',100.00,N'sebastianbandera17@gmail.com',N'AMTJEK0YUUN1VEWP'),
	 (2091,'2023-10-28 18:24:23.5220000',575.00,N'sebastianbandera17@gmail.com',N'BH09F68YGMK54VZY'),
	 (2092,'2023-10-28 18:24:27.9200000',175.00,N'sebastianbandera17@gmail.com',N'R1UQ523GG1B69P93'),
	 (2093,'2023-10-28 18:24:32.2190000',1200.00,N'sebastianbandera17@gmail.com',N'1Z5VH1GUN14A1WP6'),
	 (2094,'2023-10-28 18:24:35.8690000',100.00,N'sebastianbandera17@gmail.com',N'U5GGKU06ANSGBXOO'),
	 (2095,'2023-10-28 18:24:39.7220000',100.00,N'sebastianbandera17@gmail.com',N'8AT15O1HBLQ87V70'),
	 (2096,'2023-10-28 18:24:41.9460000',575.00,N'sebastianbandera17@gmail.com',N'PFXFFETVJHL0B2DG'),
	 (2097,'2023-10-28 18:25:01.7710000',175.00,N'sebastianbandera17@gmail.com',N'E02VJYN22RRSYQPW'),
	 (2098,'2023-10-28 18:25:40.3580000',50.00,N'sebastianbandera17@gmail.com',N'W44RAX9WBGLCBMBL');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2099,'2023-10-28 18:25:58.0500000',250.00,N'sebastianbandera17@gmail.com',N'RLDX290GBO7L9XC3'),
	 (2100,'2023-10-28 18:26:16.8140000',200.00,N'sebastianbandera17@gmail.com',N'630Z0SAIBIOPB1QB'),
	 (2101,'2023-10-28 18:26:35.6860000',100.00,N'sebastianbandera17@gmail.com',N'KY705XR3OKCVNDY9'),
	 (2102,'2023-10-28 18:26:55.7250000',575.00,N'sebastianbandera17@gmail.com',N'DG8U28FA8W60YS5H'),
	 (2103,'2023-10-28 18:27:15.5070000',175.00,N'sebastianbandera17@gmail.com',N'7GT5UGJ167JWS9RR'),
	 (2104,'2023-10-28 18:27:20.3610000',1200.00,N'sebastianbandera17@gmail.com',N'YYPYQNUYP7CLHTRM'),
	 (2105,'2023-10-28 18:38:29.5760000',50.00,N'sebastianbandera17@gmail.com',N'P3WQJ52EDMVGQWC8'),
	 (2106,'2023-10-28 18:38:47.3730000',250.00,N'sebastianbandera17@gmail.com',N'TDVERO1FXD78LO6M'),
	 (2107,'2023-10-28 18:39:06.1260000',200.00,N'sebastianbandera17@gmail.com',N'DPYMJ94Q1IN0FJTA'),
	 (2108,'2023-10-28 18:41:47.9490000',50.00,N'sebastianbandera17@gmail.com',N'XV6QJ90XO9PXYBBC');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2109,'2023-10-28 18:41:51.9140000',150.00,N'sebastianbandera17@gmail.com',N'WJ4CS2RDDJM4BNEK'),
	 (2110,'2023-10-28 18:41:56.0280000',575.00,N'sebastianbandera17@gmail.com',N'NAU0EH3YEP8MWO8S'),
	 (2111,'2023-10-28 18:42:00.2450000',175.00,N'sebastianbandera17@gmail.com',N'K3KO5ESA6Y9OG2QU'),
	 (2112,'2023-10-28 18:42:04.2520000',1200.00,N'sebastianbandera17@gmail.com',N'KK5DT5RQNL4ERR4V'),
	 (2113,'2023-10-28 18:42:07.7250000',100.00,N'sebastianbandera17@gmail.com',N'YAWY1BRCRNET1TEU'),
	 (2114,'2023-10-28 18:42:11.3450000',100.00,N'sebastianbandera17@gmail.com',N'U7JGQGRYETOYNE8L'),
	 (2115,'2023-10-28 18:44:04.9250000',100.00,N'sebastianbandera17@gmail.com',N'79IMM27EGQ0Q88DZ'),
	 (2116,'2023-10-28 18:46:39.8750000',100.00,N'sebastianbandera17@gmail.com',N'EVX8DXM692DDFBLE'),
	 (2117,'2023-10-28 18:47:09.8020000',100.00,N'sebastianbandera17@gmail.com',N'KB3EGP5ZVFEFJMB5'),
	 (2118,'2023-10-28 18:47:33.9000000',100.00,N'sebastianbandera17@gmail.com',N'U68URSAFCJR5RQ88');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2119,'2023-10-28 18:49:27.8400000',100.00,N'sebastianbandera17@gmail.com',N'3XZ0A1G0NACFRSP2'),
	 (2120,'2023-10-28 18:50:29.4360000',100.00,N'sebastianbandera17@gmail.com',N'ZEX93K87RN62O4IM'),
	 (2121,'2023-10-29 18:14:23.5000000',100.00,N'sebastianbandera17@gmail.com',N'49E6YNUN80Y80DNX'),
	 (2122,'2023-10-29 18:14:44.4740000',50.00,N'sebastianbandera17@gmail.com',N'OX8YA7H3IXW823J6'),
	 (2123,'2023-10-29 18:14:47.3770000',250.00,N'sebastianbandera17@gmail.com',N'1X94P0XTLCFXVKE4'),
	 (2124,'2023-10-29 18:14:51.3350000',200.00,N'sebastianbandera17@gmail.com',N'PQ4ZCHEYM65D0PIQ'),
	 (2125,'2023-10-29 18:14:55.2520000',100.00,N'sebastianbandera17@gmail.com',N'CXJ8UE3LYCTHTVFT'),
	 (2126,'2023-10-29 18:15:00.5580000',575.00,N'sebastianbandera17@gmail.com',N'GU0GYBRY0NIXV69J'),
	 (2127,'2023-10-29 18:15:05.3630000',175.00,N'sebastianbandera17@gmail.com',N'O6UUS7BYQTZZKCNQ'),
	 (2128,'2023-10-29 18:15:10.3740000',1200.00,N'sebastianbandera17@gmail.com',N'JFSKNQ9ZX68412PZ');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2129,'2023-10-29 19:26:17.1000000',50.00,N'sebastianbandera17@gmail.com',N'YPDE4WQQ67MXZR4A'),
	 (2130,'2023-10-29 19:26:20.2460000',250.00,N'sebastianbandera17@gmail.com',N'7UXH6FIRZ5A3VVPN'),
	 (2131,'2023-10-29 19:26:24.0540000',200.00,N'sebastianbandera17@gmail.com',N'UOHJJCFQJ0SMCDVS'),
	 (2132,'2023-10-29 19:26:27.9870000',100.00,N'sebastianbandera17@gmail.com',N'AC7D3IGP6M03DQCE'),
	 (2133,'2023-10-29 19:26:33.4640000',575.00,N'sebastianbandera17@gmail.com',N'97JAJYG9UBBELQLE'),
	 (2134,'2023-10-29 19:26:38.6970000',175.00,N'sebastianbandera17@gmail.com',N'VEWKMQDBP2B7A16M'),
	 (2135,'2023-10-29 19:26:43.8050000',1200.00,N'sebastianbandera17@gmail.com',N'7Z5SSQ6142YTN6SH'),
	 (2136,'2023-10-29 21:41:33.2530000',50.00,N'sebastianbandera17@gmail.com',N'4T6YR953K7T50751'),
	 (2137,'2023-10-29 21:41:38.0430000',150.00,N'sebastianbandera17@gmail.com',N'T8OESJG513IYUG2D'),
	 (2138,'2023-10-29 21:41:43.0510000',575.00,N'sebastianbandera17@gmail.com',N'1PM9J2IVF8GOMV2H');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2139,'2023-10-29 21:41:48.0480000',175.00,N'sebastianbandera17@gmail.com',N'GY91YOGL8G1Y48SQ'),
	 (2140,'2023-10-29 21:41:53.0890000',1200.00,N'sebastianbandera17@gmail.com',N'3YD31P7VC2BT14DF'),
	 (2141,'2023-10-29 21:41:57.5760000',100.00,N'sebastianbandera17@gmail.com',N'7UXLTIYY29LCIDSH'),
	 (2142,'2023-10-29 21:42:01.7620000',100.00,N'sebastianbandera17@gmail.com',N'2IWB63EX6NCOKO8V'),
	 (2143,'2023-10-29 21:43:38.0000000',50.00,N'sebastianbandera17@gmail.com',N'D86HHHQCNACJYP0I'),
	 (2144,'2023-10-29 21:43:41.1500000',250.00,N'sebastianbandera17@gmail.com',N'TRG2TG2JF09XV2TR'),
	 (2145,'2023-10-29 21:43:45.1380000',200.00,N'sebastianbandera17@gmail.com',N'DIZ518QIMRTZM4M9'),
	 (2146,'2023-10-29 21:43:49.1340000',100.00,N'sebastianbandera17@gmail.com',N'LO81OHG8LUSVLP9G'),
	 (2147,'2023-10-29 21:43:54.7590000',575.00,N'sebastianbandera17@gmail.com',N'KE72PUFJDBF5GL9Z'),
	 (2148,'2023-10-29 21:44:00.3050000',175.00,N'sebastianbandera17@gmail.com',N'7XF4OUWS543NJHCB');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2149,'2023-10-29 21:44:06.0990000',1200.00,N'sebastianbandera17@gmail.com',N'KRE9ZKQL2DUPTMXB'),
	 (2150,'2023-10-29 21:52:18.4870000',50.00,N'sebastianbandera17@gmail.com',N'9UG9AH75R2A187FG'),
	 (2151,'2023-10-29 21:52:21.8200000',250.00,N'sebastianbandera17@gmail.com',N'ZVRYMIIOXFXCD4VB'),
	 (2152,'2023-10-29 21:52:22.1760000',50.00,N'sebastianbandera17@gmail.com',N'67QR5AIK5PDYAQCF'),
	 (2153,'2023-10-29 21:52:25.9060000',200.00,N'sebastianbandera17@gmail.com',N'PP1J0LOKBRKBO0ZW'),
	 (2154,'2023-10-29 21:52:27.8590000',150.00,N'sebastianbandera17@gmail.com',N'QGVPQATXRYXB0YE8'),
	 (2155,'2023-10-29 21:52:30.1130000',100.00,N'sebastianbandera17@gmail.com',N'ZKWM53O5A8L3AXWH'),
	 (2156,'2023-10-29 21:52:34.0910000',575.00,N'sebastianbandera17@gmail.com',N'RTUID3RFSDRHYGK6'),
	 (2157,'2023-10-29 21:52:35.8350000',575.00,N'sebastianbandera17@gmail.com',N'W1JSQ4PAST2POHGI'),
	 (2158,'2023-10-29 21:52:38.2480000',175.00,N'sebastianbandera17@gmail.com',N'RQTOK4SMVEONCKMZ');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2159,'2023-10-29 21:52:41.4260000',175.00,N'sebastianbandera17@gmail.com',N'4S3U4UCVLUW7LVQH'),
	 (2160,'2023-10-29 21:52:42.5990000',1200.00,N'sebastianbandera17@gmail.com',N'K705IUVXGFZ31XKQ'),
	 (2161,'2023-10-29 21:52:46.3640000',100.00,N'sebastianbandera17@gmail.com',N'8FWKW595ZGWT0WRJ'),
	 (2162,'2023-10-29 21:52:46.9960000',1200.00,N'sebastianbandera17@gmail.com',N'3CWWXS3W8M6BTKQU'),
	 (2163,'2023-10-29 21:52:50.0820000',100.00,N'sebastianbandera17@gmail.com',N'OZ9ZH8BWTT7GW4GB'),
	 (2164,'2023-10-29 21:55:40.5560000',50.00,N'sebastianbandera17@gmail.com',N'PP4KY60WJM2PPGIC'),
	 (2165,'2023-10-29 21:55:43.0510000',50.00,N'sebastianbandera17@gmail.com',N'5J66MDP135VPSSZP'),
	 (2166,'2023-10-29 21:55:46.1430000',250.00,N'sebastianbandera17@gmail.com',N'8YP85C5I2C5A7CRY'),
	 (2167,'2023-10-29 21:55:50.1440000',200.00,N'sebastianbandera17@gmail.com',N'2J21PXVZ5C3PQ8DT'),
	 (2168,'2023-10-29 21:55:53.8250000',150.00,N'sebastianbandera17@gmail.com',N'7TTLCZAQODD3UJ4S');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2169,'2023-10-29 21:55:54.6270000',100.00,N'sebastianbandera17@gmail.com',N'TD6N7Z53ZL6XXCMF'),
	 (2170,'2023-10-29 21:55:58.1990000',575.00,N'sebastianbandera17@gmail.com',N'SGJ5WP3RRH4K3RE6'),
	 (2171,'2023-10-29 21:56:00.0640000',575.00,N'sebastianbandera17@gmail.com',N'IN29STI53LHV0MN3'),
	 (2172,'2023-10-29 21:56:02.3730000',175.00,N'sebastianbandera17@gmail.com',N'JAZVPQ0R5SRYBF91'),
	 (2173,'2023-10-29 21:56:05.4170000',175.00,N'sebastianbandera17@gmail.com',N'KSCVVI5UXEEDZ90P'),
	 (2174,'2023-10-29 21:56:06.8400000',1200.00,N'sebastianbandera17@gmail.com',N'Z9OY6IF5ZH504VA3'),
	 (2175,'2023-10-29 21:56:10.8040000',100.00,N'sebastianbandera17@gmail.com',N'O9WBYDU9WM1MY5WM'),
	 (2176,'2023-10-29 21:56:11.3250000',1200.00,N'sebastianbandera17@gmail.com',N'IGJ110LY2QF15W9X'),
	 (2177,'2023-10-29 21:56:14.6720000',100.00,N'sebastianbandera17@gmail.com',N'O3MHZTJ6MVD7OD5W'),
	 (2178,'2023-10-29 21:57:35.1940000',50.00,N'sebastianbandera17@gmail.com',N'YVDGOCRV3MEVCZ5B');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2179,'2023-10-29 21:57:39.2370000',150.00,N'sebastianbandera17@gmail.com',N'A4HR0HEOYP7EJ5EZ'),
	 (2180,'2023-10-29 21:57:43.6360000',575.00,N'sebastianbandera17@gmail.com',N'RAWNMJ1Z3DIYFO1G'),
	 (2181,'2023-10-29 21:57:47.8690000',175.00,N'sebastianbandera17@gmail.com',N'HXHW55ZAXGJBSKUJ'),
	 (2182,'2023-10-29 21:57:52.3620000',1200.00,N'sebastianbandera17@gmail.com',N'UF13TD76QNIRN407'),
	 (2183,'2023-10-29 21:57:56.2360000',100.00,N'sebastianbandera17@gmail.com',N'1HFT69CXAT4GT3V3'),
	 (2184,'2023-10-29 21:58:00.0100000',100.00,N'sebastianbandera17@gmail.com',N'04FR62HSS326HAB6'),
	 (2185,'2023-10-29 22:00:40.0880000',50.00,N'sebastianbandera17@gmail.com',N'UQHQU0MUSSS9UT9R'),
	 (2186,'2023-10-29 22:00:50.2290000',150.00,N'sebastianbandera17@gmail.com',N'B0QWWOMVU4CJ8QM1'),
	 (2187,'2023-10-29 22:00:54.9580000',575.00,N'sebastianbandera17@gmail.com',N'BG3TP3IE8JYXEX2G'),
	 (2188,'2023-10-29 22:00:59.2450000',175.00,N'sebastianbandera17@gmail.com',N'Q2R34K3J0NX8JJBW');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2189,'2023-10-29 22:01:03.3610000',1200.00,N'sebastianbandera17@gmail.com',N'KR3SZIPTA1FNUNXU'),
	 (2190,'2023-10-29 22:01:07.0100000',100.00,N'sebastianbandera17@gmail.com',N'Q8QY49RF9FQ4RRH6'),
	 (2191,'2023-10-29 22:01:10.6620000',100.00,N'sebastianbandera17@gmail.com',N'L2IKISGHVDBRCOAX'),
	 (2192,'2023-10-29 22:02:08.5690000',50.00,N'sebastianbandera17@gmail.com',N'9RZD8KJRTXBUYJCK'),
	 (2193,'2023-10-29 22:02:12.3270000',250.00,N'sebastianbandera17@gmail.com',N'5PHYS9R1REJFW7RN'),
	 (2194,'2023-10-29 22:02:16.3350000',200.00,N'sebastianbandera17@gmail.com',N'08WSHRMTMTTVBDQ4'),
	 (2195,'2023-10-29 22:02:20.2960000',100.00,N'sebastianbandera17@gmail.com',N'WXQSU07RKUJGONPW'),
	 (2196,'2023-10-29 22:02:25.9160000',575.00,N'sebastianbandera17@gmail.com',N'Y8HRJN1GV2J2ASKE'),
	 (2197,'2023-10-29 22:02:31.3650000',175.00,N'sebastianbandera17@gmail.com',N'TTP84MK9CXEPG4F5'),
	 (2198,'2023-10-29 22:02:36.6820000',1200.00,N'sebastianbandera17@gmail.com',N'HS701XLWTV7Z6W20');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2199,'2023-10-29 22:26:06.6550000',50.00,N'sebastianbandera17@gmail.com',N'NHBCW9YD70NYIA4Y'),
	 (2200,'2023-10-29 22:26:10.8300000',150.00,N'sebastianbandera17@gmail.com',N'MHLZ9MHNJO8Z1FYB'),
	 (2201,'2023-10-29 22:26:15.2150000',575.00,N'sebastianbandera17@gmail.com',N'N9ZKKFFD32JCGEB0'),
	 (2202,'2023-10-29 22:26:19.5300000',175.00,N'sebastianbandera17@gmail.com',N'W94QOUT607DK3VCX'),
	 (2203,'2023-10-29 22:26:23.7470000',1200.00,N'sebastianbandera17@gmail.com',N'ITWRY3NS4MQHDYWR'),
	 (2204,'2023-10-29 22:26:27.5120000',100.00,N'sebastianbandera17@gmail.com',N'Z37H8CUGSO9VASNI'),
	 (2205,'2023-10-29 22:26:31.2290000',100.00,N'sebastianbandera17@gmail.com',N'T6SRU5IW32T3USPM'),
	 (2206,'2023-10-29 22:27:34.5760000',50.00,N'sebastianbandera17@gmail.com',N'KTZ0H83L9VTT2UIB'),
	 (2207,'2023-10-29 22:27:38.6450000',150.00,N'sebastianbandera17@gmail.com',N'QWQ9674ZD2TH6R1V'),
	 (2208,'2023-10-29 22:27:43.2100000',575.00,N'sebastianbandera17@gmail.com',N'V7QDKFQ0WF1NVQOL');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2209,'2023-10-29 22:27:47.4930000',175.00,N'sebastianbandera17@gmail.com',N'QECDV3X33LR5TXBT'),
	 (2210,'2023-10-29 22:27:51.6530000',1200.00,N'sebastianbandera17@gmail.com',N'768T3EX4TJJV5WLZ'),
	 (2211,'2023-10-29 22:27:55.3410000',100.00,N'sebastianbandera17@gmail.com',N'NVSUII1XR4J222J3'),
	 (2212,'2023-10-29 22:27:59.0260000',100.00,N'sebastianbandera17@gmail.com',N'NGJPOHE4GKHUAME6'),
	 (2213,'2023-10-29 22:32:06.3950000',50.00,N'sebastianbandera17@gmail.com',N'MI2KXK6ZT4T23PUS'),
	 (2214,'2023-10-29 22:32:10.0540000',250.00,N'sebastianbandera17@gmail.com',N'XLSALY7XOL5QA2OG'),
	 (2215,'2023-10-29 22:32:14.0230000',200.00,N'sebastianbandera17@gmail.com',N'CN7UA0ROLI1Y2QJC'),
	 (2216,'2023-10-29 22:32:18.2910000',100.00,N'sebastianbandera17@gmail.com',N'69NA2QIQZ78P7HSV'),
	 (2217,'2023-10-29 22:32:24.1380000',575.00,N'sebastianbandera17@gmail.com',N'9C0UUUTU3GHG6976'),
	 (2218,'2023-10-29 22:32:29.8470000',175.00,N'sebastianbandera17@gmail.com',N'XQYTZG90JWTFX7VS');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2219,'2023-10-29 22:32:35.2520000',1200.00,N'sebastianbandera17@gmail.com',N'M2TOGQ7ZVXLY56PT'),
	 (2220,'2023-10-29 22:34:05.0580000',50.00,N'sebastianbandera17@gmail.com',N'4TOLI40RCXGY3WAF'),
	 (2221,'2023-10-29 22:34:08.6270000',250.00,N'sebastianbandera17@gmail.com',N'IPESGMFXV68B7Y5L'),
	 (2222,'2023-10-29 22:34:12.4180000',200.00,N'sebastianbandera17@gmail.com',N'S9CWFQOK7C6VMPYX'),
	 (2223,'2023-10-29 22:34:16.3060000',100.00,N'sebastianbandera17@gmail.com',N'1P1G7MJB30EERNGG'),
	 (2224,'2023-10-29 22:34:22.2530000',575.00,N'sebastianbandera17@gmail.com',N'BWMBCUUL2PE2436Z'),
	 (2225,'2023-10-29 22:34:27.8000000',175.00,N'sebastianbandera17@gmail.com',N'2YY832GORSYZQ80Q'),
	 (2226,'2023-10-29 22:34:33.2160000',1200.00,N'sebastianbandera17@gmail.com',N'VC0NCXF0NPWKMHYQ'),
	 (2227,'2023-10-29 22:38:40.6590000',50.00,N'sebastianbandera17@gmail.com',N'EF4EBBBTQNR4KNAD'),
	 (2228,'2023-10-29 22:38:44.2580000',250.00,N'sebastianbandera17@gmail.com',N'9Q4LIA5LAIGGC6T3');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2229,'2023-10-29 22:38:48.2310000',200.00,N'sebastianbandera17@gmail.com',N'6ZMVSYZ48K2X0MM8'),
	 (2230,'2023-10-29 22:38:52.4230000',100.00,N'sebastianbandera17@gmail.com',N'FKS5F7C5CLA1HSYS'),
	 (2231,'2023-10-29 22:38:57.8230000',575.00,N'sebastianbandera17@gmail.com',N'TAHTXTOFKNGK4LAW'),
	 (2232,'2023-10-29 22:39:03.8070000',175.00,N'sebastianbandera17@gmail.com',N'NCHM5CEIA1AMQ9NX'),
	 (2233,'2023-10-29 22:39:09.1820000',1200.00,N'sebastianbandera17@gmail.com',N'I5S73FHPVGVKJZT2'),
	 (2234,'2023-10-29 22:43:05.0250000',50.00,N'sebastianbandera17@gmail.com',N'XUK2BVQZH16LRM4K'),
	 (2235,'2023-10-29 22:43:08.6520000',250.00,N'sebastianbandera17@gmail.com',N'3Q2WHCCUGVLD87WS'),
	 (2236,'2023-10-29 22:43:12.7370000',200.00,N'sebastianbandera17@gmail.com',N'8KI4E9I3DT3M3SM6'),
	 (2237,'2023-10-29 22:43:17.1250000',100.00,N'sebastianbandera17@gmail.com',N'CL659I2ZVZN6WJBT'),
	 (2238,'2023-10-29 22:43:22.9580000',575.00,N'sebastianbandera17@gmail.com',N'B4989MUA0PM2K4QI');
INSERT INTO Purchases (Id,PurchaseDate,TotalAmount,BuyerEmail,TrackingCode) VALUES
	 (2239,'2023-10-29 22:46:34.4300000',50.00,N'sebastianbandera17@gmail.com',N'5Q8B1Z9XRKQ2GI58'),
	 (2240,'2023-10-29 22:46:38.0430000',250.00,N'sebastianbandera17@gmail.com',N'WUYHSIHXFUYSE3YA'),
	 (2241,'2023-10-29 22:46:41.9120000',200.00,N'sebastianbandera17@gmail.com',N'ECR6IF28L92LYJ4E'),
	 (2242,'2023-10-29 22:46:45.9640000',100.00,N'sebastianbandera17@gmail.com',N'L9QDICMYVEIVN0O6'),
	 (2243,'2023-10-29 22:46:51.7210000',575.00,N'sebastianbandera17@gmail.com',N'VF27T0DFQ734SK76'),
	 (2244,'2023-10-29 22:46:57.3350000',175.00,N'sebastianbandera17@gmail.com',N'EN3TBM1B5UG16TVQ'),
	 (2245,'2023-10-29 22:47:02.5500000',1200.00,N'sebastianbandera17@gmail.com',N'9NUNM38VSLAGS3MG');

SET IDENTITY_INSERT Purchases OFF;
SET IDENTITY_INSERT PurchaseDetails ON;

INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (9,2,23,125.00,4,1,N'Rejected',NULL),
	 (10,1,12,50.00,4,1,N'Approved',NULL),
	 (11,4,2,50.00,4,2,N'Rejected',NULL),
	 (12,2,23,125.00,5,1,N'Approved',NULL),
	 (13,1,12,50.00,5,1,N'Approved',NULL),
	 (14,4,2,50.00,5,2,N'Pending',NULL),
	 (15,2,23,125.00,6,1,N'Approved',NULL),
	 (16,1,12,50.00,6,1,N'Rejected',NULL),
	 (17,4,2,50.00,6,2,N'Pending',NULL),
	 (18,1,1,50.00,7,1,N'Approved',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (19,4,1,50.00,7,2,N'Pending',NULL),
	 (20,1,2,50.00,8,1,N'Rejected',NULL),
	 (21,4,1,50.00,8,2,N'Pending',NULL),
	 (22,2,1,125.00,9,1,N'Approved',NULL),
	 (23,1,1,50.00,10,1,N'Rejected',NULL),
	 (24,1,1,50.00,11,1,N'Rejected',NULL),
	 (25,1,12,50.00,12,1,N'Rejected',NULL),
	 (26,4,13,50.00,12,2,N'Pending',NULL),
	 (27,1,1,50.00,13,1,N'Rejected',NULL),
	 (28,1,1,50.00,14,1,N'Rejected',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (29,1,1,50.00,15,1,N'Rejected',NULL),
	 (30,2,1,125.00,16,1,N'Approved',NULL),
	 (31,1,1,50.00,16,1,N'Rejected',NULL),
	 (32,1,15,50.00,17,1,N'Rejected',NULL),
	 (33,2,3,125.00,17,1,N'Rejected',NULL),
	 (34,1,15,50.00,18,1,N'Rejected',NULL),
	 (35,2,3,125.00,18,1,N'Approved',NULL),
	 (36,1,15,50.00,19,1,N'Rejected',NULL),
	 (37,2,3,125.00,19,1,N'Approved',NULL),
	 (38,1,10,50.00,20,1,N'Rejected',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (39,4,15,50.00,20,2,N'Pending',NULL),
	 (40,1,1,50.00,21,1,N'Pending',NULL),
	 (41,4,1,50.00,21,2,N'Pending',NULL),
	 (42,1,16,50.00,22,1,N'Rejected',NULL),
	 (43,4,2,50.00,22,2,N'Approved',NULL),
	 (44,4,2,50.00,23,2,N'Pending',NULL),
	 (45,14,501,100.00,24,1,N'Approved',NULL),
	 (46,4,1,50.00,25,2,N'Pending',NULL),
	 (47,4,1,50.00,26,2,N'Pending',NULL),
	 (48,14,2,100.00,26,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (49,19,1,300.00,27,3,N'Approved',NULL),
	 (50,14,1,100.00,27,1,N'Rejected',NULL),
	 (51,4,1,50.00,27,2,N'Pending',NULL),
	 (52,18,1,450.00,27,1,N'Approved',NULL),
	 (53,4,100,50.00,28,2,N'Approved',NULL),
	 (54,4,1,50.00,29,2,N'Rejected',NULL),
	 (55,14,1,100.00,30,1,N'Pending',NULL),
	 (56,25,100,50.00,31,1,N'Pending',NULL),
	 (57,25,1,50.00,32,1,N'Approved',NULL),
	 (1054,4,1,50.00,1029,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (1055,14,1,100.00,1029,1,N'Approved',NULL),
	 (1056,20,10000000,1000.00,1030,3,N'Pending',NULL),
	 (2056,4,2,50.00,2030,2,N'Pending',NULL),
	 (2057,15,1,150.00,2030,1,N'Pending',NULL),
	 (2058,4,1,50.00,2031,2,N'Pending',NULL),
	 (2059,NULL,1,100.00,2031,1,N'Pending',1),
	 (2060,4,1,50.00,2032,2,N'Pending',NULL),
	 (2061,NULL,1,100.00,2032,1,N'Pending',1),
	 (2062,4,1,50.00,2033,2,N'Pending',NULL),
	 (2063,NULL,1,100.00,2033,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2064,23,2,1100.00,2034,3,N'Pending',NULL),
	 (2065,NULL,3,100.00,2034,1,N'Pending',1),
	 (2066,NULL,1,100.00,2035,1,N'Pending',1),
	 (2067,NULL,1,75.00,2035,1,N'Pending',3),
	 (2068,4,1,50.00,2036,2,N'Pending',NULL),
	 (2069,4,1,50.00,2037,2,N'Pending',NULL),
	 (2070,4,1,50.00,2038,2,N'Pending',NULL),
	 (2071,4,1,50.00,2039,2,N'Pending',NULL),
	 (2072,4,1,50.00,2040,2,N'Pending',NULL),
	 (2073,4,1,50.00,2041,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2074,4,1,50.00,2042,2,N'Pending',NULL),
	 (2075,4,1,50.00,2043,2,N'Pending',NULL),
	 (2076,4,1,50.00,2044,2,N'Pending',NULL),
	 (2077,4,1,50.00,2045,2,N'Pending',NULL),
	 (2078,4,1,50.00,2046,2,N'Pending',NULL),
	 (2079,4,1,50.00,2047,2,N'Pending',NULL),
	 (2080,4,1,50.00,2048,2,N'Pending',NULL),
	 (2081,4,1,50.00,2049,2,N'Pending',NULL),
	 (2082,4,1,50.00,2050,2,N'Pending',NULL),
	 (2083,4,1,50.00,2051,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2084,4,1,50.00,2052,2,N'Pending',NULL),
	 (2085,14,2,100.00,2052,1,N'Pending',NULL),
	 (2086,4,2,50.00,2053,2,N'Pending',NULL),
	 (2087,14,1,100.00,2053,1,N'Pending',NULL),
	 (2088,4,1,50.00,2054,2,N'Pending',NULL),
	 (2089,14,1,100.00,2054,1,N'Pending',NULL),
	 (2090,4,1,50.00,2055,2,N'Pending',NULL),
	 (2091,14,1,100.00,2055,1,N'Pending',NULL),
	 (2092,4,1,50.00,2056,2,N'Pending',NULL),
	 (2093,14,1,100.00,2056,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2094,NULL,1,100.00,2057,1,N'Pending',1),
	 (2095,NULL,1,100.00,2058,1,N'Pending',1),
	 (2096,NULL,2,100.00,2059,1,N'Pending',1),
	 (2097,NULL,1,100.00,2060,1,N'Pending',1),
	 (2098,NULL,1,75.00,2060,1,N'Pending',3),
	 (2099,NULL,1,100.00,2061,1,N'Pending',1),
	 (2100,NULL,1,75.00,2061,1,N'Pending',3),
	 (2101,NULL,1,100.00,2062,1,N'Pending',1),
	 (2102,NULL,1,75.00,2062,1,N'Pending',3),
	 (2103,NULL,1,75.00,2063,1,N'Pending',3);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2104,NULL,1,500.00,2063,2,N'Pending',4),
	 (2105,NULL,1,75.00,2064,1,N'Pending',3),
	 (2106,NULL,1,500.00,2064,2,N'Pending',4),
	 (2107,NULL,1,75.00,2065,1,N'Pending',3),
	 (2108,NULL,1,500.00,2065,2,N'Pending',4),
	 (2109,4,1,50.00,2066,2,N'Pending',NULL),
	 (2110,4,1,50.00,2067,2,N'Pending',NULL),
	 (2111,14,1,100.00,2067,1,N'Pending',NULL),
	 (2112,NULL,1,75.00,2068,1,N'Pending',3),
	 (2113,NULL,1,500.00,2068,2,N'Pending',4);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2114,NULL,1,100.00,2069,1,N'Pending',1),
	 (2115,NULL,1,75.00,2069,1,N'Pending',3),
	 (2116,NULL,1,100.00,2070,1,N'Pending',1),
	 (2117,NULL,1,100.00,2071,1,N'Pending',1),
	 (2118,NULL,1,100.00,2072,1,N'Pending',1),
	 (2119,NULL,1,75.00,2072,1,N'Pending',3),
	 (2120,NULL,1,75.00,2073,1,N'Pending',3),
	 (2121,NULL,1,500.00,2073,2,N'Pending',4),
	 (2122,23,1,1100.00,2074,3,N'Pending',NULL),
	 (2123,NULL,1,100.00,2074,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2124,23,1,1100.00,2075,3,N'Pending',NULL),
	 (2125,NULL,1,100.00,2075,1,N'Pending',1),
	 (2126,4,1,50.00,2076,2,N'Pending',NULL),
	 (2127,NULL,1,75.00,2077,1,N'Pending',3),
	 (2128,NULL,1,500.00,2077,2,N'Pending',4),
	 (2129,4,1,50.00,2078,2,N'Pending',NULL),
	 (2130,4,1,50.00,2079,2,N'Pending',NULL),
	 (2131,4,1,50.00,2080,2,N'Pending',NULL),
	 (2132,14,1,100.00,2080,1,N'Pending',NULL),
	 (2133,NULL,1,75.00,2081,1,N'Pending',3);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2134,NULL,1,500.00,2081,2,N'Pending',4),
	 (2135,NULL,1,100.00,2082,1,N'Pending',1),
	 (2136,NULL,1,75.00,2082,1,N'Pending',3),
	 (2137,23,1,1100.00,2083,3,N'Pending',NULL),
	 (2138,NULL,1,100.00,2083,1,N'Pending',1),
	 (2139,NULL,1,100.00,2084,1,N'Pending',1),
	 (2140,NULL,1,100.00,2085,1,N'Pending',1),
	 (2141,4,1,50.00,2086,2,N'Pending',NULL),
	 (2142,4,1,50.00,2087,2,N'Pending',NULL),
	 (2143,14,2,100.00,2087,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2144,4,1,50.00,2088,2,N'Pending',NULL),
	 (2145,4,1,50.00,2089,2,N'Pending',NULL),
	 (2146,14,1,100.00,2089,1,N'Pending',NULL),
	 (2147,NULL,1,100.00,2090,1,N'Pending',1),
	 (2148,NULL,1,75.00,2091,1,N'Pending',3),
	 (2149,NULL,1,500.00,2091,2,N'Pending',4),
	 (2150,NULL,1,100.00,2092,1,N'Pending',1),
	 (2151,NULL,1,75.00,2092,1,N'Pending',3),
	 (2152,23,1,1100.00,2093,3,N'Pending',NULL),
	 (2153,NULL,1,100.00,2093,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2154,NULL,1,100.00,2094,1,N'Pending',1),
	 (2155,NULL,1,100.00,2095,1,N'Pending',1),
	 (2156,NULL,1,75.00,2096,1,N'Pending',3),
	 (2157,NULL,1,500.00,2096,2,N'Pending',4),
	 (2158,NULL,1,100.00,2097,1,N'Pending',1),
	 (2159,NULL,1,75.00,2097,1,N'Pending',3),
	 (2160,4,1,50.00,2098,2,N'Pending',NULL),
	 (2161,4,1,50.00,2099,2,N'Pending',NULL),
	 (2162,14,2,100.00,2099,1,N'Pending',NULL),
	 (2163,NULL,2,100.00,2100,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2164,NULL,1,100.00,2101,1,N'Pending',1),
	 (2165,NULL,1,75.00,2102,1,N'Pending',3),
	 (2166,NULL,1,500.00,2102,2,N'Pending',4),
	 (2167,NULL,1,100.00,2103,1,N'Pending',1),
	 (2168,NULL,1,75.00,2103,1,N'Pending',3),
	 (2169,23,1,1100.00,2104,3,N'Pending',NULL),
	 (2170,NULL,1,100.00,2104,1,N'Pending',1),
	 (2171,4,1,50.00,2105,2,N'Pending',NULL),
	 (2172,4,1,50.00,2106,2,N'Pending',NULL),
	 (2173,14,2,100.00,2106,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2174,NULL,2,100.00,2107,1,N'Pending',1),
	 (2175,4,1,50.00,2108,2,N'Pending',NULL),
	 (2176,4,1,50.00,2109,2,N'Pending',NULL),
	 (2177,14,1,100.00,2109,1,N'Pending',NULL),
	 (2178,NULL,1,75.00,2110,1,N'Pending',3),
	 (2179,NULL,1,500.00,2110,2,N'Pending',4),
	 (2180,NULL,1,100.00,2111,1,N'Pending',1),
	 (2181,NULL,1,75.00,2111,1,N'Pending',3),
	 (2182,23,1,1100.00,2112,3,N'Pending',NULL),
	 (2183,NULL,1,100.00,2112,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2184,NULL,1,100.00,2113,1,N'Pending',1),
	 (2185,NULL,1,100.00,2114,1,N'Pending',1),
	 (2186,NULL,1,100.00,2115,1,N'Pending',1),
	 (2187,NULL,1,100.00,2116,1,N'Pending',1),
	 (2188,NULL,1,100.00,2117,1,N'Pending',1),
	 (2189,NULL,1,100.00,2118,1,N'Pending',1),
	 (2190,NULL,1,100.00,2119,1,N'Pending',1),
	 (2191,NULL,1,100.00,2120,1,N'Pending',1),
	 (2192,NULL,1,100.00,2121,1,N'Pending',1),
	 (2193,4,1,50.00,2122,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2194,4,1,50.00,2123,2,N'Pending',NULL),
	 (2195,14,2,100.00,2123,1,N'Pending',NULL),
	 (2196,NULL,2,100.00,2124,1,N'Pending',1),
	 (2197,NULL,1,100.00,2125,1,N'Pending',1),
	 (2198,NULL,1,75.00,2126,1,N'Pending',3),
	 (2199,NULL,1,500.00,2126,2,N'Pending',4),
	 (2200,NULL,1,100.00,2127,1,N'Pending',1),
	 (2201,NULL,1,75.00,2127,1,N'Pending',3),
	 (2202,23,1,1100.00,2128,3,N'Pending',NULL),
	 (2203,NULL,1,100.00,2128,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2204,4,1,50.00,2129,2,N'Pending',NULL),
	 (2205,4,1,50.00,2130,2,N'Pending',NULL),
	 (2206,14,2,100.00,2130,1,N'Pending',NULL),
	 (2207,NULL,2,100.00,2131,1,N'Pending',1),
	 (2208,NULL,1,100.00,2132,1,N'Pending',1),
	 (2209,NULL,1,75.00,2133,1,N'Pending',3),
	 (2210,NULL,1,500.00,2133,2,N'Pending',4),
	 (2211,NULL,1,100.00,2134,1,N'Pending',1),
	 (2212,NULL,1,75.00,2134,1,N'Pending',3),
	 (2213,23,1,1100.00,2135,3,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2214,NULL,1,100.00,2135,1,N'Pending',1),
	 (2215,4,1,50.00,2136,2,N'Pending',NULL),
	 (2216,4,1,50.00,2137,2,N'Pending',NULL),
	 (2217,14,1,100.00,2137,1,N'Pending',NULL),
	 (2218,NULL,1,75.00,2138,1,N'Pending',3),
	 (2219,NULL,1,500.00,2138,2,N'Pending',4),
	 (2220,NULL,1,100.00,2139,1,N'Pending',1),
	 (2221,NULL,1,75.00,2139,1,N'Pending',3),
	 (2222,23,1,1100.00,2140,3,N'Pending',NULL),
	 (2223,NULL,1,100.00,2140,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2224,NULL,1,100.00,2141,1,N'Pending',1),
	 (2225,NULL,1,100.00,2142,1,N'Pending',1),
	 (2226,4,1,50.00,2143,2,N'Pending',NULL),
	 (2227,4,1,50.00,2144,2,N'Pending',NULL),
	 (2228,14,2,100.00,2144,1,N'Pending',NULL),
	 (2229,NULL,2,100.00,2145,1,N'Pending',1),
	 (2230,NULL,1,100.00,2146,1,N'Pending',1),
	 (2231,NULL,1,75.00,2147,1,N'Pending',3),
	 (2232,NULL,1,500.00,2147,2,N'Pending',4),
	 (2233,NULL,1,100.00,2148,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2234,NULL,1,75.00,2148,1,N'Pending',3),
	 (2235,23,1,1100.00,2149,3,N'Pending',NULL),
	 (2236,NULL,1,100.00,2149,1,N'Pending',1),
	 (2237,4,1,50.00,2150,2,N'Pending',NULL),
	 (2238,4,1,50.00,2151,2,N'Pending',NULL),
	 (2239,14,2,100.00,2151,1,N'Pending',NULL),
	 (2240,4,1,50.00,2152,2,N'Pending',NULL),
	 (2241,NULL,2,100.00,2153,1,N'Pending',1),
	 (2242,4,1,50.00,2154,2,N'Pending',NULL),
	 (2243,14,1,100.00,2154,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2244,NULL,1,100.00,2155,1,N'Pending',1),
	 (2245,NULL,1,75.00,2156,1,N'Pending',3),
	 (2246,NULL,1,500.00,2156,2,N'Pending',4),
	 (2247,NULL,1,75.00,2157,1,N'Pending',3),
	 (2248,NULL,1,500.00,2157,2,N'Pending',4),
	 (2249,NULL,1,100.00,2158,1,N'Pending',1),
	 (2250,NULL,1,75.00,2158,1,N'Pending',3),
	 (2251,NULL,1,100.00,2159,1,N'Pending',1),
	 (2252,NULL,1,75.00,2159,1,N'Pending',3),
	 (2253,23,1,1100.00,2160,3,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2254,NULL,1,100.00,2160,1,N'Pending',1),
	 (2255,NULL,1,100.00,2161,1,N'Pending',1),
	 (2256,23,1,1100.00,2162,3,N'Pending',NULL),
	 (2257,NULL,1,100.00,2162,1,N'Pending',1),
	 (2258,NULL,1,100.00,2163,1,N'Pending',1),
	 (2259,4,1,50.00,2164,2,N'Pending',NULL),
	 (2260,4,1,50.00,2165,2,N'Pending',NULL),
	 (2261,4,1,50.00,2166,2,N'Pending',NULL),
	 (2262,14,2,100.00,2166,1,N'Pending',NULL),
	 (2263,NULL,2,100.00,2167,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2264,4,1,50.00,2168,2,N'Pending',NULL),
	 (2265,14,1,100.00,2168,1,N'Pending',NULL),
	 (2266,NULL,1,100.00,2169,1,N'Pending',1),
	 (2267,NULL,1,75.00,2170,1,N'Pending',3),
	 (2268,NULL,1,500.00,2170,2,N'Pending',4),
	 (2269,NULL,1,75.00,2171,1,N'Pending',3),
	 (2270,NULL,1,500.00,2171,2,N'Pending',4),
	 (2271,NULL,1,100.00,2172,1,N'Pending',1),
	 (2272,NULL,1,75.00,2172,1,N'Pending',3),
	 (2273,NULL,1,100.00,2173,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2274,NULL,1,75.00,2173,1,N'Pending',3),
	 (2275,23,1,1100.00,2174,3,N'Pending',NULL),
	 (2276,NULL,1,100.00,2174,1,N'Pending',1),
	 (2277,NULL,1,100.00,2175,1,N'Pending',1),
	 (2278,23,1,1100.00,2176,3,N'Pending',NULL),
	 (2279,NULL,1,100.00,2176,1,N'Pending',1),
	 (2280,NULL,1,100.00,2177,1,N'Pending',1),
	 (2281,4,1,50.00,2178,2,N'Pending',NULL),
	 (2282,4,1,50.00,2179,2,N'Pending',NULL),
	 (2283,14,1,100.00,2179,1,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2284,NULL,1,75.00,2180,1,N'Pending',3),
	 (2285,NULL,1,500.00,2180,2,N'Pending',4),
	 (2286,NULL,1,100.00,2181,1,N'Pending',1),
	 (2287,NULL,1,75.00,2181,1,N'Pending',3),
	 (2288,23,1,1100.00,2182,3,N'Pending',NULL),
	 (2289,NULL,1,100.00,2182,1,N'Pending',1),
	 (2290,NULL,1,100.00,2183,1,N'Pending',1),
	 (2291,NULL,1,100.00,2184,1,N'Pending',1),
	 (2292,4,1,50.00,2185,2,N'Pending',NULL),
	 (2293,4,1,50.00,2186,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2294,14,1,100.00,2186,1,N'Pending',NULL),
	 (2295,NULL,1,75.00,2187,1,N'Pending',3),
	 (2296,NULL,1,500.00,2187,2,N'Pending',4),
	 (2297,NULL,1,100.00,2188,1,N'Pending',1),
	 (2298,NULL,1,75.00,2188,1,N'Pending',3),
	 (2299,23,1,1100.00,2189,3,N'Pending',NULL),
	 (2300,NULL,1,100.00,2189,1,N'Pending',1),
	 (2301,NULL,1,100.00,2190,1,N'Pending',1),
	 (2302,NULL,1,100.00,2191,1,N'Pending',1),
	 (2303,4,1,50.00,2192,2,N'Pending',NULL);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2304,4,1,50.00,2193,2,N'Pending',NULL),
	 (2305,14,2,100.00,2193,1,N'Pending',NULL),
	 (2306,NULL,2,100.00,2194,1,N'Pending',1),
	 (2307,NULL,1,100.00,2195,1,N'Pending',1),
	 (2308,NULL,1,75.00,2196,1,N'Pending',3),
	 (2309,NULL,1,500.00,2196,2,N'Pending',4),
	 (2310,NULL,1,100.00,2197,1,N'Pending',1),
	 (2311,NULL,1,75.00,2197,1,N'Pending',3),
	 (2312,23,1,1100.00,2198,3,N'Pending',NULL),
	 (2313,NULL,1,100.00,2198,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2314,4,1,50.00,2199,2,N'Pending',NULL),
	 (2315,4,1,50.00,2200,2,N'Pending',NULL),
	 (2316,14,1,100.00,2200,1,N'Pending',NULL),
	 (2317,NULL,1,75.00,2201,1,N'Pending',3),
	 (2318,NULL,1,500.00,2201,2,N'Pending',4),
	 (2319,NULL,1,100.00,2202,1,N'Pending',1),
	 (2320,NULL,1,75.00,2202,1,N'Pending',3),
	 (2321,23,1,1100.00,2203,3,N'Pending',NULL),
	 (2322,NULL,1,100.00,2203,1,N'Pending',1),
	 (2323,NULL,1,100.00,2204,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2324,NULL,1,100.00,2205,1,N'Pending',1),
	 (2325,4,1,50.00,2206,2,N'Pending',NULL),
	 (2326,4,1,50.00,2207,2,N'Pending',NULL),
	 (2327,14,1,100.00,2207,1,N'Pending',NULL),
	 (2328,NULL,1,75.00,2208,1,N'Pending',3),
	 (2329,NULL,1,500.00,2208,2,N'Pending',4),
	 (2330,NULL,1,100.00,2209,1,N'Pending',1),
	 (2331,NULL,1,75.00,2209,1,N'Pending',3),
	 (2332,23,1,1100.00,2210,3,N'Pending',NULL),
	 (2333,NULL,1,100.00,2210,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2334,NULL,1,100.00,2211,1,N'Pending',1),
	 (2335,NULL,1,100.00,2212,1,N'Pending',1),
	 (2336,4,1,50.00,2213,2,N'Pending',NULL),
	 (2337,4,1,50.00,2214,2,N'Pending',NULL),
	 (2338,14,2,100.00,2214,1,N'Pending',NULL),
	 (2339,NULL,2,100.00,2215,1,N'Pending',1),
	 (2340,NULL,1,100.00,2216,1,N'Pending',1),
	 (2341,NULL,1,75.00,2217,1,N'Pending',3),
	 (2342,NULL,1,500.00,2217,2,N'Pending',4),
	 (2343,NULL,1,100.00,2218,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2344,NULL,1,75.00,2218,1,N'Pending',3),
	 (2345,23,1,1100.00,2219,3,N'Pending',NULL),
	 (2346,NULL,1,100.00,2219,1,N'Pending',1),
	 (2347,4,1,50.00,2220,2,N'Pending',NULL),
	 (2348,4,1,50.00,2221,2,N'Pending',NULL),
	 (2349,14,2,100.00,2221,1,N'Pending',NULL),
	 (2350,NULL,2,100.00,2222,1,N'Pending',1),
	 (2351,NULL,1,100.00,2223,1,N'Pending',1),
	 (2352,NULL,1,75.00,2224,1,N'Pending',3),
	 (2353,NULL,1,500.00,2224,2,N'Pending',4);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2354,NULL,1,100.00,2225,1,N'Pending',1),
	 (2355,NULL,1,75.00,2225,1,N'Pending',3),
	 (2356,23,1,1100.00,2226,3,N'Pending',NULL),
	 (2357,NULL,1,100.00,2226,1,N'Pending',1),
	 (2358,4,1,50.00,2227,2,N'Pending',NULL),
	 (2359,4,1,50.00,2228,2,N'Pending',NULL),
	 (2360,14,2,100.00,2228,1,N'Pending',NULL),
	 (2361,NULL,2,100.00,2229,1,N'Pending',1),
	 (2362,NULL,1,100.00,2230,1,N'Pending',1),
	 (2363,NULL,1,75.00,2231,1,N'Pending',3);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2364,NULL,1,500.00,2231,2,N'Pending',4),
	 (2365,NULL,1,100.00,2232,1,N'Pending',1),
	 (2366,NULL,1,75.00,2232,1,N'Pending',3),
	 (2367,23,1,1100.00,2233,3,N'Pending',NULL),
	 (2368,NULL,1,100.00,2233,1,N'Pending',1),
	 (2369,4,1,50.00,2234,2,N'Pending',NULL),
	 (2370,4,1,50.00,2235,2,N'Pending',NULL),
	 (2371,14,2,100.00,2235,1,N'Pending',NULL),
	 (2372,NULL,2,100.00,2236,1,N'Pending',1),
	 (2373,NULL,1,100.00,2237,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2374,NULL,1,75.00,2238,1,N'Pending',3),
	 (2375,NULL,1,500.00,2238,2,N'Pending',4),
	 (2376,4,1,50.00,2239,2,N'Pending',NULL),
	 (2377,4,1,50.00,2240,2,N'Pending',NULL),
	 (2378,14,2,100.00,2240,1,N'Pending',NULL),
	 (2379,NULL,2,100.00,2241,1,N'Pending',1),
	 (2380,NULL,1,100.00,2242,1,N'Pending',1),
	 (2381,NULL,1,75.00,2243,1,N'Pending',3),
	 (2382,NULL,1,500.00,2243,2,N'Pending',4),
	 (2383,NULL,1,100.00,2244,1,N'Pending',1);
INSERT INTO PurchaseDetails (Id,DrugId,Quantity,Price,PurchaseId,PharmacyId,Status,ProductId) VALUES
	 (2384,NULL,1,75.00,2244,1,N'Pending',3),
	 (2385,23,1,1100.00,2245,3,N'Pending',NULL),
	 (2386,NULL,1,100.00,2245,1,N'Pending',1);


SET IDENTITY_INSERT PurchaseDetails OFF;
SET IDENTITY_INSERT Users ON;


INSERT INTO Users (Id,UserName,Email,Password,Address,RegistrationDate,RoleId,PharmacyId) VALUES
	 (1,N'admin',N'admin@gmail.com',N'Aqwertyu2.',N'Av. Rivera 3366','2022-10-06 14:25:10.4870000',1,NULL),
	 (2,N'admin1',N'admin1@gmail.com',N'Aqwertyu2.',N'18 de Julio','2022-10-06 08:22:14.1010000',1,NULL),
	 (3,N'owner1',N'owner1@gmail.com',N'Aqwertyu2.',N'18 de Julio 33333','2022-10-06 08:22:14.1010000',3,1),
	 (4,N'employee1',N'employee1@gmail.com',N'Aqwertyu2.',N'Charrua 123','2022-10-06 08:22:14.1010000',2,1),
	 (5,N'employee20',N'employee20@gmail.com',N'Aqwertyu2.',N'casa 2223 232323','2022-11-05 17:57:33.6990000',2,2),
	 (6,N'admin20',N'admin20@gmail.com',N'Aqwertyu2.',N'          ','2022-11-05 18:26:48.7260000',1,NULL),
	 (7,N'owner2',N'owner2@gmail.com',N'Aqwertyu2.',N'Bv. Artigas 3344','2022-11-16 21:39:39.3760000',3,3),
	 (8,N'employee2',N'employee2@gmail.com',N'Aqwertyu2.',N'26 de Marzo 9321','2022-11-16 21:40:24.6850000',2,3),
	 (9,N'Test invi',N'sebastianbandera17@gmail.com',N'Aqwertyu2.',N'Address','2023-09-16 23:08:07.8110000',2,1),
	 (1009,N'123',N'c@c.com',N'Aqwertyu2.',N'123','2023-09-17 18:08:02.6330000',1,NULL);
INSERT INTO Users (Id,UserName,Email,Password,Address,RegistrationDate,RoleId,PharmacyId) VALUES
	 (1010,N'12345',N'c@d.com',N'Aqwertyu2.',N'Aqwertyu2.','2023-09-17 18:24:49.0320000',2,1);


SET IDENTITY_INSERT Users OFF;
SET IDENTITY_INSERT Sessions ON;


INSERT INTO Sessions (Id,Token,UserId) VALUES
	 (1,N'3A3C2363-D3CA-4DEB-B2DD-C71300429D84',1),
	 (2,N'E9E0E1E9-3812-4EB5-949E-AE92AC931401',4),
	 (3,N'326DF984-A9F4-45A8-8A0B-79328578CC7C',3),
	 (4,N'81C22E46-C41A-4A4A-85DB-4B12E604DFC9',5),
	 (5,N'17BAB9A0-04EE-43D0-AED2-8A5F2009DB18',6),
	 (6,N'7DEC8321-C89D-4F63-B4F9-0C671E741510',8),
	 (7,N'59C25ED6-1090-49FD-ADF2-DE24E1E932F0',7),
	 (8,N'D4234974-61E6-4243-9332-57CCBD0F9573',9),
	 (1008,N'6B41BEF1-6403-4B70-9CB9-F9BCAEE5AE1F',1009),
	 (1009,N'6794F35E-5BA3-41C8-9D9D-8AA7C854FC89',1010);


SET IDENTITY_INSERT Sessions OFF;
SET IDENTITY_INSERT StockRequests ON;


INSERT INTO StockRequests (Id,Status,RequestDate,EmployeeId) VALUES
	 (1,3,'2022-10-06 16:46:17.4805118',4),
	 (2,2,'2022-10-06 16:47:37.9672539',4),
	 (3,2,'2022-10-10 15:06:00.7195011',4),
	 (4,2,'2022-11-03 20:54:23.7758022',4),
	 (5,2,'2022-11-03 20:55:27.9075100',4),
	 (6,2,'2022-11-03 20:56:04.5776349',4),
	 (7,2,'2022-11-03 20:56:34.2083236',4),
	 (8,2,'2022-11-03 20:56:43.8313148',4),
	 (9,2,'2022-11-03 20:58:16.8633664',4),
	 (10,2,'2022-11-05 14:40:44.2294652',4);
INSERT INTO StockRequests (Id,Status,RequestDate,EmployeeId) VALUES
	 (11,1,'2022-11-05 15:01:17.5256845',5),
	 (12,3,'2022-11-13 15:58:22.8137798',4),
	 (13,3,'2022-11-13 16:04:01.5388433',4),
	 (14,3,'2022-11-13 21:50:07.1024698',4),
	 (15,3,'2022-11-16 18:36:59.1518963',4),
	 (16,3,'2022-11-16 18:44:06.4953087',8),
	 (17,1,'2023-09-16 19:47:18.4589999',5),
	 (18,3,'2023-09-16 19:49:01.7301570',4);

SET IDENTITY_INSERT StockRequests OFF;
SET IDENTITY_INSERT StockRequestDetails ON;

INSERT INTO StockRequestDetails (Id,DrugId,Quantity,StockRequestId) VALUES
	 (1,2,1200,1),
	 (2,1,2000,1),
	 (3,3,200000,1),
	 (4,2,200,2),
	 (5,1,350,2),
	 (6,2,200,3),
	 (7,1,350,3),
	 (8,1,1,4),
	 (9,2,2,4),
	 (10,1,1,5);
INSERT INTO StockRequestDetails (Id,DrugId,Quantity,StockRequestId) VALUES
	 (11,2,2,5),
	 (12,1,1,6),
	 (13,1,1,7),
	 (14,11,100,8),
	 (15,1,1,9),
	 (16,2,1,9),
	 (17,10,1,9),
	 (18,11,8,9),
	 (19,10,40,10),
	 (20,2,3,10);
INSERT INTO StockRequestDetails (Id,DrugId,Quantity,StockRequestId) VALUES
	 (21,7,20,11),
	 (22,4,20,11),
	 (23,14,500,12),
	 (24,14,1,13),
	 (25,14,1000,14),
	 (26,14,100,15),
	 (27,15,100,15),
	 (28,16,100,15),
	 (29,17,100,15),
	 (30,18,100,15);
INSERT INTO StockRequestDetails (Id,DrugId,Quantity,StockRequestId) VALUES
	 (31,19,100,16),
	 (32,20,100,16),
	 (33,21,100,16),
	 (34,22,100,16),
	 (35,23,100,16),
	 (36,24,10,17),
	 (37,25,10,18);


SET IDENTITY_INSERT StockRequestDetails OFF;