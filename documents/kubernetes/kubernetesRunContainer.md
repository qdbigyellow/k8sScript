kubectl run :  launch a run the container on.
kubectl expose:  expose the service to external.


## Step 2 - Kubectl Run
The run command creates a deployment based on the parameters specified, such as the image or replicas. This deployment is issued to the Kubernetes master which launches the Pods and containers required. Kubectl run_ is similar to docker run but at a cluster level.

The format of the command is kubectl run <name of deployment> <properties>

### Task
**The following command will launch a deployment called http which will start a container** based on the Docker Image katacoda/docker-http-server:latest.

_kubectl run http --image=katacoda/docker-http-server:latest --replicas=1_

You can then use kubectl to view the status of the deployments
_kubectl get deployments_

To find out what Kubernetes created you can describe the deployment process.
_kubectl describe deployment http_

The description includes how many replicas are available, labels specified and the events associated with the deployment. These events will highlight any problems and errors that might have occurred.

In the next step we'll expose the running service.

## Step 3 - Kubectl Expose
With the deployment created, we can use kubectl to create a service which exposes the Pods on a particular port.

**Expose the newly deployed http deployment via kubectl expose. The command allows you to define the different parameters of the service and how to expose the deployment.**

### Task
Use the following command to expose the container port 80 on the host 8000 binding to the external-ip of the host.

_kubectl expose deployment http --external-ip="172.17.0.105" --port=8000 --target-port=80_

You will then be able to ping the host and see the result from the HTTP service.

curl http://172.17.0.105:8000

## Step 4 - Kubectl Run and Expose
With kubectl run it's possible to create the deployment and expose it as a single command.

Task
Use the command command to create a second http service exposed on port 8001.

_kubectl run httpexposed --image=katacoda/docker-http-server:latest --replicas=1 --port=80 --hostport=8001_

You should be able to access it using curl http://172.17.0.105:8001

Under the covers, this exposes the Pod via Docker Port Mapping. As a result, you will not see the service listed using kubectl get svc

To find the details you can use docker ps | grep httpexposed

Pause Containers
Running the above command you'll notice the ports are exposed on the Pod, not the http container itself. The Pause container is responsibility for defining the network for the Pod. Other containers in the pod use share the same network namespace. This improves network performance and allow multiple containers to communicate over the same network interface.

## Step 5 - Scale Containers
With our deployment running we can now use kubectl to scale the number of replicas.

**Scaling the deployment will request Kubernetes to launch additional Pods. These Pods will then automatically be load balanced using the exposed Service.**

### Task
The command kubectl scale allows us to adjust the number of Pods running for a particular deployment or replication controller.

_kubectl scale --replicas=3 deployment http_

Listing all the pods, you should see three running for the http deployment kubectl get pods

Once each Pod starts it will be added to the load balancer service. By describing the service you can view the endpoint and the associated Pods which are included.

kubectl describe svc http

Making requests to the service will request in different nodes processing the request.

curl http://172.17.0.105:8000