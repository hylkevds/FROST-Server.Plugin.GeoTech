FROM fraunhoferiosb/frost-server-http:develop-2.x-2.2.0-SNAPSHOT

COPY data ${CATALINA_HOME}/webapps/FROST-Server/WEB-INF/data
COPY index.html ${CATALINA_HOME}/webapps/FROST-Server/

ENV plugins_coreModel_enable=true
ENV plugins_actuation_enable=false
ENV plugins_multiDatastream_enable=false
ENV plugins_openApi_enable=true
ENV plugins_odata_enable=true
ENV plugins_modelLoader_enable=true
ENV plugins_modelLoader_modelPath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/model'
ENV plugins_modelLoader_modelFiles='BhCollarThing.json, BhFeature.json, BhFeatureType.json, BhPreparationProcedure.json, BhPreparationStep.json, BhSampler.json, BhSampling.json, BhSamplingProcedure.json, BhTrajectoryThing.json, Datastream.json, Location.json, Observation.json, Sensor.json, Project.json, Role.json, User.json, UserProjectRole.json'
ENV plugins_modelLoader_securityPath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/model'
ENV plugins_modelLoader_securityFiles='secUsers.json, secDatastreams.json, secObservations.json, secProjects.json, secThings.json'
ENV plugins_modelLoader_liquibasePath='/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/liquibase'
ENV plugins_modelLoader_liquibaseFiles='geoTech.xml, security.xml'

USER tomcat
