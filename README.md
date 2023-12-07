# FROST-Server.Plugin.GeoTech
A FROST-Server Plugin extending the SensorThings data model with a GeoTech borehole data model

## Installing

The plugin can be used with docker, or directly on an existing Tomcat server.

### Docker

The easiest way to use the plugin is as a docker image.
An [example DockerCompse file](scripts/docker-compose.yaml) is provided with the plugin.
You can either build the Docker image yourself using the provided [Dockerfile](Dockerfile) or use the image `hylkevds/frost-http-geotech:latest`.

### Tomcat

To use the plugin with a FROST-Server installed directly in a local Tomcat:
1. Copy the files to the local file system (easiest using `git checkout `)
1. Add the following parameters to the context XML file:
   - `plugins.coreModel.enable` = `true`
   - `plugins.actuation.enable` = `false`
   - `plugins.multiDatastream.enable` = `false`
   - `plugins.openApi.enable` = `true`
   - `plugins.odata.enable` = `true`
   - `plugins.csv.enable` = `true`
   - `plugins.geojson.enable` = `true`
   - `plugins.modelLoader.enable` = `true`
   - `plugins.modelLoader.modelPath` = `/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/model`
   - `plugins.modelLoader.modelFiles` = `Project.json, Restricted.json, Role.json, User.json, UserProjectRole.json`
   - `plugins.modelLoader.securityPath` = `/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/security`
   - `plugins.modelLoader.securityFiles` = `secDatastream.json, secFeature.json, secLocation.json, secObservation.json, secProject.json, secSensor.json, secThing.json, secUser.json`
   - `plugins.modelLoader.liquibasePath` = `/usr/local/tomcat/webapps/FROST-Server/WEB-INF/data/liquibase`
   - `plugins.modelLoader.liquibaseFiles` = `tablesSecurityUPR.xml`
   - `plugins.modelLoader.idType.Role` = `STRING`
   - `plugins.modelLoader.idType.User` = `STRING`
   - `persistence.idGenerationMode.Role` = `ClientGeneratedOnly`
   - `persistence.idGenerationMode.User` = `ClientGeneratedOnly`
1. Correct the three paths to the modelFiles, securityFiles and liquibaseFiles.
1. Restart the web application and run the database update.


## Data Model

The image below shows the core STA data model in blue, with the GeoTech data model extension in green and the security extension in yellow.

![Data Model](Datamodel-SensorThingsApi-GeoTech.drawio.png)


## Entity creation order

Since some entities in the data model require other entities, like the Datastream requiring a Thing, there is a certain order in which these entities should be created. The general order is:
1. FeatureType (re-used often)
1. ObservedProperty (re-used often)
1. BhCollarThing + Location
1. BhTrajectoryThing + Location
1. BhSampler + BhSamplingProcedure (if present)
1. BhSampling
1. BhFeatureOfInterest
1. BhPreparationProcedure (if present)
1. BhPreparationStep (if present)
1. Sensor
1. Datastream
1. Observation

There are some things to take into account when populating the data model:
- The FeatureTypes and ObservedProperties are re-used often, and should only be created once per server.
- Things and FeaturesOfInterest are not directly created in the GeoTech data model extension. These entities are automatically populated from the BhCollarThing, BhTrajectoryThing and BhFeatureOfInterest.
- A Datastream is linked to either a BhCollarThing or a BhTrajectoryThing, but not to both.
- When creating an Observation, the id of the BhFeatureOfInterest should be given as FeatureOfInterest, otherwise FROST will try to generate a FeatureOfInterest, and fail. For example:
  ```
  {
    "phenomenonTime": "2017-12-31T23:00:00.000Z/2018-01-01T00:00:00.000Z",
    "result": 12.6,
    "Datastream": {
        "@iot.id": 42
    },
    "FeatureOfInterest": {
        "@iot.id": 99
    }
  }
  ```

A [demonstration Batch Request](https://github.com/hylkevds/FROST-Server.Plugin.GeoTech/blob/main/scripts/BatchUploadTemplate.json) is available that creates examples of all entity types, with their relations, in the correct order.


## Security Extension

The security extension that is part of the FROST GeoTech Plugin adds powerful project-management related access control features. The extension adds four extra EntityTypes to the data model:
- User
- Role
- Project
- UserProjectRole

The `User` entities represent users of the system. When combined with the BasicAuth authentication plugin (the Default in the docker image) users must be explicitly created with a username and a password. When combined with the KeyCloak plugin, User entities are automatically created, and don't have a password field. The password field can not be read by anyone, not even global admins.

The `Project` entities represent a unit of management that ties Users in one or more Roles to Entities. Projects are directly linked to Sensors and Things. All other entities in the data model are indirectly linked to Projects through a Thing. For instance, Observations belong to the Project of the Thing of their Datastream (Project -> Thing -> Datastream -> Observation) and BhFeaturesOfInterest are linked to a Project through the Sampling (Project -> BhTrajectoryThing -> BhSampling -> BhFeatureOfInterest). ObservedProperties are shared among all Projects and can only be created or modified by a global server admin. Finally, Projects can be either public or private through the property `public`. If the `public` property of a Project is true, then all users of the system can read entities associated to the Project. If the `public` property is false, then only Users that have the `read` right on that Project, or have global `read` rights, can read Observations associated with that Project. 

The `Role` entities represent rights that a User can have. Roles can be directly linked to a User, or indirectly through a UserProjectRole Entity for a given Project. Roles that are directly connected to a User apply to the entire service. Roles that are linked to a user for a Project only apply to Entites of that Project. For instance, a User that has the global Role `update` can modify all Entities in the service. A user that has the `update` role for a given Project can only modify those Entities that are related to that specific Project.

A UserProjectRole entity gives a User a certain Role within a certain Project.

A normal user can only read the `User` Entity that belongs to their user account. Users that have a project role of `admin` can read all User entities, since a project admin must be able to add Users to their Project. The password of a user (when BasicAuth is used) can only be changed by the User themselves, or by a global admin.

The rights for the different user types:

  | Admin (admin, c,r,u,d) | Geotech Expert (r,c,u,d) | Public (for open projects) | Public (for private projects) | Project manager (a,c,r,u,d) | Project contributor (r,c,u,d) | Project member (read)
-- | -- | -- | -- | -- | -- | -- | --
Project | CRUD | R | R |   | R | R | R
User | CRUD | R (self) |   |   | R (all) | R (self) | R (self)
Role | CRUD | R (self) |   |   | R (all) | R (self) | R (self)
UserProjectRole | CRUD | R (self) |   |   | CRUD (project) | R (self) | R (self)
ObsProp | CRUD | CRUD | R | R | R | R | R
Sensor | CRUD | CRUD | R |   | CRUD | R | R
Thing & Location | CRUD | CRUD | R |   | CRUD | R | R
FOI, Sampling, Preparation | CRUD | CRUD | R |   | CRUD | CRUD | R
DataStream | CRUD | CRUD | R |   | CRUD | CRUD | R
Observation | CRUD | CRUD | R |   | CRUD | CRUD | R

- The admin user type has global Admin, Create, Read, Update and Delete rights.
- The Geotech Expert user type has global Create, Read, Update and Delete rights, and can thus create Observed Properties and access all data in the server, but not manage users.
- The Project user types do not have any global roles, only project-related roles.


## Demo Service

An example demo service can be found [here](https://ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1)

Base URL: https://ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1

There are several users to test with:
| Username | Password | Description |
|--|--|--|
| Bob | Bob | Project manager Project 1 |
| David | David | GeoTech expert |
| John | John | Global Admin |
| Kevin | Kevin | Member project 2 |
| Mary | Mary | Contributor Project 1, Manager Project 2 |
| Sam | Sam | Member Project 1, Contributor Project 2 |
| admin | admin | Global server admin |
| read | read | User with global read rights |
| write | write | User with global write rights (CRUD) |

To do a request with a given user, put `<username>:<password>@` before the server name. For instance:

- `https://Bob:Bob@ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1/Projects`
- `https://Kevin:Kevin@ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1/Projects`
