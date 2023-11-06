# FROST-Server.Plugin.GeoTech
A FROST-Server Plugin extending the SensorThings data model with a GeoTech borehole data model

## Settings

See the [scripts/docker-compose.yaml](scripts/docker-compose.yaml) for examples.

## Data Model

![Data Model](Datamodel-SensorThingsApi-GeoTech.drawio.png)

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



The rights for the different users:

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




To do a request with a given user, put `<username>:<password>@` before the server name. For instance:

- `https://Bob:Bob@ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1/Projects`
- `https://Kevin:Kevin@ogc-demo.k8s.ilt-dmz.iosb.fraunhofer.de/FROST-GeoTech/v1.1/Projects`
