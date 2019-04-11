
### Create deployment and service.

* Create a deployment:  
  kubectl run _deploymentname_ --image=_imagename_ --replicas=_x_
* Expose as service:  
  kubectl export deployment _deploymentname_ --external-ip=_ipaddr_ port=_port_ --target-port=_port_
  
  It is possible to write in one line:  
  kubectl run _new__deploymentname_ --image=_imagename_ --replicas=_x_ port=_port_ --target-port=_port_

  BUT, this exposes the Pod via Docker Port Mapping, as the result, the _new__deploymentname_  is not listed using `kubectl get svc`