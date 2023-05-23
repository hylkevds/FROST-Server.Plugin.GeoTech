FROM fraunhoferiosb/frost-server-http:develop-FineGrainedAuth-2.2.0-SNAPSHOT

COPY data ${CATALINA_HOME}/webapps/FROST-Server/WEB-INF/data
COPY index.html ${CATALINA_HOME}/webapps/FROST-Server/

ENV plugins_coreModel_enable=false
ENV plugins_actuation_enable=false
ENV plugins_multiDatastream_enable=false
ENV plugins_openApi_enable=true
ENV plugins_odata_enable=true
ENV plugins_modelLoader_enable=true
ENV plugins_modelLoader_modelPath='webapps/FROST-Server/WEB-INF/data/model'
ENV plugins_modelLoader_modelFiles='BhCollarThing.json, BhCoreFoi.json, BhCoreFoiType.json, BhCorePointFoi.json, BhCorePointFoiType.json, BhCoreSegmentFoi.json, BhCoreSegmentFoiType.json, BhFoi.json, BhFoiType.json, BhHoleFoi.json, BhHoleFoiType.json, BhHolePointFoi.json, BhHolePointFoiType.json, BhHoleSegmentFoi.json, BhHoleSegmentFoiType.json, BhPreparationProcedure.json, BhPreparationStep.json, BhSampler.json, BhSampling.json, BhSamplingProcedure.json, BhThing.json, BhTrajectoryThing.json, Datastream.json, Location.json, Observation.json'
ENV plugins_modelLoader_liquibasePath='../data/liquibase'
ENV plugins_modelLoader_liquibaseFiles_='tables.xml'

USER tomcat
