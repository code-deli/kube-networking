on master

1. kubectl cluster-info

2. kubectl get nodes

3. kubectl create deployment hello-world --image=gcr.io/google-samples/hello-app:1.0

4. kubectl get deployments

5. kubectl get pods

6. kubectl get pods -o wide

7. kubectl scale deployments/hello-world --replicas=2

8. kubectl get pods 

9. kubectl expose deployment hello-world --port=8080 --target-port=8080 --type=NodePort
   ..  service/hello-world exposed

10. kubectl get services    

NAME          TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE     SELECTOR
hello-world   NodePort    10.102.68.35   <none>        8080:31488/TCP   2m41s   app=hello-world
kubernetes    ClusterIP   10.96.0.1      <none>        443/TCP          46m     <none>

NodePort    10.102.68.35
[vagrant@kube-master ~]$ curl 10.102.68.35:8080
Hello, world!
Version: 1.0.0
Hostname: hello-world-75b9d468b8-flht8

11. [vagrant@kube-master ~]$ kubectl get pods -o wide
NAME                           READY   STATUS    RESTARTS   AGE     IP            NODE         NOMINATED NODE   READINESS GATES
hello-world-75b9d468b8-flht8   1/1     Running   0          5m37s   172.16.9.66   kube-node1   <none>           <none>
hello-world-75b9d468b8-p9ztx   1/1     Running   0          8m54s   172.16.9.65   kube-node1   <none>           <none>

curl 172.16.9.66:8080
curl 172.16.9.65:8080