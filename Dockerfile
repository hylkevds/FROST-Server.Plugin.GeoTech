FROM fraunhoferiosb/frost-server-http:2.2.0-SNAPSHOT

COPY data ${CATALINA_HOME}/webapps/FROST-Server/WEB-INF/data
COPY index.html ${CATALINA_HOME}/webapps/FROST-Server/

ENV plugins_coreModel_enable=true
ENV plugins_actuation_enable=false
ENV plugins_multiDatastream_enable=false
ENV plugins_openApi_enable=true
ENV plugins_odata_enable=true
ENV plugins_modelLoader_enable=true
ENV plugins_modelLoader_modelPath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/model'
ENV plugins_modelLoader_modelFiles='BhCollarThing.json, BhFeature.json, BhFeatureType.json, BhPreparationProcedure.json, BhPreparationStep.json, BhSampler.json, BhSampling.json, BhSamplingProcedure.json, BhTrajectoryThing.json, Datastream.json, Location.json, Observation.json, Project.json, Role.json, Sensor.json, User.json, UserProjectRole.json'
ENV plugins_modelLoader_securityPath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/security'
ENV plugins_modelLoader_securityFiles='secBhPreparationProcedure.json, secBhPreparationStep.json, secBhSampler.json, secBhSampling.json, secBhSamplingProcedure.json, secDatastream.json, secFeature.json, secLocation.json, secObservation.json, secObservedProperty.json, secProject.json, secRole.json, secSensor.json, secThing.json, secUser.json, secUserProjectRole.json'
ENV plugins_modelLoader_liquibasePath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/liquibase'
ENV plugins_modelLoader_liquibaseFiles='geoTech.xml, security.xml'
ENV plugins_modelLoader_idType_Role=STRING
ENV plugins_modelLoader_idType_User=STRING
ENV persistence_idGenerationMode_Role=ClientGeneratedOnly
ENV persistence_idGenerationMode_User=ClientGeneratedOnly

USER tomcat
