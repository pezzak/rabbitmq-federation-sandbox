#!/bin/sh

docker-compose exec rabbitmq2 rabbitmqctl set_parameter federation-upstream rabbitmq1-upstream '{"uri":"amqp://admin:admin@rabbitmq1"}'
docker-compose exec rabbitmq2 rabbitmqctl set_policy --apply-to queues federation-policy ".*" '{"federation-upstream-set":"all"}'

for i in $(seq 1 100); do docker-compose exec rabbitmq2 rabbitmqadmin -u admin -p admin declare queue name=q${i}; done
