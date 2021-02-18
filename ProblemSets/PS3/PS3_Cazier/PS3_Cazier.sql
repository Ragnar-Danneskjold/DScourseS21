


CREATE TABLE "FloridaInsurance"(

policyID INTEGER,
statecode CHARACTER,
county CHARACTER,
eq_site_limit INTEGER,
hu_site_limit INTEGER,
fl_site_limit INTEGER,
fr_site_limit INTEGER,
Tiv2011 INTEGER,
Tiv2012 INTEGER,
eqSiteDeductible INTEGER,
huSiteDeductible INTEGER,
flSiteDeductible INTEGER,
frSiteDeductible INTEGER, 
pointLatitude DOUBLE,
pointLongitude DOUBLE,
line CHARACTER,
construction CHARACTER,
point_granularitypo INTEGER
);

.mode csv
.import FL_insurance_sample.csv FloridaInsurance

DELETE FROM FloridaInsurance WHERE eq_site_limit = 'eq_site_limit';

SELECT * FROM FloridaInsurance LIMIT 10;

SELECT DISTINCT county FROM FloridaInsurance;

SELECT AVG(Tiv2012 - Tiv2011) FROM FloridaInsurance;

SELECT construction, COUNT(*) FROM FloridaInsurance GROUP BY construction;
