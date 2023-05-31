CREATE OR REPLACE VIEW "BH_FOI_TYPES"
AS SELECT
    "BH_HoleFoITypes"."ID",
    "BH_HoleFoITypes"."FOI_ID",
    "BH_HoleFoITypes"."FOI_TYPE"
FROM "BH_HoleFoITypes"
UNION
SELECT
    "BH_HolePointFoITypes"."ID",
    "BH_HolePointFoITypes"."FOI_ID",
    "BH_HolePointFoITypes"."FOI_TYPE"
FROM "BH_HolePointFoITypes"
UNION
SELECT
    "BH_HoleSegmentFoITypes"."ID",
    "BH_HoleSegmentFoITypes"."FOI_ID",
    "BH_HoleSegmentFoITypes"."FOI_TYPE"
FROM "BH_HoleSegmentFoITypes"
UNION
SELECT
    "BH_CoreFoITypes"."ID",
    "BH_CoreFoITypes"."FOI_ID",
    "BH_CoreFoITypes"."FOI_TYPE"
FROM "BH_CoreFoITypes"
UNION
SELECT
    "BH_CorePointFoITypes"."ID",
    "BH_CorePointFoITypes"."FOI_ID",
    "BH_CorePointFoITypes"."FOI_TYPE"
FROM "BH_CorePointFoITypes"
UNION
SELECT
    "BH_CoreSegmentFoITypes"."ID",
    "BH_CoreSegmentFoITypes"."FOI_ID",
    "BH_CoreSegmentFoITypes"."FOI_TYPE"
FROM "BH_CoreSegmentFoITypes";
