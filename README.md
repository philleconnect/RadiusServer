__Archived: Not actively maintained anymore!__

# Radius-Server for WiFi-Authentication

This optional container connects to the LDAP-Server and provides radius user authentication for your WiFi.

THIS IS STILL IN BETA STATE! All seems to be working so far, but some testing is still needed...

## Usage

You need to have the main ServerContainers running (at least the ldap-Server).

In the folder above the `ServerContainers`-folder execute

```
git clone https://github.com/philleconnect/RadiusServer
```

to get the build-sources. Edit the file `settings.env` according to your main `settings.env`-file and to your needs (passwords!). For testing pourposes the defaults are just fine.

Then execute

```
docker-compose up -d
```

to build and lauch the container. It will be integrated into the virtual network of your PhilleConnect-Installation.

## Configure your WiFi-access-points

In your WiFi-security-settings choose `WPA2-Enterprise`, enter the IP of your Dockerhost, enter the Port `1812` and your password you set in your `settings.env` (default is `testing123`).

## Connect to your WiFi

You need the following selections:

* Auth-Type `EAP / PEAP`
* Encryption type `TKIP`
* Inner authentication protocol `GTC` (On Windows 7 the driver software from your manufacturer most likely brings this option, as Microsoft still tried to spread it's own, proprietary standard with Windows 7)
* Accept all certificates/don't check certificate/import the offered certificate, depending on your Device and OS
* Username and Password according to your PhilleConnect Login
* eventually you need to set a 'Roaming-identity' to your PhilleConnect-Username as well
