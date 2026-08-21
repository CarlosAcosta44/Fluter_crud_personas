#!/bin/bash
# Script para levantar el backend y Flutter juntos

echo "=== Iniciando Backend FastAPI ==="
cd /home/kairos/Proyectos/backend_crud_personas
.venv/bin/python -m uvicorn main:app --host 127.0.0.1 --port 8000 &
BACKEND_PID=$!
echo "Backend iniciado (PID: $BACKEND_PID)"
sleep 2

echo ""
echo "=== Iniciando Flutter (Linux Desktop) ==="
cd /home/kairos/Proyectos/Fluter_crud_personas
/home/kairos/development/flutter/bin/flutter run -d linux

# Al salir de Flutter, también detener el backend
kill $BACKEND_PID 2>/dev/null
echo "Backend detenido."
