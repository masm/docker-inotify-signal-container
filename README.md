# docker-inotify-signal-container

> Send signals to processes running in other containers

## Install

Pull this image with `docker pull masm/inotify-signal-container`.

## Usage

You need to bind mount `/var/run/docker.sock` as shown in the example below.
You also need to pass at least three arguments (in order):
* the target container id or name;
* the signal to send to the target container;
* one or more files or folders to watch for changes.

### Example

You want to reload Nginx when configuration changes.
You keep the configuration in a volume container with name `nginx-conf-volume`, at `/nginx-conf.d`.
Nginx container is `nginx-server` and you have some other container updating the configuration files.

To reload Nginx when configuration changes:

```
docker run \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       --volumes-from nginx-conf-volume \
       masm/inotify-signal-container nginx-server SIGHUP /nginx-conf.d
```

## License

Copyright (c) 2015 Marco Monteiro. Released under the MIT license. See `LICENSE` file for details.
