# ELIXIR Beacon v2 Network with Docker

This repository serves for deploying both Frontend and Backend with Docker.

## Deploy

Download the code from this [repository](https://github.com/elixir-europe/beacon-network-docker.git),

```
git clone https://github.com/elixir-europe/beacon-network-docker.git
cd beacon-network-docker
```

Please first create a .env file inside the frontend folder so that you can modify some variables. Take into account that the file below will not be copied to GitHub as it contains keys and for security reasons it should ignored: 

```bash
REACT_APP_CLIENT_ID="ID of your LS Login"
REACT_APP_CLIENT_SECRET="password of your LS Login"
REACT_APP_KEYCLOAK_CLIENT_SECRET="password of your Keycloak login"
REACT_APP_KEYCLOAK_CLIENT_ID='ID of your Keycloak login'
REACT_APP_KEYCLOAK_CLIENT_REALM='REALM of your Keycloak login'
```

You will need to have created your Life Science and Keycloak environments before.
Tip: for Life Science environment, please first [create a user](https://lifescience-ri.eu/ls-login/users/how-to-get-and-use-life-science-id.html) . After that you will need to register a service registry in order to be able to administrate your logins. Please go [here](https://services.aai.lifescience-ri.eu/spreg/) and ask for a New Service - type OIDC -.

Then please edit the file `config.json`, which can be found inside folder [frontend/](frontend/). You need to decide where you want the UI to point to when making requests. Find below an example:

 ```bash
{
   "API_URL": "https://yourAPIdomain.com/beacon-network/v2.0.0",
   "REDIRECT_URL": "https://yourUIdomain.com",
   "KEYCLOAK_URL": "https://yourKEYCLOAKdomain.com"
 }
```

Then, replace [http://localhost:8080/beacon-network/v2.0.0](http://localhost:8080/beacon-network/v2.0.0) and the other URLs with the appropriate URL where your backend is hosted.

Run [docker compose](https://docs.docker.com/compose/) to build and start the containers:

``` 
 docker compose up -d
```
 
Congrats! You have created Beacon Network FrontEnd in [http://localhost:8080/](http://localhost:8080/) and the backend in [http://localhost:8080/beacon-network/v2.0.0/](http://localhost:8080/beacon-network/v2.0.0/). Adjust the URLs based on your setup.


## Add/Remove Beacons from the network

You must add the Beacon's URL to the `wildfly/BEACON-INF/beacon-network.json` file. 

The structure of this JSON file should be an array containing the URL of the validated Beacon, like this:

```
[
	"your.beacon.url/api"
]
```

After adding the URL to the `beacon-network.json` file, the Beacon Network will automatically fetch the new Beacon, ensuring its integration into the network. This process facilitates the incorporation of Beacons into the ELIXIR Beacon Network.

To remove the Beacon, you just need to remove the URL from the `beacon-network.json` file. 

# Update the EBN

To update the ELIXIR Beacon Network (EBN) with a new image, follow these steps:
Pull the latest image:
```
docker-compose pull
```
Recreate and rebuild the containers with the new image:
```
docker-compose up --force-recreate --build -d
```
These commands will download the latest image for the EBN and recreate the containers using the new image. The `--force-recreate` flag ensures that the containers are recreated even if they are already running, and the `--build` flag rebuilds the containers if necessary. The `-d flag runs the containers in detached mode.
