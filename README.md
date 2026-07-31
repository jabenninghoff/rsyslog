# rsyslog

[rsyslog](https://www.rsyslog.com) Docker image based on [Alpine Linux](https://alpinelinux.org). Implemented as an alternative to the official rsyslog [image](https://hub.docker.com/r/rsyslog/rsyslog), which uses Ubuntu and only offers Intel (`amd64`) images.

Based on [nasmail](https://github.com/jabenninghoff/nasmail).

## Docker Image

rsyslog uses GitHub Actions to build and publish a Docker image to the GitHub Container Registry, using design, automation, and tests based on nasmail. The included `compose.yaml` file can be adapted to deploy the container using `docker compose`.

Pull the latest (stable) image using:

```sh
docker pull ghcr.io/jabenninghoff/rsyslog
```

New images are published for each new release only; there are no development images (`edge` or `main`). All pull requests and merges to main build and load the image (without publishing) for testing and validation. Images are built for Intel (`amd64`), 64-bit ARM (`arm64`: Apple, Raspberry Pi) and 32-bit ARM (`arm/v6`, `arm/v7`: older Raspberry Pi hardware).

Make sure to update the `image` section of the `compose.yaml`, a complete production file should resemble:

```yaml
services:
  rsyslog:
    image: ghcr.io/jabenninghoff/rsyslog:<version>
    restart: unless-stopped
    hostname: rsyslog.test
    ports:
      - "514:514" # syslog
    volumes:
      - ./log:/var/log
    environment:
      - TZ=UTC
```

## Environment Variables

- `TZ`: Time Zone, used by rsyslogd, defaults to `UTC`.

## Tests

rsyslog has one test suite:

`image-tests.sh` runs the following tests, which require a locally built docker image using `docker-build.sh`:

- `apk-list.sh`: errors if installed `apk` packages have changed
- `rsyslog-defaults.sh`: errors if the rsyslog default configuration has changed
- `startup.sh`: starts a rsyslog container and immediately exits
- `docker-header.sh`: places the Dockerfile version header on the clipboard
- `apk-upgrade.sh`: errors if updated `apk` packages are available

After the image tests pass, the version header can be pasted in the `Dockerfile` (for changes).

The full Docker Compose test environment uses dnsmasq to redirect `.local` to localhost (127.0.0.1).
