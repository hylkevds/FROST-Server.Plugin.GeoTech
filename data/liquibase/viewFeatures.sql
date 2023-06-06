DROP VIEW "FEATURES";
CREATE OR REPLACE VIEW "FEATURES"
AS SELECT
    "BH_HoleFoIs"."ID",
    "BH_HoleFoIs"."NAME",
    "BH_HoleFoIs"."DESCRIPTION",
    "BH_HoleFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_HoleFoIs"."FEATURE") as "FEATURE",
    "BH_HoleFoIs"."FEATURE" as "GEOM",
    ((json_build_object('length', "BH_HoleFoIs"."LENGTH", 'length_uom', "BH_HoleFoIs"."LENGTH_UOM"))::jsonb || ("BH_HoleFoIs"."PROPERTIES")::jsonb) AS "PROPERTIES"
FROM "BH_HoleFoIs"
UNION
SELECT
    "BH_CoreFoIs"."ID",
    "BH_CoreFoIs"."NAME",
    "BH_CoreFoIs"."DESCRIPTION",
    "BH_CoreFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_CoreFoIs"."FEATURE") as "FEATURE",
    "BH_CoreFoIs"."FEATURE" as "GEOM",
    ((json_build_object('length', "BH_CoreFoIs"."LENGTH", 'length_uom', "BH_CoreFoIs"."LENGTH_UOM"))::jsonb || ("BH_CoreFoIs"."PROPERTIES")::jsonb) AS "PROPERTIES"
FROM "BH_CoreFoIs"
UNION
SELECT
    "BH_HolePointFoIs"."ID",
    "BH_HolePointFoIs"."NAME",
    "BH_HolePointFoIs"."DESCRIPTION",
    "BH_HolePointFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_HolePointFoIs"."FEATURE") as "FEATURE",
    "BH_HolePointFoIs"."FEATURE" as "GEOM",
    ("BH_HolePointFoIs"."PROPERTIES")::jsonb AS "PROPERTIES"
FROM "BH_HolePointFoIs"
UNION
SELECT
    "BH_CorePointFoIs"."ID",
    "BH_CorePointFoIs"."NAME",
    "BH_CorePointFoIs"."DESCRIPTION",
    "BH_CorePointFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_CorePointFoIs"."FEATURE") as "FEATURE",
    "BH_CorePointFoIs"."FEATURE" as "GEOM",
    ("BH_CorePointFoIs"."PROPERTIES")::jsonb AS "PROPERTIES"
FROM "BH_CorePointFoIs"
UNION
SELECT
    "BH_HoleSegmentFoIs"."ID",
    "BH_HoleSegmentFoIs"."NAME",
    "BH_HoleSegmentFoIs"."DESCRIPTION",
    "BH_HoleSegmentFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_HoleSegmentFoIs"."FEATURE") as "FEATURE",
    "BH_HoleSegmentFoIs"."FEATURE" as "GEOM",
    ((json_build_object('length', "BH_HoleSegmentFoIs"."LENGTH", 'length_uom', "BH_HoleSegmentFoIs"."LENGTH_UOM"))::jsonb || ("BH_HoleSegmentFoIs"."PROPERTIES")::jsonb) AS "PROPERTIES"
FROM "BH_HoleSegmentFoIs"
UNION
SELECT
    "BH_CoreSegmentFoIs"."ID",
    "BH_CoreSegmentFoIs"."NAME",
    "BH_CoreSegmentFoIs"."DESCRIPTION",
    "BH_CoreSegmentFoIs"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_CoreSegmentFoIs"."FEATURE") as "FEATURE",
    "BH_CoreSegmentFoIs"."FEATURE" as "GEOM",
    ((json_build_object('length', "BH_CoreSegmentFoIs"."LENGTH", 'length_uom', "BH_CoreSegmentFoIs"."LENGTH_UOM", 'recovery_percentage', "BH_CoreSegmentFoIs"."RECOVERY_PERCENTAGE"))::jsonb || ("BH_CoreSegmentFoIs"."PROPERTIES")::jsonb) AS "PROPERTIES"
FROM "BH_CoreSegmentFoIs";
