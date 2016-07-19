Tutorial preparation
================================================================================
- Build your desired image (e.g. `thomega/whizard-trunk` or `thomega/whizard-2.2.7`)
  with make (`sudo make trunk` or `sudo make whizard`).

- Fire it up with `docker run -it thomega/whizard-trunk`

- You can *mount* folders with the
  `-v /folder/on/host:/home/whizard/folder/on/guest` option for `docker run`
  (absolute paths required)

- Put the container in the state you want it to be for the students (e.g. copy
  files from `/home/whizard/mounted` to `/home/whizard/tutorial` to make them
  persistent when we save the container)

- Use a different terminal on the host to commit the running container to an
  image, e.g. with
  `docker commit `docker ps | grep ago | awk '{print $1}' | head -n1` tutorial`

- Save this image with `docker save -o tutorial.tar` tutorial

- Optionally run `gzip < tutorial.tar > tutorial.tar.gz` for smaller
  distribution file (1/3 in size is easily possible)

Running
================================================================================
- For importing on any machine with docker installed, just use
  `docker load < tutorial.tar`

- Students can further *mount* folders with the
  `-v /folder/on/host:/home/whizard/folder/on/guest` option for `docker run`.
  Possible issues can be file permissions.

- **Care**: Files that are created outside of mounted volumes or
  [data volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/)
  are gone when you exit the container and create a new container from the
  image with `docker run`
