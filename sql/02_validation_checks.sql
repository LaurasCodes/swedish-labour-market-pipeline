SELECT
    (SELECT COUNT(*) FROM stg.JobAds)             AS StagingAds,
    (SELECT COUNT(*) FROM dw.DimLocation)         AS Locations,
    (SELECT COUNT(*) FROM dw.DimOccupation)       AS Occupations,
    (SELECT COUNT(*) FROM dw.DimEmployer)         AS Employers,
    (SELECT COUNT(*) FROM dw.DimDate)             AS Dates,
    (SELECT COUNT(*) FROM dw.FactJobAds)          AS FactJobAds,
    (SELECT COUNT(*) FROM dw.FactJobRequirements) AS FactJobRequirements,
    (SELECT COUNT(*) FROM dw.FactJobAds WHERE LocationKey   IS NULL) AS MissingLocation,
    (SELECT COUNT(*) FROM dw.FactJobAds WHERE OccupationKey IS NULL) AS MissingOccupation,
    (SELECT COUNT(*) FROM dw.FactJobAds WHERE EmployerKey   IS NULL) AS MissingEmployer,
    (SELECT COUNT(*) FROM dw.FactJobAds WHERE DateKey       IS NULL) AS MissingDate;

    SELECT TOP 10 Headline, NumberOfVacancies
FROM dw.FactJobAds
ORDER BY NumberOfVacancies DESC;

SELECT
    COUNT(DISTINCT CASE WHEN RequirementType = 'Language'
                        THEN JobAdKey END) AS AdsListingLanguage,
    COUNT(DISTINCT CASE WHEN RequirementLabel = 'Svenska'
                         AND RequirementLevel = 'Must Have'
                        THEN JobAdKey END) AS AdsRequiringSwedish
FROM dw.FactJobRequirements;