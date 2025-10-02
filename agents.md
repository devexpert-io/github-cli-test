# Cliente de Chat Universal para OpenRouter AI

## 📋 Resumen del Proyecto

Este proyecto consiste en desarrollar una aplicación web que permita a los usuarios interactuar con múltiples modelos de IA a través de la API de OpenRouter. La aplicación proporciona una interfaz de chat intuitiva con gestión de conversaciones y configuración segura de claves API.

## 🎯 Características Principales

### 1. Configuración y Conectividad con OpenRouter
- Configuración segura de claves API de OpenRouter
- Validación de claves API válidas e inválidas
- Almacenamiento seguro en el navegador
- Interfaz ofuscada para entrada de claves

### 2. Interacción Principal de Chat
- Interfaz de chat funcional con modelos de IA
- Selección de diferentes modelos (GPT-4, Claude, etc.)
- Envío y recepción de mensajes en tiempo real
- Indicadores de carga durante la generación
- Renderizado de bloques de código con resaltado de sintaxis

### 3. Gestión de Conversaciones
- Creación de nuevas conversaciones
- Navegación entre conversaciones existentes
- Renombrado de conversaciones
- Eliminación de conversaciones con confirmación
- Persistencia del historial de chats

## 🛠️ Stack Tecnológico

### Frontend
- **Framework**: React.js con Vite
- **Lenguaje**: TypeScript
- **Estilos**: Tailwind CSS
- **Gestión de Estado**: Zustand (opcional)

### Librerías y Herramientas
- **Cliente HTTP**: SDK de OpenAI (compatible con OpenRouter)
- **Almacenamiento**: localStorage del navegador
- **Renderizado Markdown**: react-markdown con remark-gfm
- **Resaltado de Sintaxis**: react-syntax-highlighter
- **Iconos**: lucide-react

### Arquitectura
- **Tipo**: Single Page Application (SPA)
- **Almacenamiento**: Cliente (localStorage)
- **API**: OpenRouter (compatible con OpenAI)

## 📊 Issues de GitHub

El proyecto está organizado en **10 issues individuales** basados en escenarios específicos:

### Configuración y Conectividad (Issues #4-6)
- [Issue #4](https://github.com/devexpert-io/github-cli-test/issues/4): Introducir una clave de API válida por primera vez
- [Issue #5](https://github.com/devexpert-io/github-cli-test/issues/5): Introducir una clave de API inválida
- [Issue #6](https://github.com/devexpert-io/github-cli-test/issues/6): Visualización ofuscada de la clave de API

### Interacción Principal de Chat (Issues #7-9)
- [Issue #7](https://github.com/devexpert-io/github-cli-test/issues/7): Enviar un mensaje y recibir una respuesta
- [Issue #8](https://github.com/devexpert-io/github-cli-test/issues/8): Seleccionar un modelo de IA diferente para una conversación
- [Issue #9](https://github.com/devexpert-io/github-cli-test/issues/9): Visualización de bloques de código en las respuestas

### Gestión de Conversaciones (Issues #10-13)
- [Issue #10](https://github.com/devexpert-io/github-cli-test/issues/10): Crear una nueva conversación
- [Issue #11](https://github.com/devexpert-io/github-cli-test/issues/11): Cambiar entre conversaciones existentes
- [Issue #12](https://github.com/devexpert-io/github-cli-test/issues/12): Renombrar una conversación
- [Issue #13](https://github.com/devexpert-io/github-cli-test/issues/13): Eliminar una conversación

## 🚀 Consideraciones de Desarrollo

### Seguridad
- Las claves API se almacenan de forma segura en localStorage
- Validación de claves antes del almacenamiento
- Interfaz ofuscada para entrada de credenciales

### Experiencia de Usuario
- Interfaz responsive con diseño mobile-first
- Indicadores de carga y estados de error claros
- Navegación intuitiva entre conversaciones
- Resaltado de sintaxis para código

### Rendimiento
- Uso de Vite para desarrollo rápido
- Optimización automática de CSS con Tailwind
- Gestión eficiente del estado con Zustand
- Renderizado optimizado de Markdown

## 📁 Estructura del Proyecto

```
github-cli-test/
├── AGENTS.md              # Este archivo
├── REQUIREMENTS.md        # Requisitos detallados en formato BDD
├── STACK.md              # Documentación completa del stack tecnológico
└── [código fuente]       # Estructura a definir durante el desarrollo
```

## 🤖 Instrucciones para Agentes de IA

**IMPORTANTE**: Los agentes de IA que trabajen en este proyecto deben seguir estas reglas:

- **NO hacer commits automáticamente** a menos que se solicite explícitamente
- **NO hacer push automáticamente** a menos que se solicite explícitamente
- **Siempre preguntar antes** de realizar operaciones de Git que modifiquen el repositorio remoto
- **Seguir las mejores prácticas** de desarrollo definidas en el stack tecnológico

## 🔗 Enlaces Útiles

- **Repositorio**: [devexpert-io/github-cli-test](https://github.com/devexpert-io/github-cli-test)
- **OpenRouter API**: [openrouter.ai](https://openrouter.ai)
- **React Documentation**: [react.dev](https://react.dev)
- **Tailwind CSS**: [tailwindcss.com](https://tailwindcss.com)
- **TypeScript**: [typescriptlang.org](https://www.typescriptlang.org)

---

*Este documento proporciona una visión general del proyecto para desarrolladores y agentes de IA que trabajen en el código.*
