# Comando Slash: code-issue

## Descripción
Comando personalizado para automatizar el flujo de trabajo de GitHub: crear una nueva rama basada en el identificador de una issue y generar un pull request con todos los cambios.

## Uso
```
/code-issue <issue-id>
```

## Parámetros
- `<issue-id>`: Número o identificador de la issue de GitHub (ej: 123, #123)

## Funcionalidad
1. Obtiene información de la issue especificada
2. Crea una nueva rama con formato: `issue-<issue-id>-<título-simplificado>`
3. Hace commit de todos los cambios actuales
4. Crea un pull request que referencia la issue original
5. Establece la rama base apropiada

## Ejemplo de uso
```
/code-issue 123
/code-issue #456
```

## Requisitos previos
- GitHub CLI (`gh`) instalado y autenticado
- Estar en un repositorio de GitHub
- Tener permisos para crear ramas y pull requests

## Comandos gh utilizados
- `gh issue view <issue-id>` - Obtener información de la issue
- `gh repo view --json defaultBranchRef` - Obtener rama por defecto
- `git checkout -b <branch-name>` - Crear nueva rama
- `git add .` - Agregar todos los cambios
- `git commit -m <message>` - Hacer commit
- `gh pr create` - Crear pull request

## Variables del entorno
- `GITHUB_REPOSITORY`: Repositorio actual (automático)
- `GITHUB_ACTOR`: Usuario actual (automático)

## Manejo de errores
- Validación de que la issue existe
- Verificación de que no hay conflictos de nombres de rama
- Manejo de errores de permisos
- Rollback automático en caso de fallo

## Configuración adicional
El comando puede ser personalizado modificando:
- Formato del nombre de la rama
- Plantilla del mensaje de commit
- Plantilla del pull request
- Ramas base permitidas
