# Environment to reproduce the problem with rabbitmq federation plugin

The problem described here: https://groups.google.com/forum/#!searchin/rabbitmq-users/federation%7Csort:date/rabbitmq-users/VmMnp2pIBvE/9YgM9clDBwAJ

1. Start containers:
```
docker-compose up -d
```
2. Wait for rabbitmq start
3. Setup federation and create some queues:
```
./setup_federation.sh
```
4. Check federation status at http://localhost:15673/#/federation
5. Grab rabbitmq1 container ip:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rabbitmq_federation_test_1
```
6. Simulate network failure:
```
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem -t %IP_FROM_STEP_5% -d 10m loss -p 100 rabbitmq_federation_test_2
```
7. Check increased count of erlang processes and memory usage: http://localhost:15673 at overview page