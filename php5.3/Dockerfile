FROM centos:6

RUN set -x \
	&& rpm -ihv http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
        && yum install -y xz httpd php php-mysql php-xml.x86_64 php-bcmath.x86_64 php-gd.x86_64 php-soap.x86_64 php-xmlrpc.x86_64  php-mbstring.x86_64 php-pecl-memcached.x86_64 php-mcrypt.x86_64 gcc gcc-c++ autoconf automake php-devel php-pear \
        && yum clean all

RUN set -x \
        && curl -o ImageMagick-6.8.8-10.tar.xz http://www.imagemagick.org/download/releases/ImageMagick-6.8.8-10.tar.xz \
        && xz -d ImageMagick-6.8.8-10.tar.xz \
        && tar xf ImageMagick-6.8.8-10.tar \
        && cd ImageMagick-6.8.8-10 \
        && ./configure \
        && make \
        && make install \
        && ln -s /usr/local/include/ImageMagick-6 /usr/local/include/ImageMagick \
        && ln -s /usr/local/lib/libMagickCore-6.Q16.so /usr/local/lib/libMagickCore.so \
        && ln -s /usr/local/lib/libMagickWand-6.Q16.so /usr/local/lib/libMagickWand.so \
        && cd / \
        && rm -rf ImageMagick-6.8.8* \
        && curl -o imagick-2.3.0.tgz http://pecl.php.net/get/imagick-2.3.0.tgz \
        && tar zxf imagick-2.3.0.tgz \
        && cd imagick-2.3.0 \
        && phpize \
        && ./configure \
        && make \
        && mkdir -p /usr/local/lib/php/extensions/ \
        && cp modules/imagick.so /usr/local/lib/php/extensions/imagick.so \
        && echo "extension=/usr/local/lib/php/extensions/imagick.so" > /etc/php.d/imagick.ini \
        && cd / \
        && rm -rf imagick-2.3.0*

RUN curl -o libiconv-1.13.1.tar.gz http://ftp.gnu.org/gnu/libiconv/libiconv-1.13.1.tar.gz \
	&& tar zxf libiconv-1.13.1.tar.gz \
	&& cd libiconv-1.13.1 \
	&& ./configure \
	&& make \
	&& make install \
	&& cd / \
	&& rm -rf libiconv-1.13.1*

RUN ln -sf /dev/stdout /var/log/httpd/access_log \
	&& ln -sf /dev/stdout /var/log/httpd/error_log

ADD httpd.conf /etc/httpd/conf/httpd.conf
VOLUME /var/www/html
EXPOSE 80
CMD ["apachectl", "-DFOREGROUND"]
