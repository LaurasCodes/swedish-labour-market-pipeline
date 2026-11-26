USE master;
GO

CREATE DATABASE SwedishLabourMarketDW;
GO



USE SwedishLabourMarketDW;
GO

CREATE SCHEMA stg;
GO

USE SwedishLabourMarketDW;
GO

CREATE TABLE stg.JobAds (
    [relevance] NVARCHAR(MAX),
    [id] NVARCHAR(MAX),
    [external_id] NVARCHAR(MAX),
    [original_id] NVARCHAR(MAX),
    [webpage_url] NVARCHAR(MAX),
    [logo_url] NVARCHAR(MAX),
    [headline] NVARCHAR(MAX),
    [application_deadline] NVARCHAR(MAX),
    [number_of_vacancies] NVARCHAR(MAX),
    [salary_description] NVARCHAR(MAX),
    [access] NVARCHAR(MAX),
    [experience_required] NVARCHAR(MAX),
    [access_to_own_car] NVARCHAR(MAX),
    [driving_license_required] NVARCHAR(MAX),
    [publication_date] NVARCHAR(MAX),
    [last_publication_date] NVARCHAR(MAX),
    [removed] NVARCHAR(MAX),
    [removed_date] NVARCHAR(MAX),
    [source_type] NVARCHAR(MAX),
    [timestamp] NVARCHAR(MAX),
    [description.text] NVARCHAR(MAX),
    [description.text_formatted] NVARCHAR(MAX),
    [description.company_information] NVARCHAR(MAX),
    [description.needs] NVARCHAR(MAX),
    [description.requirements] NVARCHAR(MAX),
    [description.conditions] NVARCHAR(MAX),
    [employment_type.concept_id] NVARCHAR(MAX),
    [employment_type.label] NVARCHAR(MAX),
    [employment_type.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [salary_type.concept_id] NVARCHAR(MAX),
    [salary_type.label] NVARCHAR(MAX),
    [salary_type.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [duration.concept_id] NVARCHAR(MAX),
    [duration.label] NVARCHAR(MAX),
    [duration.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [working_hours_type.concept_id] NVARCHAR(MAX),
    [working_hours_type.label] NVARCHAR(MAX),
    [working_hours_type.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [scope_of_work.min] NVARCHAR(MAX),
    [scope_of_work.max] NVARCHAR(MAX),
    [employer.phone_number] NVARCHAR(MAX),
    [employer.email] NVARCHAR(MAX),
    [employer.url] NVARCHAR(MAX),
    [employer.organization_number] NVARCHAR(MAX),
    [employer.name] NVARCHAR(MAX),
    [employer.workplace] NVARCHAR(MAX),
    [application_details.information] NVARCHAR(MAX),
    [application_details.reference] NVARCHAR(MAX),
    [application_details.email] NVARCHAR(MAX),
    [application_details.via_af] NVARCHAR(MAX),
    [application_details.url] NVARCHAR(MAX),
    [application_details.other] NVARCHAR(MAX),
    [occupation.concept_id] NVARCHAR(MAX),
    [occupation.label] NVARCHAR(MAX),
    [occupation.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [occupation_group.concept_id] NVARCHAR(MAX),
    [occupation_group.label] NVARCHAR(MAX),
    [occupation_group.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [occupation_field.concept_id] NVARCHAR(MAX),
    [occupation_field.label] NVARCHAR(MAX),
    [occupation_field.legacy_ams_taxonomy_id] NVARCHAR(MAX),
    [workplace_model.concept_id] NVARCHAR(MAX),
    [workplace_model.label] NVARCHAR(MAX),
    [workplace_address.municipality] NVARCHAR(MAX),
    [workplace_address.municipality_code] NVARCHAR(MAX),
    [workplace_address.municipality_concept_id] NVARCHAR(MAX),
    [workplace_address.region] NVARCHAR(MAX),
    [workplace_address.region_code] NVARCHAR(MAX),
    [workplace_address.region_concept_id] NVARCHAR(MAX),
    [workplace_address.country] NVARCHAR(MAX),
    [workplace_address.country_code] NVARCHAR(MAX),
    [workplace_address.country_concept_id] NVARCHAR(MAX),
    [workplace_address.street_address] NVARCHAR(MAX),
    [workplace_address.postcode] NVARCHAR(MAX),
    [workplace_address.city] NVARCHAR(MAX)
);
GO

CREATE TABLE stg.JobRequirements (
    [job_id] NVARCHAR(MAX),
    [concept_id] NVARCHAR(MAX),
    [requirement_label] NVARCHAR(MAX),
    [requirement_type] NVARCHAR(MAX),
    [requirement_level] NVARCHAR(MAX),
    [weight] NVARCHAR(MAX),
    [legacy_ams_taxonomy_id] NVARCHAR(MAX)
);
GO

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'stg';


USE SwedishLabourMarketDW;
GO

SELECT COUNT(*) AS TotalJobAds
FROM dbo.Job_ads_source;

USE SwedishLabourMarketDW;
GO

SELECT COUNT(*) AS TotalJobAds
FROM dbo.Job_requirements_source;

select * 
from dbo.job_ads_source;


USE SwedishLabourMarketDW;
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
    (TABLE_SCHEMA = 'dbo'
     AND TABLE_NAME IN
         ('job_ads_source', 'job_requirements_source'))
    OR
    (TABLE_SCHEMA = 'stg'
     AND TABLE_NAME IN
         ('JobAds', 'JobRequirements'))
ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME,
    ORDINAL_POSITION;

USE SwedishLabourMarketDW;
GO

-- Prevent accidentally inserting the same records twice
IF EXISTS (SELECT 1 FROM stg.JobAds)
BEGIN
    THROW 50001, 'stg.JobAds already contains data. Insert cancelled.', 1;
END;
GO

INSERT INTO stg.JobAds (
    [relevance],
    [id],
    [external_id],
    [original_id],
    [webpage_url],
    [logo_url],
    [headline],
    [application_deadline],
    [number_of_vacancies],
    [salary_description],
    [access],
    [experience_required],
    [access_to_own_car],
    [driving_license_required],
    [publication_date],
    [last_publication_date],
    [removed],
    [removed_date],
    [source_type],
    [timestamp],
    [description.text],
    [description.text_formatted],
    [description.company_information],
    [description.needs],
    [description.requirements],
    [description.conditions],
    [employment_type.concept_id],
    [employment_type.label],
    [employment_type.legacy_ams_taxonomy_id],
    [salary_type.concept_id],
    [salary_type.label],
    [salary_type.legacy_ams_taxonomy_id],
    [duration.concept_id],
    [duration.label],
    [duration.legacy_ams_taxonomy_id],
    [working_hours_type.concept_id],
    [working_hours_type.label],
    [working_hours_type.legacy_ams_taxonomy_id],
    [scope_of_work.min],
    [scope_of_work.max],
    [employer.phone_number],
    [employer.email],
    [employer.url],
    [employer.organization_number],
    [employer.name],
    [employer.workplace],
    [application_details.information],
    [application_details.reference],
    [application_details.email],
    [application_details.via_af],
    [application_details.url],
    [application_details.other],
    [occupation.concept_id],
    [occupation.label],
    [occupation.legacy_ams_taxonomy_id],
    [occupation_group.concept_id],
    [occupation_group.label],
    [occupation_group.legacy_ams_taxonomy_id],
    [occupation_field.concept_id],
    [occupation_field.label],
    [occupation_field.legacy_ams_taxonomy_id],
    [workplace_model.concept_id],
    [workplace_model.label],
    [workplace_address.municipality],
    [workplace_address.municipality_code],
    [workplace_address.municipality_concept_id],
    [workplace_address.region],
    [workplace_address.region_code],
    [workplace_address.region_concept_id],
    [workplace_address.country],
    [workplace_address.country_code],
    [workplace_address.country_concept_id],
    [workplace_address.street_address],
    [workplace_address.postcode],
    [workplace_address.city]
)
SELECT
    [relevance],
    [id],
    [external_id],
    [original_id],
    [webpage_url],
    [logo_url],
    [headline],
    [application_deadline],
    [number_of_vacancies],
    [salary_description],
    [access],
    [experience_required],
    [access_to_own_car],
    [driving_license_required],
    [publication_date],
    [last_publication_date],
    [removed],
    [removed_date],
    [source_type],
    [timestamp],
    [description_text],
    [description_text_formatted],
    [description_company_information],
    [description_needs],
    [description_requirements],
    [description_conditions],
    [employment_type_concept_id],
    [employment_type_label],
    [employment_type_legacy_ams_taxonomy_id],
    [salary_type_concept_id],
    [salary_type_label],
    [salary_type_legacy_ams_taxonomy_id],
    [duration_concept_id],
    [duration_label],
    [duration_legacy_ams_taxonomy_id],
    [working_hours_type_concept_id],
    [working_hours_type_label],
    [working_hours_type_legacy_ams_taxonomy_id],
    [scope_of_work_min],
    [scope_of_work_max],
    [employer_phone_number],
    [employer_email],
    [employer_url],
    [employer_organization_number],
    [employer_name],
    [employer_workplace],
    [application_details_information],
    [application_details_reference],
    [application_details_email],
    [application_details_via_af],
    [application_details_url],
    [application_details_other],
    [occupation_concept_id],
    [occupation_label],
    [occupation_legacy_ams_taxonomy_id],
    [occupation_group_concept_id],
    [occupation_group_label],
    [occupation_group_legacy_ams_taxonomy_id],
    [occupation_field_concept_id],
    [occupation_field_label],
    [occupation_field_legacy_ams_taxonomy_id],
    [workplace_model_concept_id],
    [workplace_model_label],
    [workplace_address_municipality],
    [workplace_address_municipality_code],
    [workplace_address_municipality_concept_id],
    [workplace_address_region],
    [workplace_address_region_code],
    [workplace_address_region_concept_id],
    [workplace_address_country],
    [workplace_address_country_code],
    [workplace_address_country_concept_id],
    [workplace_address_street_address],
    [workplace_address_postcode],
    [workplace_address_city]
FROM dbo.job_ads_source;
GO

-- Verify the transfer
SELECT COUNT(*) AS TotalStagedJobAds
FROM stg.JobAds;

USE SwedishLabourMarketDW;
GO

IF EXISTS (SELECT 1 FROM stg.JobRequirements)
BEGIN
    THROW 50001, 'Staging table already contains data. Insert cancelled.', 1;
END;

INSERT INTO stg.JobRequirements (
    [job_id],
    [concept_id],
    [requirement_label],
    [requirement_type],
    [requirement_level],
    [weight],
    [legacy_ams_taxonomy_id]
)
SELECT
    [job_id],
    [concept_id],
    [requirement_label],
    [requirement_type],
    [requirement_level],
    [weight],
    [legacy_ams_taxonomy_id]
FROM dbo.job_requirements_source;

SELECT COUNT(*) AS TotalStagedRequirements
FROM stg.JobRequirements;

USE SwedishLabourMarketDW;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'dw'
)
BEGIN
    EXEC('CREATE SCHEMA dw');
END;
GO

SELECT name AS SchemaName
FROM sys.schemas
WHERE name IN ('stg', 'dw');

USE SwedishLabourMarketDW;
GO

CREATE TABLE dw.DimLocation (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Municipality NVARCHAR(200),
    Region NVARCHAR(200),
    City NVARCHAR(200),
    Country NVARCHAR(200)
);
GO

INSERT INTO dw.DimLocation (
    Municipality,
    Region,
    City,
    Country
)
SELECT DISTINCT
    NULLIF(LTRIM(RTRIM([workplace_address.municipality])), ''),
    NULLIF(LTRIM(RTRIM([workplace_address.region])), ''),
    NULLIF(LTRIM(RTRIM([workplace_address.city])), ''),
    NULLIF(LTRIM(RTRIM([workplace_address.country])), '')
FROM stg.JobAds;
GO

SELECT *
FROM dw.DimLocation
ORDER BY Region, Municipality;

USE SwedishLabourMarketDW;
GO

CREATE TABLE dw.DimOccupation (
    OccupationKey INT IDENTITY(1,1) PRIMARY KEY,
    OccupationConceptID NVARCHAR(100),
    OccupationName NVARCHAR(300),
    OccupationGroup NVARCHAR(300),
    OccupationField NVARCHAR(300)
);
GO

INSERT INTO dw.DimOccupation (
    OccupationConceptID,
    OccupationName,
    OccupationGroup,
    OccupationField
)
SELECT DISTINCT
    NULLIF(LTRIM(RTRIM([occupation.concept_id])), ''),
    NULLIF(LTRIM(RTRIM([occupation.label])), ''),
    NULLIF(LTRIM(RTRIM([occupation_group.label])), ''),
    NULLIF(LTRIM(RTRIM([occupation_field.label])), '')
FROM stg.JobAds;
GO

-- Verify the occupation dimension
SELECT COUNT(*) AS TotalOccupations
FROM dw.DimOccupation;

SELECT TOP 20 *
FROM dw.DimOccupation
ORDER BY OccupationName;

USE SwedishLabourMarketDW;
GO

CREATE TABLE dw.DimEmployer (
    EmployerKey INT IDENTITY(1,1) PRIMARY KEY,
    EmployerName NVARCHAR(500),
    OrganizationNumber NVARCHAR(100),
    EmployerWorkplace NVARCHAR(500)
);
GO

INSERT INTO dw.DimEmployer (
    EmployerName,
    OrganizationNumber,
    EmployerWorkplace
)
SELECT DISTINCT
    NULLIF(LTRIM(RTRIM([employer.name])), ''),
    NULLIF(LTRIM(RTRIM([employer.organization_number])), ''),
    NULLIF(LTRIM(RTRIM([employer.workplace])), '')
FROM stg.JobAds;
GO

-- Verify the results
SELECT COUNT(*) AS TotalEmployers
FROM dw.DimEmployer;

SELECT TOP 20 *
FROM dw.DimEmployer
ORDER BY EmployerName;

USE SwedishLabourMarketDW;
GO

IF OBJECT_ID('dw.DimDate', 'U') IS NULL
BEGIN
    CREATE TABLE dw.DimDate (
        DateKey INT PRIMARY KEY,
        FullDate DATE NOT NULL UNIQUE,
        [Year] INT,
        [Quarter] INT,
        [Month] INT,
        MonthName NVARCHAR(20),
        [Day] INT,
        DayOfWeekName NVARCHAR(20)
    );
END;
GO

INSERT INTO dw.DimDate (
    DateKey,
    FullDate,
    [Year],
    [Quarter],
    [Month],
    MonthName,
    [Day],
    DayOfWeekName
)
SELECT
    CONVERT(INT, CONVERT(CHAR(8), d.FullDate, 112)),
    d.FullDate,
    YEAR(d.FullDate),
    DATEPART(QUARTER, d.FullDate),
    MONTH(d.FullDate),
    DATENAME(MONTH, d.FullDate),
    DAY(d.FullDate),
    DATENAME(WEEKDAY, d.FullDate)
FROM (
    SELECT DISTINCT
        TRY_CONVERT(DATE, [publication_date]) AS FullDate
    FROM stg.JobAds
) AS d
WHERE d.FullDate IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM dw.DimDate existing
      WHERE existing.FullDate = d.FullDate
  );
GO

SELECT COUNT(*) AS TotalDates
FROM dw.DimDate;

SELECT TOP 20 *
FROM dw.DimDate
ORDER BY FullDate;

USE SwedishLabourMarketDW;
GO

IF OBJECT_ID('dw.FactJobAds', 'U') IS NULL
BEGIN
    CREATE TABLE dw.FactJobAds (
        JobAdKey INT IDENTITY(1,1) PRIMARY KEY,
        JobID NVARCHAR(100) NOT NULL,
        LocationKey INT NULL,
        OccupationKey INT NULL,
        EmployerKey INT NULL,
        DateKey INT NULL,
        NumberOfVacancies INT NULL,
        Headline NVARCHAR(MAX),
        ApplicationDeadline DATE NULL,

        CONSTRAINT FK_JobAds_Location
            FOREIGN KEY (LocationKey)
            REFERENCES dw.DimLocation(LocationKey),

        CONSTRAINT FK_JobAds_Occupation
            FOREIGN KEY (OccupationKey)
            REFERENCES dw.DimOccupation(OccupationKey),

        CONSTRAINT FK_JobAds_Employer
            FOREIGN KEY (EmployerKey)
            REFERENCES dw.DimEmployer(EmployerKey),

        CONSTRAINT FK_JobAds_Date
            FOREIGN KEY (DateKey)
            REFERENCES dw.DimDate(DateKey)
    );
END;
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'dw'
ORDER BY TABLE_NAME;

USE SwedishLabourMarketDW;
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    -- Prevent duplicate loading
    IF EXISTS (SELECT 1 FROM dw.FactJobAds)
        THROW 50001, 'FactJobAds already contains data. Load cancelled.', 1;

    -- Check for ambiguous dimension matches
    IF EXISTS (
        SELECT 1
        FROM stg.JobAds AS s
        LEFT JOIN dw.DimLocation AS l
          ON EXISTS (
              SELECT
                NULLIF(TRIM(s.[workplace_address.municipality]), ''),
                NULLIF(TRIM(s.[workplace_address.region]), ''),
                NULLIF(TRIM(s.[workplace_address.city]), ''),
                NULLIF(TRIM(s.[workplace_address.country]), '')
              INTERSECT
              SELECT l.Municipality, l.Region, l.City, l.Country
          )
        LEFT JOIN dw.DimOccupation AS o
          ON EXISTS (
              SELECT
                NULLIF(TRIM(s.[occupation.concept_id]), ''),
                NULLIF(TRIM(s.[occupation.label]), ''),
                NULLIF(TRIM(s.[occupation_group.label]), ''),
                NULLIF(TRIM(s.[occupation_field.label]), '')
              INTERSECT
              SELECT
                o.OccupationConceptID, o.OccupationName,
                o.OccupationGroup, o.OccupationField
          )
        LEFT JOIN dw.DimEmployer AS e
          ON EXISTS (
              SELECT
                NULLIF(TRIM(s.[employer.name]), ''),
                NULLIF(TRIM(s.[employer.organization_number]), ''),
                NULLIF(TRIM(s.[employer.workplace]), '')
              INTERSECT
              SELECT e.EmployerName, e.OrganizationNumber, e.EmployerWorkplace
          )
        GROUP BY s.[id]
        HAVING COUNT(*) > 1
    )
        THROW 50002, 'Duplicate job IDs or ambiguous dimension matches detected. Load cancelled.', 1;

    INSERT INTO dw.FactJobAds (
        JobID,
        LocationKey,
        OccupationKey,
        EmployerKey,
        DateKey,
        NumberOfVacancies,
        Headline,
        ApplicationDeadline
    )
    SELECT
        s.[id],
        l.LocationKey,
        o.OccupationKey,
        e.EmployerKey,
        d.DateKey,
        TRY_CONVERT(INT, s.[number_of_vacancies]),
        s.[headline],
        TRY_CONVERT(DATE, s.[application_deadline])
    FROM stg.JobAds AS s

    LEFT JOIN dw.DimLocation AS l
      ON EXISTS (
          SELECT
            NULLIF(TRIM(s.[workplace_address.municipality]), ''),
            NULLIF(TRIM(s.[workplace_address.region]), ''),
            NULLIF(TRIM(s.[workplace_address.city]), ''),
            NULLIF(TRIM(s.[workplace_address.country]), '')
          INTERSECT
          SELECT l.Municipality, l.Region, l.City, l.Country
      )

    LEFT JOIN dw.DimOccupation AS o
      ON EXISTS (
          SELECT
            NULLIF(TRIM(s.[occupation.concept_id]), ''),
            NULLIF(TRIM(s.[occupation.label]), ''),
            NULLIF(TRIM(s.[occupation_group.label]), ''),
            NULLIF(TRIM(s.[occupation_field.label]), '')
          INTERSECT
          SELECT
            o.OccupationConceptID, o.OccupationName,
            o.OccupationGroup, o.OccupationField
      )

    LEFT JOIN dw.DimEmployer AS e
      ON EXISTS (
          SELECT
            NULLIF(TRIM(s.[employer.name]), ''),
            NULLIF(TRIM(s.[employer.organization_number]), ''),
            NULLIF(TRIM(s.[employer.workplace]), '')
          INTERSECT
          SELECT e.EmployerName, e.OrganizationNumber, e.EmployerWorkplace
      )

    LEFT JOIN dw.DimDate AS d
      ON d.FullDate = TRY_CONVERT(DATE, s.[publication_date]);

    -- Validate before committing
    IF (SELECT COUNT(*) FROM dw.FactJobAds)
       <> (SELECT COUNT(*) FROM stg.JobAds)
        THROW 50003, 'Fact and staging row counts differ. Load rolled back.', 1;

    COMMIT TRANSACTION;

    SELECT
        COUNT(*) AS TotalFactJobAds,
        COUNT(DISTINCT JobID) AS UniqueJobIDs,
        SUM(NumberOfVacancies) AS TotalVacancies,
        SUM(CASE WHEN LocationKey IS NULL THEN 1 ELSE 0 END) AS MissingLocationKeys,
        SUM(CASE WHEN OccupationKey IS NULL THEN 1 ELSE 0 END) AS MissingOccupationKeys,
        SUM(CASE WHEN EmployerKey IS NULL THEN 1 ELSE 0 END) AS MissingEmployerKeys
    FROM dw.FactJobAds;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;


USE SwedishLabourMarketDW;
GO

IF OBJECT_ID('dw.FactJobRequirements', 'U') IS NULL
BEGIN
    CREATE TABLE dw.FactJobRequirements (
        RequirementKey INT IDENTITY(1,1) PRIMARY KEY,
        JobAdKey INT NOT NULL,
        ConceptID NVARCHAR(100),
        RequirementLabel NVARCHAR(500),
        RequirementType NVARCHAR(100),
        RequirementLevel NVARCHAR(100),
        Weight FLOAT NULL,

        CONSTRAINT FK_Requirements_JobAds
            FOREIGN KEY (JobAdKey)
            REFERENCES dw.FactJobAds(JobAdKey)
    );
END;
GO

-- Check that all requirements can be linked to job advertisements
SELECT
    COUNT(*) AS TotalRequirements,
    SUM(CASE WHEN f.JobAdKey IS NULL THEN 1 ELSE 0 END)
        AS UnmatchedRequirements
FROM stg.JobRequirements AS r
LEFT JOIN dw.FactJobAds AS f
    ON r.job_id = f.JobID;


USE SwedishLabourMarketDW;
GO

INSERT INTO dw.FactJobRequirements (
    JobAdKey,
    ConceptID,
    RequirementLabel,
    RequirementType,
    RequirementLevel,
    Weight
)
SELECT
    f.JobAdKey,
    r.concept_id,
    r.requirement_label,
    r.requirement_type,
    r.requirement_level,
    TRY_CONVERT(FLOAT, r.weight)
FROM stg.JobRequirements AS r
INNER JOIN dw.FactJobAds AS f
    ON r.job_id = f.JobID
WHERE NOT EXISTS (
    SELECT 1
    FROM dw.FactJobRequirements
);
GO

-- Verify the result
SELECT
    COUNT(*) AS TotalFactRequirements,
    COUNT(DISTINCT JobAdKey) AS JobsWithRequirements
FROM dw.FactJobRequirements;

USE SwedishLabourMarketDW;
GO

SELECT
    (SELECT COUNT(*) FROM dw.FactJobAds)
        AS TotalJobAds,

    (SELECT COUNT(DISTINCT JobID)
     FROM dw.FactJobAds)
        AS UniqueJobAds,

    (SELECT SUM(NumberOfVacancies)
     FROM dw.FactJobAds)
        AS TotalVacancies,

    (SELECT COUNT(*)
     FROM dw.FactJobRequirements)
        AS TotalRequirements,

    (SELECT COUNT(*)
     FROM dw.FactJobAds
     WHERE LocationKey IS NULL
        OR OccupationKey IS NULL
        OR EmployerKey IS NULL
        OR DateKey IS NULL)
        AS MissingDimensionKeys,

    (SELECT COUNT(*)
     FROM dw.FactJobRequirements r
     LEFT JOIN dw.FactJobAds f
         ON r.JobAdKey = f.JobAdKey
     WHERE f.JobAdKey IS NULL)
        AS OrphanRequirements;

    USE SwedishLabourMarketDW;
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN (
    'job_ads_source',
    'job_requirements_source'
)
ORDER BY TABLE_SCHEMA, TABLE_NAME;

SELECT TOP 10 *
FROM dw.DimLocation;

SELECT COUNT(*) AS Total, COUNT(DISTINCT FullDate) AS UniqueDates FROM dw.DimDate;
SELECT 'Location' AS Dim, COUNT(*) AS TotalRows,
       (SELECT COUNT(*) FROM (SELECT DISTINCT Municipality, Region, City, Country FROM dw.DimLocation) x) AS UniqueRows
FROM dw.DimLocation
UNION ALL
SELECT 'Occupation', COUNT(*),
       (SELECT COUNT(*) FROM (SELECT DISTINCT OccupationConceptID, OccupationName, OccupationGroup, OccupationField FROM dw.DimOccupation) x)
FROM dw.DimOccupation
UNION ALL
SELECT 'Employer', COUNT(*),
       (SELECT COUNT(*) FROM (SELECT DISTINCT EmployerName, OrganizationNumber, EmployerWorkplace FROM dw.DimEmployer) x)
FROM dw.DimEmployer;

-- 1. What columns does it have?
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dw' AND TABLE_NAME = 'FactJobRequirements'
ORDER BY ORDINAL_POSITION;

-- 2. How many rows, and what do they look like?
SELECT COUNT(*) AS TotalRows FROM dw.FactJobRequirements;
SELECT TOP 10 * FROM dw.FactJobRequirements;