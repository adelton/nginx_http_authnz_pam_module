FROM registry.fedoraproject.org/fedora
RUN dnf install -y gcc pcre-devel zlib-devel make pam-devel patch && dnf clean all
RUN mkdir /src
WORKDIR /src
RUN curl -O http://nginx.org/download/nginx-1.15.8.tar.gz
RUN tar xzf nginx-*.tar.gz
RUN ln -s nginx-*/. nginx
COPY ngx_http_authnz_pam_module.c config tests/build.sh /src/
RUN ./build.sh
COPY tests /src/tests
RUN tests/config.sh
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
