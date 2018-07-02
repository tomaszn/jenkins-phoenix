# Jenkins Phoenix Deployment

CI as code.

[Phoenix](http://www.slideshare.net/IanMiell/clipboards/my-clips) [Deployment](https://www.thoughtworks.com/radar/tools/immutable-servers): Never worry about how your environment was built again, because you do it routinely.

Modifications overview by @tomaszn:
* `docker-compose.yml` is written to work with Docker Swarm, and number of slaves is configurable
* Jenkins is updated to a newer version, and the list of plugins is modified (e.g. includes Blue Ocean)

`jenkinsslave1` configuration:
* configured for Django-based webapp UI testing with Selenium WebDriver
* they share one PostGIS database engine (use separate databases for each slave)
* they connect to `ANOTHER_SSH_HOST` with `ANOTHER_SSH_PASS` and configure simple key based authentication; useful for accessing private resources (like Git repositories)

Be sure to check out my commits.

## Intro

See [here](https://zwischenzugs.wordpress.com/2016/01/24/ci-as-code-stateless-jenkins-deployments-using-docker/) for an explanation.

## Running

```
docker-compose up
```

or

```
./phoenix.sh
```

Then - once the dust has settled - navigate to http://localhost:8080
