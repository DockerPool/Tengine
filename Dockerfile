#设置继承自我们创建的 sshd 镜像
FROM sshd

#下面是一些创建者的基本信息
MAINTAINER waitfish from dockerpool.com(dwj_zz@163.com)

# 安装编译环境
RUN apt-get install -y build-essential debhelper make autoconf automake patch
RUN apt-get install -y dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev git-core

# 创建 Nginx 用户
RUN adduser --disabled-login --gecos 'Tengine' nginx

# tengine 安装的 shell 脚本
WORKDIR /home/nginx
RUN su nginx -c 'git clone https://github.com/alibaba/tengine.git'

WORKDIR /home/nginx/tengine
RUN su nginx -c 'mv packages/debian .'
ENV DEB_BUILD_OPTIONS nocheck
RUN su nginx -c 'dpkg-buildpackage -rfakeroot -uc -b'
WORKDIR /home/nginx
RUN dpkg -i tengine_2.0.2-1_amd64.deb

# 定义可挂载的目录 
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

#设置 nginx 以非 daemon 模式启动
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# 定义工作目录
WORKDIR /etc/nginx

# 添加我们的脚本，并设置权限，这会覆盖之前放在这个位置的脚本
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# 定义输出命令
CMD ["/run.sh"]

# 定义输出端口
EXPOSE 80
EXPOSE 443
