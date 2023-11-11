
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


INSERT INTO UnitMeasures (Name,Deleted) VALUES
	 (N'mg',0),
	 (N'g',0),
	 (N'ml',0),
	 (N'l',0);

INSERT INTO Presentations (Name,Deleted) VALUES
	 (N'capsules',0),
	 (N'tablet',0),
	 (N'liquid',0),
	 (N'patches',0),
	 (N'injections',0);

	
INSERT INTO Roles (Name) VALUES
	 (N'Administrator'),
	 (N'Employee'),
	 (N'Owner');

	
INSERT INTO Users (UserName,Email,Password,Address,RegistrationDate,RoleId,PharmacyId) VALUES
	 (N'admin',N'admin@gmail.com',N'Aqwertyu2.',N'Av. Rivera 3366','2022-10-06 14:25:10.4870000',1,NULL);




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



