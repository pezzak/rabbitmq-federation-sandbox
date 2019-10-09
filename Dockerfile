FROM rabbitmq:3.7-management

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -q iproute2

RUN rabbitmq-plugins enable --offline rabbitmq_federation_management
