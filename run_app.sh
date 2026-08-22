#!/bin/bash
# Script para levantar el backend y Flutter juntos
# Uso: ./run_app.sh [linux|chrome] (por defecto: linux)

DEVICE="${1:-linux}"

echo "=== 1. Iniciando Backend FastAPI ==="
cd /home/kairos/Proyectos/backend_crud_personas
.venv/bin/python -m uvicorn main:app --host 127.0.0.1 --port 8000 &
BACKEND_PID=$!
echo "Backend iniciado (PID: $BACKEND_PID) en http://127.0.0.1:8000"
sleep 2

echo ""
echo "=== 2. Iniciando Flutter (Dispositivo: $DEVICE) ==="
cd /home/kairos/Proyectos/Fluter_crud_personas
/home/kairos/development/flutter/bin/flutter run -d "$DEVICE"

# Al salir de Flutter, detener el backend automáticamente
kill $BACKEND_PID 2>/dev/null
echo "Backend detenido."
