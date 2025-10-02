# Git Worktrees - Guía de Uso

## 📋 ¿Qué son los Git Worktrees?

Los Git Worktrees te permiten tener múltiples directorios de trabajo conectados al mismo repositorio Git. Esto es especialmente útil para:

- Trabajar en diferentes branches simultáneamente
- Revisar código mientras trabajas en otra feature
- Mantener el main branch limpio mientras experimentas
- Trabajar en hotfixes sin interrumpir tu trabajo actual

## 🚀 Configuración Inicial

El proyecto ya está configurado para trabajar con Git Worktrees. Las siguientes configuraciones han sido aplicadas:

- `core.worktreeConfig = true`: Habilita la configuración específica por worktree
- `core.autocrlf = input`: Configuración de line endings para compatibilidad
- `core.filemode = false`: Evita problemas con permisos de archivos
- Directorio `worktrees/` ignorado en `.gitignore`

## 📁 Estructura Recomendada

```
/Users/antonio/Desktop/github-cli-test/          # Repositorio principal (main branch)
├── worktrees/                                   # Directorio para worktrees (ignorado)
│   ├── feature-api-key-config/                  # Worktree para feature branch
│   ├── feature-chat-interface/                  # Worktree para otra feature
│   └── hotfix-bug-fix/                          # Worktree para hotfix
└── [archivos del proyecto]
```

## 🛠️ Comandos Básicos

### Crear un nuevo Worktree

```bash
# Crear un nuevo worktree para una nueva branch
git worktree add ../worktrees/feature-nueva-funcionalidad feature-nueva-funcionalidad

# Crear un nuevo worktree desde una branch existente
git worktree add ../worktrees/hotfix-urgente hotfix-urgente

# Crear un nuevo worktree y branch simultáneamente
git worktree add -b feature-chat-interface ../worktrees/feature-chat-interface
```

### Listar Worktrees

```bash
# Ver todos los worktrees
git worktree list

# Ver worktrees con más detalles
git worktree list --porcelain
```

### Navegar entre Worktrees

```bash
# Cambiar al directorio del worktree
cd ../worktrees/feature-nueva-funcionalidad

# Trabajar normalmente con Git
git status
git add .
git commit -m "Implementar nueva funcionalidad"
git push origin feature-nueva-funcionalidad
```

### Eliminar Worktrees

```bash
# Eliminar un worktree (desde cualquier directorio)
git worktree remove ../worktrees/feature-nueva-funcionalidad

# Eliminar un worktree y su branch
git worktree remove --force ../worktrees/feature-nueva-funcionalidad
git branch -D feature-nueva-funcionalidad
```

## 📋 Flujo de Trabajo Recomendado

### 1. Desarrollo de Features

```bash
# Desde el directorio principal
git worktree add -b feature-api-configuration ../worktrees/feature-api-configuration

# Cambiar al worktree
cd ../worktrees/feature-api-configuration

# Instalar dependencias
npm install

# Trabajar en la feature
# ... hacer cambios ...
git add .
git commit -m "feat: implementar configuración de API key"

# Push de la branch
git push origin feature-api-configuration
```

### 2. Revisión de Código

```bash
# Crear worktree para revisar PR
git worktree add ../worktrees/review-pr-123 origin/feature-chat-interface

# Navegar al worktree
cd ../worktrees/review-pr-123

# Probar los cambios
npm install
npm run dev

# Limpiar después de la revisión
cd ../github-cli-test
git worktree remove ../worktrees/review-pr-123
```

### 3. Hotfixes

```bash
# Crear worktree para hotfix
git worktree add -b hotfix-critical-bug ../worktrees/hotfix-critical-bug

# Trabajar en el hotfix
cd ../worktrees/hotfix-critical-bug
# ... implementar fix ...
git add .
git commit -m "fix: corregir bug crítico en autenticación"
git push origin hotfix-critical-bug

# Merge y limpieza
cd ../github-cli-test
git merge hotfix-critical-bug
git push origin main
git worktree remove ../worktrees/hotfix-critical-bug
git branch -D hotfix-critical-bug
```

## 🔧 Scripts de Ayuda

El proyecto incluye scripts para facilitar el manejo de worktrees:

- `./scripts/create-worktree.sh <branch-name>`: Crear nuevo worktree
- `./scripts/remove-worktree.sh <branch-name>`: Eliminar worktree
- `./scripts/list-worktrees.sh`: Listar todos los worktrees
- `./scripts/cleanup-worktrees.sh`: Limpiar worktrees huérfanos

## ⚠️ Consideraciones Importantes

### Limitaciones

- No puedes hacer checkout de la misma branch en múltiples worktrees simultáneamente
- Los worktrees comparten el mismo `.git` directory, por lo que algunos comandos pueden afectar a todos

### Mejores Prácticas

1. **Nomenclatura**: Usa nombres descriptivos para los directorios de worktree
2. **Limpieza**: Elimina worktrees cuando termines de trabajar en ellos
3. **Backup**: Los worktrees no se sincronizan automáticamente, haz push regularmente
4. **Dependencias**: Cada worktree necesita su propio `npm install`

### Troubleshooting

```bash
# Si un worktree parece "roto"
git worktree repair

# Verificar integridad del repositorio
git fsck

# Limpiar referencias huérfanas
git worktree prune
```

## 🎯 Casos de Uso Específicos para este Proyecto

### Desarrollo Paralelo de Issues

Para trabajar en múltiples issues de GitHub simultáneamente:

```bash
# Issue #4: Configuración de API Key
git worktree add -b issue-4-api-key ../worktrees/issue-4-api-key

# Issue #7: Chat Interface
git worktree add -b issue-7-chat ../worktrees/issue-7-chat

# Cambiar entre issues
cd ../worktrees/issue-4-api-key  # Trabajar en API Key
cd ../worktrees/issue-7-chat     # Trabajar en Chat
```

### Testing y QA

```bash
# Worktree para testing
git worktree add ../worktrees/testing origin/develop

# Worktree para producción (solo lectura)
git worktree add ../worktrees/production origin/main
```

## 📚 Referencias

- [Git Worktrees Documentation](https://git-scm.com/docs/git-worktree)
- [Atlassian Git Worktrees Guide](https://www.atlassian.com/git/tutorials/worktrees)
- [Git Worktrees Best Practices](https://git-scm.com/docs/git-worktree#_examples)

---

*Esta configuración te permite trabajar de manera más eficiente en múltiples features simultáneamente, manteniendo un flujo de trabajo organizado y profesional.*
