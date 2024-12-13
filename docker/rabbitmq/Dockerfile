FROM rabbitmq:3.10.7-management
WORKDIR '/app'
COPY rabbitmq_delayed_message_exchange-3.10.2.ez /tmp/rabbitmq_delayed_message_exchange-3.10.2.ez
RUN cp /tmp/rabbitmq_delayed_message_exchange-3.10.2.ez /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-3.10.2.ez && rabbitmq-plugins enable rabbitmq_delayed_message_exchange
