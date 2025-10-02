#!/bin/bash

# Script para limpiar Git Worktrees huérfanos y optimizar el repositorio
# Uso: ./scripts/cleanup-worktrees.sh

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧹 Limpieza de Git Worktrees${NC}"
echo "=================================="
echo ""

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [--dry-run] [--force]"
    echo ""
    echo "Opciones:"
    echo "  --dry-run    Mostrar qué se haría sin ejecutar los cambios"
    echo "  --force      Ejecutar sin confirmaciones"
    echo ""
    echo "Este script:"
    echo "  • Elimina referencias huérfanas de worktrees"
    echo "  • Limpia el repositorio Git"
    echo "  • Verifica la integridad del repositorio"
    echo ""
}

# Variables para opciones
DRY_RUN=false
FORCE=false

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Opción desconocida: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}🔍 Modo DRY-RUN: No se ejecutarán cambios reales${NC}"
    echo ""
fi

# 1. Verificar integridad del repositorio
echo -e "${BLUE}🔍 Verificando integridad del repositorio...${NC}"
if [ "$DRY_RUN" = false ]; then
    git fsck --full --strict --no-dangling
    echo -e "${GREEN}✅ Repositorio íntegro${NC}"
else
    echo -e "${YELLOW}🔍 [DRY-RUN] Verificaría integridad del repositorio${NC}"
fi
echo ""

# 2. Limpiar referencias huérfanas de worktrees
echo -e "${BLUE}🗑️  Limpiando referencias huérfanas de worktrees...${NC}"
if [ "$DRY_RUN" = false ]; then
    git worktree prune
    echo -e "${GREEN}✅ Referencias huérfanas eliminadas${NC}"
else
    echo -e "${YELLOW}🔍 [DRY-RUN] Eliminaría referencias huérfanas de worktrees${NC}"
fi
echo ""

# 3. Verificar worktrees existentes
echo -e "${BLUE}📋 Verificando worktrees existentes...${NC}"
WORKTREES_OUTPUT=$(git worktree list)
if [ -z "$WORKTREES_OUTPUT" ]; then
    echo -e "${YELLOW}⚠️  No se encontraron worktrees${NC}"
else
    echo -e "${GREEN}✅ Worktrees encontrados:${NC}"
    echo "$WORKTREES_OUTPUT" | while read -r line; do
        WORKTREE_PATH=$(echo "$line" | awk '{print $1}')
        BRANCH_NAME=$(echo "$line" | awk '{print $3}' | tr -d '[]')
        echo -e "   ${CYAN}•${NC} $WORKTREE_PATH ($BRANCH_NAME)"
    done
fi
echo ""

# 4. Verificar directorio worktrees
echo -e "${BLUE}📁 Verificando directorio worktrees...${NC}"
if [ -d "../worktrees" ]; then
    WORKTREE_DIRS=$(find ../worktrees -maxdepth 1 -type d -not -name "worktrees" 2>/dev/null || true)
    if [ -n "$WORKTREE_DIRS" ]; then
        echo -e "${GREEN}✅ Directorios de worktree encontrados:${NC}"
        echo "$WORKTREE_DIRS" | while read -r dir; do
            DIR_NAME=$(basename "$dir")
            if git worktree list | grep -q "$DIR_NAME"; then
                echo -e "   ${GREEN}✓${NC} $dir (activo)"
            else
                echo -e "   ${RED}✗${NC} $dir (huérfano)"
            fi
        done
    else
        echo -e "${YELLOW}⚠️  Directorio worktrees vacío${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Directorio worktrees no existe${NC}"
fi
echo ""

# 5. Limpiar objetos no referenciados (solo si no es dry-run)
if [ "$DRY_RUN" = false ]; then
    echo -e "${BLUE}🧹 Limpiando objetos no referenciados...${NC}"
    
    # Preguntar confirmación si no se usa --force
    if [ "$FORCE" = false ]; then
        echo -e "${YELLOW}❓ ¿Ejecutar garbage collection? Esto puede tomar tiempo. (y/N)${NC}"
        read -r confirmation
        if [[ "$confirmation" =~ ^[Yy]$ ]]; then
            git gc --prune=now
            echo -e "${GREEN}✅ Garbage collection completado${NC}"
        else
            echo -e "${YELLOW}⚠️  Garbage collection omitido${NC}"
        fi
    else
        git gc --prune=now
        echo -e "${GREEN}✅ Garbage collection completado${NC}"
    fi
else
    echo -e "${YELLOW}🔍 [DRY-RUN] Ejecutaría garbage collection${NC}"
fi
echo ""

# 6. Mostrar estadísticas finales
echo -e "${BLUE}📊 Estadísticas del repositorio:${NC}"
if [ "$DRY_RUN" = false ]; then
    echo -e "${CYAN}•${NC} Branches: $(git branch | wc -l | tr -d ' ')"
    echo -e "${CYAN}•${NC} Worktrees: $(git worktree list | wc -l | tr -d ' ')"
    echo -e "${CYAN}•${NC} Commits: $(git rev-list --count HEAD)"
    echo -e "${CYAN}•${NC} Tamaño: $(du -sh .git | cut -f1)"
else
    echo -e "${YELLOW}🔍 [DRY-RUN] Mostraría estadísticas del repositorio${NC}"
fi
echo ""

echo -e "${GREEN}✅ Limpieza completada!${NC}"
echo ""
echo -e "${BLUE}🛠️  Comandos útiles:${NC}"
echo -e "${YELLOW}   ./scripts/list-worktrees.sh              # Ver todos los worktrees${NC}"
echo -e "${YELLOW}   ./scripts/create-worktree.sh <name>     # Crear nuevo worktree${NC}"
echo -e "${YELLOW}   ./scripts/remove-worktree.sh <name>     # Eliminar worktree${NC}"
echo ""
