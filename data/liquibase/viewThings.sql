CREATE OR REPLACE VIEW "THINGS"
AS 
SELECT
    "BH_CollarThings"."ID",
    "BH_CollarThings"."DESCRIPTION",
    "BH_CollarThings"."PROPERTIES"::jsonb,
    "BH_CollarThings"."NAME"
FROM "BH_CollarThings"
UNION
SELECT
    "BH_TrajectoryThings"."ID",
    "BH_TrajectoryThings"."DESCRIPTION",
    json_build_object('offsetHole', "BH_TrajectoryThings"."OFFSET_HOLE", 'offsetCore', "BH_TrajectoryThings"."OFFSET_CORE", 'lengthHole', "BH_TrajectoryThings"."LENGTH_HOLE", 'lengthCore', "BH_TrajectoryThings"."LENGTH_CORE", 'uom', "BH_TrajectoryThings"."UOM")::jsonb || "BH_TrajectoryThings"."PROPERTIES" AS "PROPERTIES",
    "BH_TrajectoryThings"."NAME"
FROM "BH_TrajectoryThings";
