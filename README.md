Tengine
=======

Docker image with tengine(nginx)  service. 




####测试
```sh
$ sudo docker run -d -P nginx:albb
ff4650e77c53b174a10b4cd29533deffad889458f88d98c4443ac3654b01552a
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                                                  NAMES
ff4650e77c53        nginx:albb          "/run.sh"           3 seconds ago       Up 2 seconds        0.0.0.0:49194->443/tcp, 0.0.0.0:49195->80/tcp, 0.0.0.0:49196->22/tcp   furious_wright
08c456536e69        nginx:stable        "/run.sh"           13 minutes ago      Up 13 minutes       0.0.0.0:49191->22/tcp, 0.0.0.0:49192->443/tcp, 0.0.0.0:49193->80/tcp   romantic_curie
ffd58545b787        apache:ubuntu       "/run.sh"           About an hour ago   Up About an hour    0.0.0.0:49177->22/tcp, 0.0.0.0:49178->80/tcp                           jovial_galileo
$ curl 127.0.0.1:49195
```
返回的内容是阿里巴巴版本的 nginx 特有的。
```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to tengine!</title>
<style>
    body {
                width: 35em;
                               margin: 0 auto;
                                               font-family: Tahoma, Verdana, Arial, sans-serif;
                                                   }
</style>
</head>
<body>
<h1>Welcome to tengine!</h1>
<p>If you see this page, the tengine web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://tengine.taobao.org/">tengine.taobao.org</a>.</p>

<p><em>Thank you for using tengine.</em></p>
</body>
</html>

```
####进入容器查看创建的容器信息
使用 docker 1.3 版本新特性进入容器，查看我们建立容器后默认运行的进程，查看默认映射的端口。
```sh
$ sudo docker exec -ti ff4 /bin/bash
root@ff4650e77c53:/etc/nginx# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 15:09 ?        00:00:00 /bin/bash /run.sh
root        11     1  0 15:09 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       12    11  0 15:09 ?        00:00:00 nginx: worker process
root        13     1  0 15:09 ?        00:00:00 /usr/sbin/sshd
root        14     0  1 15:09 ?        00:00:00 /bin/bash
root        23    14  0 15:09 ?        00:00:00 ps -ef
root@ff4650e77c53:/etc/nginx# netstat -tunlp
Active Internet connections (only servers)
        Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
        tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -
        tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
        tcp6       0      0 :::22                   :::*                    LISTEN      -
        ```
        查看阿里巴巴版本的 nginx 的编译参数和模块特性
        ```sh
        root@ff4650e77c53:/etc/nginx# nginx -V
        Tengine version: Tengine/2.0.3 (nginx/1.6.1)
        built by gcc 4.8.2 (Ubuntu 4.8.2-19ubuntu1)
        TLS SNI support enabled
        configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-mail --with-mail_ssl_module --with-file-aio --with-http_spdy_module --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' --with-ipv6
        loaded modules:
            ngx_core_module (static)
            ngx_errlog_module (static)
            ngx_conf_module (static)
            ngx_dso_module (static)
            ngx_syslog_module (static)
            ngx_events_module (static)
            ngx_event_core_module (static)
            ngx_epoll_module (static)
            ngx_procs_module (static)
            ngx_proc_core_module (static)
            ngx_openssl_module (static)
            ngx_regex_module (static)
            ngx_http_module (static)
            ngx_http_core_module (static)
            ngx_http_log_module (static)
            ngx_http_upstream_module (static)
            ngx_http_spdy_module (static)
            ngx_http_static_module (static)
            ngx_http_gzip_static_module (static)
            ngx_http_dav_module (static)
            ngx_http_autoindex_module (static)
            ngx_http_index_module (static)
            ngx_http_random_index_module (static)
            ngx_http_auth_basic_module (static)
            ngx_http_access_module (static)
            ngx_http_limit_conn_module (static)
            ngx_http_limit_req_module (static)
            ngx_http_realip_module (static)
            ngx_http_geo_module (static)
            ngx_http_map_module (static)
            ngx_http_split_clients_module (static)
            ngx_http_referer_module (static)
            ngx_http_rewrite_module (static)
            ngx_http_ssl_module (static)
            ngx_http_proxy_module (static)
            ngx_http_fastcgi_module (static)
            ngx_http_uwsgi_module (static)
            ngx_http_scgi_module (static)
            ngx_http_memcached_module (static)
            ngx_http_empty_gif_module (static)
            ngx_http_browser_module (static)
            ngx_http_user_agent_module (static)
            ngx_http_secure_link_module (static)
            ngx_http_flv_module (static)
            ngx_http_mp4_module (static)
            ngx_http_upstream_ip_hash_module (static)
            ngx_http_upstream_consistent_hash_module (static)
            ngx_http_upstream_check_module (static)
            ngx_http_upstream_least_conn_module (static)
            ngx_http_reqstat_module (static)
            ngx_http_upstream_keepalive_module (static)
            ngx_http_upstream_dynamic_module (static)
            ngx_http_stub_status_module (static)
            ngx_http_write_filter_module (static)
            ngx_http_header_filter_module (static)
            ngx_http_chunked_filter_module (static)
            ngx_http_spdy_filter_module (static)
            ngx_http_range_header_filter_module (static)
            ngx_http_gzip_filter_module (static)
            ngx_http_postpone_filter_module (static)
            ngx_http_ssi_filter_module (static)
            ngx_http_charset_filter_module (static)
            ngx_http_sub_filter_module (static)
            ngx_http_addition_filter_module (static)
            ngx_http_gunzip_filter_module (static)
            ngx_http_userid_filter_module (static)
            ngx_http_footer_filter_module (static)
            ngx_http_trim_filter_module (static)
            ngx_http_headers_filter_module (static)
            ngx_http_upstream_session_sticky_module (static)
            ngx_http_copy_filter_module (static)
            ngx_http_range_body_filter_module (static)
            ngx_http_not_modified_filter_module (static)
            ngx_mail_module (static)
            ngx_mail_core_module (static)
            ngx_mail_ssl_module (static)
            ngx_mail_pop3_module (static)
            ngx_mail_imap_module (static)
            ngx_mail_smtp_module (static)
            ngx_mail_auth_http_module (static)
            ngx_mail_proxy_module (static)
        root@ff4650e77c53:/etc/nginx#
        ```

