#!/usr/bin/with-contenv bashio

# Configuración por defecto
THREADS=4

# Cargar configuración desde options.json
if bashio::fs.file_exists "/data/options.json"; then
    THREADS=$(bashio::config 'threads')
fi

# Crear directorio para modelos si no existe
mkdir -p /data/models

# Descargar el modelo de ejemplo si no existe
MODEL_PATH="/data/models/llava-v1.5-7b-q4.llamafile"
if [ ! -f "$MODEL_PATH" ]; then
    bashio::log.info "Descargando modelo de ejemplo..."
    curl -L "https://huggingface.co/jartine/llava-v1.5-7b-q4.llamafile/resolve/main/llava-v1.5-7b-q4.llamafile" -o "$MODEL_PATH"
fi

# Construir comando base
CMD="/app/llamafile -m $MODEL_PATH --server --v2 --threads $THREADS"

# Ejecutar llamafile
bashio::log.info "Iniciando llamafile con el comando: $CMD"
exec $CMD 