# Base image With Apache
FROM daocloud.io/library/php:5.3-apache

# PHP Core Extensions 
# 
# For example, if you want to have a PHP-FPM image with iconv, 
# mcrypt and gd extensions, you can inherit the base image that you like, 
# and write your own Dockerfile like this:
# 
# RUN apt-get update && apt-get install -y \
#         libfreetype6-dev \
#         libjpeg62-turbo-dev \
#         libmcrypt-dev \
#         libpng12-dev \
#     && docker-php-ext-install -j$(nproc) iconv mcrypt \
#     && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#     && docker-php-ext-install -j$(nproc) gd

RUN apt-get update && apt-get install -y \
					libmcrypt-dev \
					libz-dev \
					php5-mysql \
					php5-curl \
					curl
    # && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring zip\
    # && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    # && docker-php-ext-install -j$(nproc) gd



# PECL extensions
# 
# Some extensions are not provided with the PHP source, 
# but are instead available through PECL. To install a PECL extension, 
# use pecl install to download and compile it, then use docker-php-ext-enable to enable it:
# 
# RUN apt-get update && apt-get install -y libmemcached-dev \
#    && pecl install memcached \
#    && docker-php-ext-enable memcached

# Other extensions
# 
# Some extensions are not provided via either Core or PECL; 
# these can be installed too, although the process is less automated:
# 
# RUN curl -fsSL 'https://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.gz' -o xcache.tar.gz \
#     && mkdir -p xcache \
#     && tar -xf xcache.tar.gz -C xcache --strip-components=1 \
#     && rm xcache.tar.gz \
#     && ( \
#         cd xcache \
#         && phpize \
#         && ./configure --enable-xcache \
#         && make -j$(nproc) \
#         && make install \
#     ) \
#     && rm -r xcache \
#     && docker-php-ext-enable xcache


# Where src/ is the directory containing all your php code 
# and config/ contains your php.ini file.
# 
# COPY config/php.ini /usr/local/etc/php/
COPY src/ /var/www/html


