# Containers Fundamentals
## An overview of Containers, Docker, and Kubernetes
## Session labs 
## Revision 2.10 - 04/22/25

**NOTES**
1. Startup IF NOT ALREADY DONE!
```
./setup.sh
```
2. Adjust codespace timeout via README instructions. If your codespace does time out, just run the *setup.sh* script again after restarting it.

3. To copy and paste in the codespace, Chrome is recommended. You may need to use keyboard commands - CTRL-C and CTRL-V.**

<br><br>

**Lab 1 - Building Docker Images**

**Purpose: In this lab, we’ll see how to build Docker images from Dockerfiles.**
<br><br>

1. Switch into the directory for our docker work.

```
cd roar-docker
```
<br>

2. Take a look at the "Dockerfiles" that we have in this directory and see if you can understand what's happening in them. 

   a. Click on the link or, in the file explorer to the left, select the file [**roar-docker/Dockerfile_roar_db_image**](./roar-docker/Dockerfile_roar_db_image)
   
   b. Click on the link or, in the file explorer to the left, select the file [**roar-docker/Dockerfile_roar_web_image**](./roar-docker/Dockerfile_roar_web_image) 

<br>

3. Now let’s build our docker database image. Type (or copy/paste) the following
command: (Note that there is a space followed by a dot at the end of the
command that must be there.)

```
docker build -f Dockerfile_roar_db_image -t roar-db .
```

<br>

4. Next build the image for the web piece. This command is similar except it
takes a build argument that is the war file in the directory that contains our
previously built webapp.

(Note the space and dot at the end again.)

```
docker build -f Dockerfile_roar_web_image --build-arg warFile=roar.war -t roar-web .
```

<br>

5. Now, let’s tag our two images for our local registry (running on localhost, port
5000). We’ll give them a tag of “v1” as opposed to the default tag that Docker
provides of “latest”.

```
docker tag roar-web localhost:5000/roar-web:v1
docker tag roar-db localhost:5000/roar-db:v1
```

<br>

6. Do a docker images command to see the new images you’ve created.
```
docker images | grep roar
```
<p align="center">
**[END OF LAB]**
</p>
</br></br></br>
