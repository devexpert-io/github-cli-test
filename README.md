# OpenRouter Chat Client

Un cliente de chat universal para interactuar con múltiples modelos de IA a través de la API de OpenRouter.

## 🚀 Características Implementadas

### ✅ Issue #4: Configuración de Clave de API

**Escenario**: Introducir una clave de API válida por primera vez

**Funcionalidades implementadas**:
- ✅ Campo de entrada para clave de API con ofuscación de texto
- ✅ Botón "Guardar" funcional
- ✅ Validación de clave de API contra OpenRouter
- ✅ Almacenamiento seguro en el navegador (localStorage)
- ✅ Mensaje de éxito al guardar correctamente
- ✅ Interfaz responsive con Tailwind CSS
- ✅ Indicadores de carga durante la validación
- ✅ Opción para mostrar/ocultar la clave de API

## 🛠️ Stack Tecnológico

- **Frontend**: React 18 + TypeScript
- **Build Tool**: Vite
- **Estilos**: Tailwind CSS
- **Gestión de Estado**: Zustand con persistencia
- **Iconos**: Lucide React
- **Validación**: API de OpenRouter

## 📦 Instalación

```bash
# Instalar dependencias
npm install

# Ejecutar en modo desarrollo
npm run dev

# Construir para producción
npm run build
```

## 🎯 Uso

1. Ejecuta la aplicación con `npm run dev`
2. Introduce tu clave de API de OpenRouter
3. La aplicación validará la clave contra la API de OpenRouter
4. Si es válida, se guardará de forma segura en el navegador

## 🔗 Enlaces

- [OpenRouter API Keys](https://openrouter.ai/keys)
- [OpenRouter Documentation](https://openrouter.ai/docs)

## 🌳 Git Worktrees

Este proyecto está configurado para trabajar con Git Worktrees, permitiendo desarrollar múltiples features simultáneamente.

### Scripts Disponibles

```bash
# Crear un nuevo worktree
./scripts/create-worktree.sh feature-nueva-funcionalidad

# Listar todos los worktrees
./scripts/list-worktrees.sh

# Eliminar un worktree
./scripts/remove-worktree.sh feature-nueva-funcionalidad

# Limpiar worktrees huérfanos
./scripts/cleanup-worktrees.sh
```

Para más información, consulta [WORKTREES.md](./WORKTREES.md).

## 📋 Próximas Funcionalidades

Las siguientes issues están pendientes de implementación:
- Issue #5: Manejo de claves de API inválidas
- Issue #6: Visualización ofuscada mejorada
- Issue #7: Interfaz de chat principal
- Issue #8: Selección de modelos de IA
- Issue #9: Renderizado de código con sintaxis
- Issues #10-13: Gestión de conversaciones
