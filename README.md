# Canon A510 Webcam on Linux using gphoto2

![Canon A510](canon-a510.jpg)

# Getting Started
It works in any Linux distribution (I tested it out on Ubuntu and Arch Linux so far). In order for this script to work we need to install the following dependencies:

- [gphoto2](http://www.gphoto.org/)
- [libgphoto2](https://github.com/gphoto/libgphoto2?tab=readme-ov-file)
- [ffmpeg](https://ffmpeg.org/)

You can install them with:

```sh
sudo apt install ffmpeg
sudo apt install gphoto2
sudo apt install libgphoto2-6
sudo apt install libgphoto2-dev
```
The camera Canon Powershot A510 is not detected as a video device on linux, not even with [gphoto2](http://www.gphoto.org/) or [webcamize](https://github.com/cowtoolz/webcamize). To list video devices:

```sh
ls /dev/video*
```
You should see something like this:
```sh
# output
/dev/video0 
/dev/video1
```
But the Canon Powershot A510 doesn't support this, so in order to capture this device in "real time" I used the following configuration I found in man gphoto2 my camera can handle:

```sh
--capture-movie SECONDS
    Capture a movie. If the camera supports previews, this will capture a stream of previews (motion-jpeg) as fast as the camera can.
    If not argument is specified, it will capture preview frames until you press Ctrl-C. Arguments that can be specified are either seconds of capture or number of preview frames.
```