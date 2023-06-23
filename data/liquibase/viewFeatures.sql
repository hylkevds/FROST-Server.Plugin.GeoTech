DROP VIEW IF EXISTS "FEATURES";
CREATE OR REPLACE VIEW "FEATURES"
AS SELECT
    "BH_Features"."ID",
    "BH_Features"."NAME",
    "BH_Features"."DESCRIPTION",
    "BH_Features"."ENCODING_TYPE",
    ST_AsGeoJSON("BH_Features"."FEATURE") as "FEATURE",
    "BH_Features"."FEATURE" as "GEOM",
    ((json_build_object('length', "BH_Features"."LENGTH", 'length_uom', "BH_Features"."LENGTH_UOM", 'recovery_percentage', "BH_Features"."RECOVERY_PERCENTAGE"))::jsonb || ("BH_Features"."PROPERTIES")::jsonb) AS "PROPERTIES"
FROM "BH_Features";
