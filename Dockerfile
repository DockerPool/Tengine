#���ü̳������Ǵ����� sshd ����
FROM sshd

#������һЩ�����ߵĻ�����Ϣ
MAINTAINER waitfish from dockerpool.com(dwj_zz@163.com)

# ��װ���뻷��
RUN apt-get install -y build-essential debhelper make autoconf automake patch
RUN apt-get install -y dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev git-core

# ���� Nginx �û�
RUN adduser --disabled-login --gecos 'Tengine' nginx

# tengine ��װ�� shell �ű�
WORKDIR /home/nginx
RUN su nginx -c 'git clone https://github.com/alibaba/tengine.git'

WORKDIR /home/nginx/tengine
RUN su nginx -c 'mv packages/debian .'
ENV DEB_BUILD_OPTIONS nocheck
RUN su nginx -c 'dpkg-buildpackage -rfakeroot -uc -b'
WORKDIR /home/nginx
RUN dpkg -i tengine_2.0.2-1_amd64.deb

# ����ɹ��ص�Ŀ¼ 
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

#���� nginx �Է� daemon ģʽ����
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# ���幤��Ŀ¼
WORKDIR /etc/nginx

# ������ǵĽű���������Ȩ�ޣ���Ḳ��֮ǰ�������λ�õĽű�
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# �����������
CMD ["/run.sh"]

# ��������˿�
EXPOSE 80
EXPOSE 443
