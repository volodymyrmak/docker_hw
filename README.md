# How to use

## 1. Build an image from Dockerfile:

``` bash
~$ cd /path/to/Dockerfile
~$ sudo docker image build -t <desired_image_name> ./
```

## 2. Create a custom bridge network:

``` bash
~$ sudo docker network create <custom_network_name>
```

## 3. Run containers within this network:

```bash
~$ sudo docker run --detach --name <container_name> -v $(pwd):/home/network/bind_point --network <network_name> --publish 80 <image_name> tail -f /dev/null
```

`Note: "tail -f /dev/null" is a doing nothing loop (using minimal resources) that makes Alpina container run indefinitely, to be able to run the network scripts.`

## 4. Access containers CLI

```bash
~$ sudo docker container exec -it <container_name> sh
```

## 5. Run simple TCP server and client:

### my_network_alpine21:

``` bash
cd $BIND_POINT
./server.sh <some_port>
```

### my_network_alpine22:

``` bash
cd $BIND_POINT
./client.sh <some_port>
```

Then we can easily communicate between the created containers using CLI:

![Tmux containers screenshot](<tmux_containers_img.png>)
