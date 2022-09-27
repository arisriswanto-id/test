ARG NGINX_VERSION=mainline

FROM nginx:${NGINX_VERSION}

ARG NGINX_CONF_TEMPLATE=default.template.conf
COPY ./templates/${NGINX_CONF_TEMPLATE} /etc/nginx/templates/default.conf.template

EXPOSE 80/tcp