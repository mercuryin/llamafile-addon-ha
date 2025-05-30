ARG BUILD_FROM
FROM $BUILD_FROM

# Instalar dependencias necesarias
RUN apk add --no-cache \
    curl \
    wget \
    bash \
    s6-overlay

# Crear directorio de trabajo
WORKDIR /app

# Descargar llamafile precompilado
RUN curl -L https://github.com/Mozilla-Ocho/llamafile/releases/download/0.8.2/llamafile-0.8.2.zip -o llamafile.zip && \
    unzip llamafile.zip && \
    mv llamafile-0.8.2/bin/llamafile /app/llamafile && \
    chmod +x /app/llamafile && \
    rm -rf llamafile.zip llamafile-0.8.2

# Crear script de limpieza
RUN echo '#!/bin/sh\nrm -rf /data/logs/*\nrm -rf /data/models/*' > /app/cleanup.sh && \
    chmod +x /app/cleanup.sh

# Copiar scripts y configuración
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Configurar s6
RUN mkdir -p /run/s6/container_environment

# Configurar el directorio de trabajo
WORKDIR /app

# Configurar el punto de entrada
ENTRYPOINT ["/init"]
CMD ["/app/run.sh"] 