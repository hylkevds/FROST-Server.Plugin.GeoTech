DROP VIEW IF EXISTS "THINGS_LOCATIONS";
CREATE OR REPLACE VIEW "THINGS_LOCATIONS"
AS SELECT
    "BH_CollarThings_LOCATIONS"."BH_CollarThing_ID" as "THING_ID",
    "BH_CollarThings_LOCATIONS"."LOCATION_ID" as "LOCATION_ID"
FROM "BH_CollarThings_LOCATIONS"
UNION
SELECT
    "BH_TrajectoryThings_LOCATIONS"."BH_TrajectoryThing_ID" as "THING_ID",
    "BH_TrajectoryThings_LOCATIONS"."LOCATION_ID" as "LOCATION_ID"
FROM "BH_TrajectoryThings_LOCATIONS";
