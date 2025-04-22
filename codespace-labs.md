# Containers Fundamentals
## An overview of Containers, Docker, and Kubernetes
## Session labs 
## Revision 2.8 - 04/22/25

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

**Lab 2 - Composing images together**

**Purpose: In this lab, we'll see how to make multiple containers execute together with docker compose and use the docker inspect command to get information to see our running app.**
<br><br>

1. Take a look at the docker compose file for our application and see if you can understand some of what it is doing. Click on the link: [**roar-docker/docker-compose.yml**](./roar-docker/docker-compose.yml) 
<br>

2. Run the following command to compose the two images together that we built in lab 1.

```
docker compose up
```
<br>

3. You should see the different processes running to create the containers and start the application running. In order to do the following steps, we'll need to open a second terminal. We can do that by splitting this one. Either right-click and select *Split Terminal* or click on the two-panel icon near the trash can. See screenshot.

![Adding a second split terminal](./images/lab2s3.png?raw=true "Splitting the terminal")

<br>

4. Click in the second terminal and take a look at the running containers that resulted from the docker compose command by running the command below.

```
docker ps | grep roar
```

<br>

5. Make a note of the first 3 characters of the container id (first column) for the web container (row with roar-web in it). You’ll need those for the next lab.

![Container id for web container](./images/cazclass19.png?raw=true "Container id for web container")

<br>

6. Let’s see our application running from the containers and the compose. In the top "tab" line of the terminal, click on the *PORTS* tab. Per the docker-compose.yml file, our web app is running on port 8089. Find the row (probably the 2nd or 3rd row) with "8089" in the *Port* column. Under the second column *Forwarded Address*, click on the icon that looks like the splitter pane and, when you hover over it, says **Preview in Editor**. (See screenshot below.)
   
![Opening preview of app in editor](./images/lab2s5.png?raw=true "Opening preview app in editor")

<br>

7. After this, you should get a simple browser that opens up as a pane in the editor.

![Preview of server in editor](./images/lab2s6.png?raw=true "Preview of server in editor")

<br>

8. To see our app, we need to add **/roar/** to the end of the URL in that simple browser window. Do that now - you must have the trailing slash!

![App in editor](./images/lab2s7.png?raw=true "App in editor")   

<br>

9. You should see the running app in the window, though you may need to scroll around  or expand the window to see all of it.

![Full app](./images/lab2s8.png?raw=true "Full app")   

<br>

10. Switch back to the Terminal tab for the next lab.

<p align="center">
**[END OF LAB]**
</p>
</br></br></br>

**Lab 3 – Debugging Docker Containers**

**Purpose: While our app runs fine here, it’s helpful to know about a few commands that we can use to learn more about our containers if there are problems.**
<br><br>

1. (We're back in the second terminal with the compose still running in the first terminal.) Let’s get a description of all of the attributes of our containers. For these commands, use the same 3 character container id from the web container that you recorded from Lab 2, step 5 and run them in the second terminal window (the one that is not running the docker compose as that needs to stay running during these).
   
Run the inspect command. Take a moment to scroll around the output.

```
docker inspect <container id>
```
<br>

2. Now, let’s look at the logs from the running container. Scroll around again and look at the output.

```
docker logs <container id>
```

<br>

3. While we’re at it, let’s look at the history of the image (not the container).

```
docker history roar-web
```

<br>

4. Now, let’s suppose we wanted to take a look at the actual database that is
being used for the app. This is a mysql database but we don’t have mysql
installed on the VM. So how can we do that? Let’s connect into the container
and use the mysql version within the container. To do this we’ll use the “docker
exec” command. First find the container id of the db container.

```
docker ps | grep roar-db
```

<br>

5. Make a note of the first 3 characters of the container id (first column) for the db
container (row with **roar-db** in it). You’ll need those for the next step.

![Container id for db container](./images/cazclass20.png?raw=true "Container id for db container")
<br>

6. Now, let’s exec inside the container so we can look at the actual database.

```   
docker exec -it <container id> bash
```
Note that the last item on the command is the command we want to have
running when we get inside the container – in this case the bash shell.

<br>

7. Now, you’ll be inside the database container. Check where you are with the pwd
command and then let’s run the mysql command to connect to the database.
(Type these at the /# prompt. Note no spaces between the options -u and -p
and their arguments. You need only type the part in bold.)

```
root@container-id:/# pwd
root@container-id:/# mysql -uadmin -padmin registry
```

(Here -u and -p are the userid and password respectively and registry is the
database name.)

<br>

8. You should now be at the “mysql>” prompt. Run a couple of commands to
see what tables we have and what is in the database. (Just type the parts in
bold.)

```
mysql> show tables;
mysql> select * from agents;
```

<br>

9. Exit out of mysql and then out of the container.

```
mysql> exit
root@container-id:/# exit
```  

<br>

10. Let’s go ahead and push our images over to our local registry so they’ll be ready for Kubernetes to use.

```
docker push localhost:5000/roar-web:v1
docker push localhost:5000/roar-db:v1
```

<br>

11. Since we no longer need our docker containers running, let’s go ahead and get rid of them with the commands below.
(Hint: *docker ps | grep roar* will let you find the ids more easily)
Stop the containers

```
docker stop <container id for roar-web>
docker stop <container id for roar-db>
```

Remove the containers

```
docker rm <container id for roar-web>
docker rm <container id for roar-db>
```

<p align="center">
**[END OF LAB]**
</p>
</br></br></br>

**Lab 4 - Exploring and Deploying into Kubernetes**

**Purpose: In this lab, we’ll start to learn about Kubernetes and its object types,
such as nodes and namespaces. We’ll also deploy a version of our app that has
had Kubernetes yaml files created for it.**

<br><br>

**NOTE**: *If you get to this point and something may have gone wrong in previous labs such that the images are not in the local registry, there is a script you can run (**restore-images.sh**) to recreate the images and push them automatically. You only need to do this **IF something didn't go right with getting the images built or pushed in the previous labs** and you don't want to backtrack.*

<br><br>

1. Before we can deploy our application into Kubernetes, we need to have
appropriate Kubernetes manifest yaml files for the different types of k8s objects
we want to create. These can be separate files, or they can be combined. For
our project, there is a combined one (deployments and services for both the web
and db pieces) already setup for you in the k8s-dev/roar-k8s directory. 

Take a look at the yaml file there for the Kubernetes deployments and services. Click on the link: [**roar-k8s/roar-complete.yaml**](./roar-k8s/roar-complete.yaml) 
 
 See if you can identify the different services and deployments in the file.

 No changes need to be made.
 

<br>

2. We’re going to deploy these into Kubernetes into a namespace. Take a look at the current list of
namespaces and then let’s create a new namespace to use.

```
k get ns

k create ns roar
```

<br>

3. Now, let’s deploy our yaml specifications to Kubernetes. We will use the apply
command and the -f option to specify the file. (Note the -n option to specify our
new namespace.)

```
cd ../roar-k8s

k -n roar apply -f roar-complete.yaml
```

After you run these commands, you should see output like the following:
* deployment.extensions/roar-web created
* service/roar-web created
* deployment.extensions/mysql created
* service/mysql created

<br>

4.  Now, let’s look at the pods currently running in our “roar” namespace (and also see their labels).

```
k get pods -n roar --show-labels
```

Notice the STATUS field. What does the “ImagePullBackOff ” or “ErrImagePull” status mean?

<br>

5.  We need to investigate why this is happening. Let's set the default namespace to be 'roar' instead of 'default' so we don't have to pass *-n roar* all of the time.

```
k config set-context --current --namespace=roar
```

<br>

6. Now let's get a list of the pods that shows their labels so we can access them by
the label instead of having to try to copy and paste the pod name. (Note we don't
have to supply the -n argument any longer.)


```
k get pods --show-labels
```

<br>

7. Let's run a command to look at the logs for the database pod.

```
k logs -l app=roar-web
```

<br>

8. **The output here is the error message from the logs, not from running the command.** The message in the logs confirms what is wrong – notice the part on “trying and failing to
pull image” or "image can't be pulled". We need to get more detail though - such
as the exact image name. We could use a describe command, but there's a
shortcut using "get events" that we can do too.

```
k get events | grep web | grep image
```

<br>

9. Remember that we tagged the images for our local registry as localhost:5000/roar-db:v1 and localhost:5000/roar-web:v1. But if you scroll back up and look at the “Image” name in the output from step 8, you’ll see that it actually specifies “localhost:5000/roar-db-v1”.

<br>

10. We can change the existing deployment to see if this fixes things. But first, let's
setup a watch in a separate terminal so we can see how Kubernetes changes
things when we make a change to the configuration. 

<br>

11.  In an available terminal, run a command to start a `watch` of pods in the roar namespace. The watch will continue running until we stop it.  

```
k get -n roar pods -w
```

<br>

12. Go to the open roar-complete.yaml file (or open it again if needed [**roar-k8s/roar-complete.yaml**](./roar-k8s/roar-complete.yaml).

<br>

13. Change lines 19 and 70 to use **:v1** instead of **-v1** in the file. Save your changes using the keyboard shortcut (Ctrl/Cmd+S) or the 3-bar menu, File, Save. 

![Editing the file](./images/cazclass6.png?raw=true "Editing the file")
![Editing the file](./images/cazclass7.png?raw=true "Editing the file")

<br>

14. In the other terminal window, apply the updated manifest.

```
k config set-context --current --namespace=roar
cd ../roar-k8s (if needed)
k apply -f roar-complete.yaml
```
![Updating the pods](./images/cazclass8.png?raw=true "Updating the pods")

<br> 

15. Look back to the terminal session where you have the watch running. Eventually, (it may take a few minutes) you should
see a new pod finished creating and start running. The previous web pod will
be terminated and removed. You can stop the watch command in that terminal via Ctrl-C. 

<p align="center">
**[END OF LAB]**
</p>
</br></br></br>

**Lab 5 - Working with Kubernetes secrets and configmaps**

**Purpose:  In this lab we’ll get some practice storing secure and insecure information in a way that is accessible to k8s but not stored in the usual deployment files.**

<br><br>

1.	In the open file roar-complete.yaml from the last lab [**roar-k8s/roar-complete.yaml**](./roar-k8s/roar-complete.yaml), look at the "env" block that starts at line 61. We really shouldn't be exposing usernames and passwords in here.  

<br>

2.	Let’s explore two ways of managing environment variables like this so they are not exposed - Kubernetes “secrets” and “configmaps”. First, we'll look at what a default secret does by running the base64 encoding step on our two passwords that we’ll put into a secret.  Run these commands (the first encodes our base password and the second encodes our root password ).   

```
echo -n 'admin' | base64
```

This should yield:
  			        YWRtaW4=
Then do:

```
echo -n 'root+1' | base64
```

This should yield: 
  			       cm9vdCsx

<br>

3.  Now we need to put those in the form of a secrets manifest (yaml file for Kubernetes).  For convenience, there is already a “mysqlsecret.yaml” file in the same directory with this information.  Take a quick look at it via the link or selecting it in the file explorer to the left,
 select the file [**roar-k8s/mysql-secret.yaml**](./roar-k8s/mysql-secret.yaml) Now use the apply command to create the actual secret.

```
k apply -f mysql-secret.yaml
```

<br>

4.  Now that we have the secret created in the namespace, we need to update our spec to use the values from it.  You don't need to make any changes in this step, but the change will look like this:
       
```
FROM:  
- name: MYSQL_PASSWORD
      value: admin
    - name: MYSQL_ROOT_PASSWORD
      value: root+1
```

   

```   
TO:
- name: MYSQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: mysqlsecret
      key: mysqlpassword
-	name: MYSQL_ROOT_PASSWORD
   valueFrom:
     secretKeyRef:
       name: mysqlsecret
       key: mysqlrootpassword
```

<br>

5.  We also have the MYSQL_DATABASE and MYSQL_USER values that we probably shouldn’t expose in here.   Since these are not sensitive data, let’s put these into a Kubernetes ConfigMap and update the spec to use that.  For convenience, there is already a “mysql-configmap.yaml” file in the same directory with this information.  Take a quick look at it [**roar-k8s/mysql-configmap.yaml**](./roar-k8s/mysql-configmap.yaml) and then use the apply command to create the actual secret. 

```
k apply -f mysql-configmap.yaml
```

<br>

6.  Like the changes to use the secret, we would need to change the main yaml file to use the new configmap.  Again, you don't need to make any changes in this step, but that change would look like this:
        
```
FROM:   
-	name: MYSQL_DATABASE
         value: registry
```

   

```
TO:
    - name: MYSQL_DATABASE
         valueFrom:
           configMapKeyRef:
             name: mysql-configmap
             key: mysql.database
        And from:
        - name: MYSQL_USER
          value: admin
         to
 - name: MYSQL_USER
           valueFrom:
             configMapKeyRef:
               name: mysql-configmap
               key: mysql.user
```

<br>

7.  In the current directory, there’s already a *roar-complete.yaml.configmap* file with the changes in it for accessing the secret and the configmap.   Diff the two files with the code diff tool to see the differences.

```
code -d roar-complete.yaml.configmap roar-complete.yaml
```

<br>

8.  Now we’ll update our roar-complete.yaml file with the needed changes. To save trying to get the yaml all correct in a regular editor, we’ll just use the diff tool’s merging ability. In the diff window, between the two files, click the arrow that points right to replace the code in our roar-complete.yaml file with the new code from the roar-complete.yaml.configmap file.  (In the figure below, this is the arrow that is circled and labelled "1".) After that, the files should be identical and you can close the diff window (circled "2" in the figure below).

![Diff and merge in code](./images/k8sdev7.png?raw=true "Diffing and merging for secrets and configmaps")

<br>

9.  Apply the new version of the yaml file to make sure it is syntactically correct.

```
k apply -f roar-complete.yaml
```

<p align="center">
**[END OF LAB]**
</p>
</br></br></br>

**Lab 6 – Working with persistent storage – Kubernetes Persistent Volumes and Persistent Volume Claims**
**Purpose: In this lab, we’ll see how to connect pods with external storage resources via persistent volumes and persistent volume claims.**

<br><br>

1.	While we can modify the containers in pods running in the Kubernetes namespaces, we need to be able to persist data outside of them.  This is because we don’t want the data to go away when something happens to the pod.   Let’s take a quick look at how volatile data is when just stored in the pod.

<br>

2.	Start up another session of our application running with the following command:

```
kubectl port-forward -n roar svc/roar-web 8089 &
```

<br>

3. In the popup that results about "Your applicaton running on port 8089 is available", click on **Open in Browser**.

![Port pop-up](./images/cazclass9.png?raw=true "Port pop-up")

<br>

4. In the resulting tab, add **/roar/** (be sure to include the trailing slash) and you should see the running app.

![Running app](./images/cazclass10.png?raw=true "Running app")

<br>

5.	There is a very simple script in our roar-k8s directory that we can run to insert a record into the database in our mysql pod.  If you want, you can  take a look at the file update-db.sh to see what it’s doing. Run it, refresh the browser, and see if the additional record shows up.  (Make sure to pass in the namespace – “roar” and don’t forget to refresh the browser afterwards.)  You can ignore the warnings.

```
./update-db.sh <namespace> (such as ./update-db.sh roar)
```

<br>

6.	Refresh the browser and you should see a record for “Woody Woodpecker” in the table. Now, what happens if we delete the mysql pod and let Kubernetes recreate it?   

```
k delete pod -l app=roar-db
```

<br>

7.	After a moment, a new mysql pod will be started up. When that happens, refresh the browser and notice that the record we added for “Woody Woodpecker” is no longer there.  It disappeared when the pod went away.  

<br>

8.	This happened because the data was all contained within the pod’s filesystem. In order to make this work better, we need to define a persistent volume (PV) and persistent volume claim (PVC) for the deployment to use/mount that is outside of the pod.   As with other objects in Kubernetes, we first define the yaml that defines the PV and PVC.  The file [**roar-k8s/storage.yaml**](./roar-k8s/storage.yaml) defines these for us.  Take a look at it now. 

<br>

9.	Now create the objects specified here. After this runs, you should see notices that the persistent volume and claim were created.

```
k apply -f storage.yaml
```

<br>

10.	Now that we have the storage objects instantiated in the namespace, we need to update our spec to use the values from it.  In the file the change would be to add the lines in bold in the container’s spec area (**you do not need to make changes for this step**):

```
         spec:
           containers:
           - name: mysql
       …
  - name: MYSQL_USER
    valueFrom:
      configMapKeyRef:
        name: mysql-configmap
        key: mysql.user
volumeMounts:
- mountPath: /var/lib/mysql
  name: mysql-pv-claim
        volumes:
        - name: mysql-pv-claim
          persistentVolumeClaim:
            claimName: mysql-pv-claim
```

<br>

11.  In the current directory, there’s already a *roar-complete.yaml.pv* file with the changes in it for accessing the secret and the configmap.   Diff the two files with the code diff tool to see the differences.

```
code -d roar-complete.yaml.pv roar-complete.yaml
```

<br>

12.  Now we’ll update our roar-complete.yaml file with the needed changes. To save trying to get the yaml all correct in a regular editor, we’ll just use the diff tool’s merging ability. In the diff window, between the two files, click the arrow that points right to replace the code in our roar-complete.yaml file with the new code from the roar-complete.yaml.pv file.  (In the figure below, this is the arrow that is circled and labelled "1".) After that, the files should be identical and you can close the diff window (circled "2" in the figure below).

![Diff and merge in code](./images/k8sdev9.png?raw=true "Diffing and merging for storage")

<br>

13.	 Apply the new version of the yaml file to make sure it is syntactically correct.

```
k apply -f roar-complete.yaml
```

<br>

14.	 Add the extra record again into the database. (Note you may have to try this a couple of times as it will take a bit for the pod to start up again.)

```
./update-db.sh <namespace>
```

 (such as ./update-db.sh roar)

<br>

15.	 Refresh the browser to force data to be written out the disk location.

<br>

16.	Repeat the step to kill off the current mysql pod.

```
k delete pod -l app=roar-db
```

<br>

17.	After it is recreated,  refresh the screen and notice that the new record is still there!

<br>

18.	In preparation for the next lab, reset the default namespace back to *default* instead of *roar*.

```
k config set-context --current --namespace=default
```

<p align="center">
**[END OF LAB]**
</p>
</br></br></br>

**Lab 7 – Configuring namespace access for service accounts with RBAC**
**Purpose: In this lab, we’ll see how to create a new service account and give it permissions in the cluster via RBAC.**

<br><br>

1.	Let's create a new service account in the codespace to use in demonstrating how RBAC works.

```
k create serviceaccount cs-user
```

<br>

2. Now, we need to create an authorization token for the new service account. We can use a K8s command to dump this into an environment variable. After creating it, you can look at the token if you wish.

```
TOKEN=$(k create token cs-user)
echo $TOKEN
```

<br>

3. Add a new kubectl context that lets you authenticate as the service account. First, add the service account as a credential in the Kubeconfig file.

```
k config set-credentials cs-user --token=$TOKEN
```

<br>

4. Next, add a new context (that we can set with the new service account automatically) to the ones Kubernetes knows and can use.

```
k config set-context cs-user-context --cluster=minikube --user=cs-user
```

<br>

5. Switch to the new context that authenticates as your service account.

```
k config use-context cs-user-context
```

<br>

6. See if we can use the new service account by trying to list the pods in the *default* namespace.  

```
k get pods 
```

<br>

7. You should see a *Forbidden* error because your service account hasn't been assigned any RBAC roles that include the *get pods* permission. After the command fails, switch back to your original context (second command) to create the role and rolebinding objects we'll need in the remaining steps.

```
k config use-context minikube
```

<br>

8. We need to have the corresponding role for our *cs-role* service account. The role manifest has a *rules* field which lists the API groups, resource types, and verbs that holders of the role can use. The manifest is already created for you. You can open it and take a look at its contents by clicking on [**roar-k8s/role.yaml**](./roar-k8s/role.yaml) or using the command below. After you are done looking at it, go ahead and apply it.

```
code role.yaml
k apply -f role.yaml
```

<br>

9. We also need to have the corresponding manifest to do the *role binding* - connecting the role to the service account. The manifest is already created for you. You can open it and take a look at its contents by clicking on [**roar-k8s/role-binding.yaml**](./roar-k8s/role-binding.yaml) or using the command below. After you are done looking at it, go ahead and apply it.

```
code role-binding.yaml
k apply -f role-binding.yaml
```

<br>

10. With the role and role binding in place, the service account should now be able to interact with the pods in the *default* namespace. Switch back to the context that authenticates as the service account user.

```
k config use-context cs-user-context
```

<br>

11. Now you can try the command again to get the pods. Note that success here is NOT getting an error/forbidden message.

```
k get pods
```

<br>

12. In preparation for the next lab, switch back to the minikube context!

```
k config use-context minikube
```

<p align="center">
**[END OF LAB]**
</p>
<br><br><br>

**Bonus/Optional Lab 8 - Monitoring**

**Purpose:  This lab will introduce you to a few of the ways we can monitor what is happening in our Kubernetes cluster and objects.**

<br><br>

1. In order to have the pieces setup for this lab, change to the *monitoring* directory.

```
cd /workspaces/containers/monitoring
```

<br>

2.	 To setup the monitoring pieces in the cluster, run the script *setup-monitoring.sh*. This will take a bit to complete.

```
./setup-monitoring.sh
```

<br> 

3.	First, let’s look at the built-in Kubernetes dashboard. You  can use a simple port-forward to access but then we will need to make one tweak for the port. First do the port forward.

```
k port-forward -n kubernetes-dashboard svc/kubernetes-dashboard :443 &
```

<br>

4.	If you look at this in the browser, it will have an error. To fix this, go to the PORTS tab, right-click on the line with "kubernetes-dashboard" in it, click "Change Port Protocol" from the popup menu and then select "HTTPS" from the options. Refresh the browser and you should be able to see the application.

![changing port protocol](./images/k8sdev20.png?raw=true "Changing the Port Protocol")

<br>

5.	In the browser, you'll see a login screen.  We'll use the token option to get in.  Switch back to the TERMINAL tab and run the command below and then copy the output.

```
k -n kubernetes-dashboard create token admin-user
```

<br>

6.	At the login screen, select "Token" as the access method, and paste the token you got from the step above.

![logging in to the dashboard](./images/k8sdev22.png?raw=true "Logging in to the dashboard")   
 
<br>

7.	The dashboard for our cluster will now show. You'll probably first see a "404" message. This is because you don't have Kubernetes objects selected to look at.  You can select "All namespaces" at the top, choose a K8s objects on the left (such as "Pods"), and explore.

![working in the dashboard](./images/k8sdev21.png?raw=true "Working in the dashboard")

<br> 

8.	Now let’s look at some metrics gathering with a tool called Prometheus. First, we will do a port-forward to access the Prometheus UI in our browser.

```
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus :9090 &
```

<br>

9.	Open this in the browser via the port button. You should see a screen like the one below:

![prometheus opening screen](./images/k8sdev23.png?raw=true "Prometheus opening screen")

<br>

10.	Prometheus comes with a set of built-in metrics.  Just start typing in the “Expression” box.  For example, let’s look at one called “apiserver_request_total”.  Just start typing that in the Expression box. After you begin typing, you can select it in the list that pops up. After you have got it in the box, click on the blue “Execute” button.

![prometheus metrics entry](./images/k8sdev24.png?raw=true "Prometheus metrics entry") 

<br>

11.	Now, scroll down and look at the "Table" list output (assuming you have the Table tab selected).

![prometheus console output](./images/k8sdev25.png?raw=true "Prometheus console output")

<br>

12.	Next, click on the blue “Graph” link next to “Console” and take a look at the graph of responses.  Note that you can hover over points on the graph to get more details. You can click "Execute" again to refresh.

![prometheus graph view](./images/k8sdev26.png?raw=true "Prometheus graph view")

<br> 

13.	You can also see the metrics being automatically exported for the node. Do a port forward on the node-exporter service and then open via the port as usual.

```

kubectl port-forward -n monitoring svc/monitoring-prometheus-node-exporter 9100 &

```
Click on the **Metrics** link.

![metrics view](./images/cazclass18.png?raw=true "Metrics view")

<br>

14.	 Now let’s change the query to show the rate of apiserver total requests over 1 minute intervals.  Go back to the main Prometheus screen.  In the query entry area, change the text to be what is below and then click on the Execute button to see the results in the graph.

```

rate(apiserver_request_total[1m])

```
![prometheus rate query](./images/k8sdev27.png?raw=true "Prometheus rate query")

<br>

15.	Finally, let’s take a look at Grafana. First you need to get the default Grafana password. You can get that by running the *./get-grafana-initial-pw.sh* script in the *monitoring* directory.

<br>

16.	 Then you can do a port forward for the "monitoring-grafana" service.  

```

k port-forward -n monitoring svc/monitoring-grafana :80  & 

```

<br>

17.	Go to the browser tab. Login with username *admin* and the initial password (*prom-operator*).

![grafana login](./images/k8sdev28.png?raw=true "Grafana login")

<br>

18.	  Click on the magnifying glass for "search” (left red circle in figure below). This will provide you with a list of built-in graphs you can click on as demos and explore.

![grafana search](./images/k8sdev29.png?raw=true "Grafana search")  

<br>

19.	 Click on one of the links to view one of the demo graphs (such as the "Kubernetes / API server" one) shown in the figure below). You can then explore others by discarding/saving this one and going back to the list and selecting others.

![grafana demo graph](./images/k8sdev29.png?raw=true "Grafana demo graph") 

<p align="center">
**[END OF LAB]**
</p>


<p align="center">
(c) 2025 Brent Laster and Tech Skills Transformations
</p>
