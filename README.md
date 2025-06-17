# NeuroPlay – Videojuego Educativo para Niños con Asperger

NeuroPlay es un videojuego interactivo y educativo pensado para fortalecer la atención, la concentración y las habilidades sociales en niños de 6 a 12 años con características del Síndrome de Asperger. Buscamos brindar una experiencia lúdica, segura y adaptada a nivel sensorial, acompañada de una identidad visual clara y soporte técnico.

## Objetivos del Proyecto
- Fortalecer la atención y la concentración mediante dinámicas de juego.
- Ofrecer una herramienta inclusiva validada por especialistas.
- Evitar la sobrecarga sensorial durante la experiencia de usuario.
- Facilitar la participación de padres y docentes como guías activos.

## Componentes del Sistema
### 1. Frontend Web (HTML + CSS + JS)
- **Pantallas**
  - **Inicio**: nombre del juego, selección de idioma y botones para iniciar, ver puntajes u opciones.
  - **Juego**: encontrar el círculo verde con barra de tiempo, puntuación y niveles.
  - **Resultados**: muestra el puntaje final y permite reiniciar o volver al menú.
- **Interacción**
  - Sistema de puntaje y niveles.
  - Detección del objeto correcto (🟢) con retroalimentación visual.
  - Almacenamiento del mejor puntaje en `localStorage`.

### 2. Backend (Node.js + Express + Consul)
- Microservicio con los siguientes endpoints:
  - `/health`: verificación de estado.
  - `/`: información de los servicios registrados en Consul.
- Registro dinámico del servicio con TTL, *health check* y eliminación automática en caso de falla.

## Identidad Visual
- **Logotipo**: ojo dentro de un joystick rodeado de íconos de logros, representando enfoque, juego y progreso.
- **Paleta de Colores**
  - `#AEDFF7` – Calma y accesibilidad.
  - `#2C3E50` – Seguridad y confianza.
  - `#F0F3F5` – Neutralidad sensorial.
  - `#A2D5AB` – Progreso y armonía.
- **Tipografía**
  - Títulos: **Poppins** (moderna y clara).
  - Estilo infantil/lúdico: **Comic Neue** o **Comic Sans**.
- **Iconografía**: íconos redondeados y suaves, con símbolos de foco, tiempo y logros. Se emplean emojis (🟢 🔴 🔵 🟠) como estímulos visuales amigables.

## Público Objetivo
- **Primario**: niños y niñas de 6 a 12 años diagnosticados dentro del espectro autista, especialmente con características de Asperger.
- **Secundario**: padres, madres, tutores, docentes, psicopedagogos y terapeutas que trabajan con población neurodivergente.

## Métricas de Éxito
- Número de sesiones activas semanales.
- Tiempo promedio de atención.
- Número de usuarios recurrentes.
- Calificación en tiendas.
- Número de escuelas o instituciones usuarias.

## Equipo del Proyecto
- Daniel Ramírez
- Edwin Chigne
- Martín Kong
- Jefferson Jacobo

*"Donde enfocar la mente, se convierte en un juego." – NeuroPlay*

## Cómo Empezar
1. Clona este repositorio.
2. Instala las dependencias con `flutter pub get`.
3. Ejecuta la aplicación con `flutter run`.

## Contribución
Las contribuciones son bienvenidas. Por favor abre un *issue* o envía un *pull request* para sugerencias y mejoras.

## Licencia
Este proyecto actualmente no tiene una licencia definida.
