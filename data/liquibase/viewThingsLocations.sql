CREATE OR REPLACE VIEW "THINGS_LOCATIONS"
AS SELECT
    "BH_CollarThings_LOCATIONS"."BH_CollarThing_ID",
    "BH_CollarThings_LOCATIONS"."LOCATION_ID"
FROM "BH_CollarThings_LOCATIONS"
UNION
SELECT
    "BH_TrajectoryThings_LOCATIONS"."BH_TrajectoryThing_ID",
    "BH_TrajectoryThings_LOCATIONS"."LOCATION_ID"
FROM "BH_TrajectoryThings_LOCATIONS";
