#!/bin/bash

# Script para eliminar un Git Worktree
# Uso: ./scripts/remove-worktree.sh <branch-name> [--force]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 <branch-name> [--force]"
    echo ""
    echo "Argumentos:"
    echo "  branch-name    Nombre de la branch y directorio a eliminar"
    echo "  --force        Eliminar incluso si hay cambios sin commitear"
    echo ""
    echo "Ejemplos:"
    echo "  $0 feature-api-key              # Eliminar worktree de forma segura"
    echo "  $0 hotfix-bug --force           # Eliminar worktree forzadamente"
    echo ""
}

# Verificar que se proporcione el nombre de la branch
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Se requiere el nombre de la branch${NC}"
    show_help
    exit 1
fi

BRANCH_NAME="$1"
FORCE_FLAG="${2:-}"
WORKTREE_DIR="../worktrees/${BRANCH_NAME}"

echo -e "${BLUE}🗑️  Eliminando Git Worktree...${NC}"
echo -e "${YELLOW}Branch: ${BRANCH_NAME}${NC}"
echo -e "${YELLOW}Directorio: ${WORKTREE_DIR}${NC}"
echo ""

# Verificar si el worktree existe
if [ ! -d "$WORKTREE_DIR" ]; then
    echo -e "${RED}❌ Error: El worktree '${BRANCH_NAME}' no existe${NC}"
    echo -e "${YELLOW}💡 Usa: git worktree list para ver worktrees existentes${NC}"
    exit 1
fi

# Verificar si hay cambios sin commitear (solo si no se usa --force)
if [ "$FORCE_FLAG" != "--force" ]; then
    echo -e "${BLUE}🔍 Verificando cambios sin commitear...${NC}"
    
    # Cambiar al directorio del worktree temporalmente para verificar el estado
    cd "$WORKTREE_DIR"
    
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo -e "${YELLOW}⚠️  Hay cambios sin commitear en el worktree${NC}"
        echo -e "${BLUE}📋 Cambios pendientes:${NC}"
        git status --short
        echo ""
        echo -e "${YELLOW}💡 Opciones:${NC}"
        echo -e "${YELLOW}   1. Commitear los cambios: git add . && git commit -m 'mensaje'${NC}"
        echo -e "${YELLOW}   2. Usar --force para eliminar de todas formas: $0 $BRANCH_NAME --force${NC}"
        echo -e "${YELLOW}   3. Stashear los cambios: git stash${NC}"
        exit 1
    fi
    
    # Volver al directorio original
    cd - > /dev/null
fi

# Confirmar eliminación
if [ "$FORCE_FLAG" != "--force" ]; then
    echo -e "${YELLOW}❓ ¿Estás seguro de que quieres eliminar el worktree '${BRANCH_NAME}'? (y/N)${NC}"
    read -r confirmation
    if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}❌ Operación cancelada${NC}"
        exit 0
    fi
fi

# Eliminar el worktree
echo -e "${BLUE}🗑️  Eliminando worktree...${NC}"
git worktree remove "$WORKTREE_DIR" $FORCE_FLAG

# Preguntar si también eliminar la branch
if git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}"; then
    echo ""
    echo -e "${YELLOW}❓ ¿También quieres eliminar la branch '${BRANCH_NAME}'? (y/N)${NC}"
    read -r delete_branch
    if [[ "$delete_branch" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}🗑️  Eliminando branch...${NC}"
        git branch -D "$BRANCH_NAME"
        echo -e "${GREEN}✅ Branch '${BRANCH_NAME}' eliminada${NC}"
    fi
fi

echo ""
echo -e "${GREEN}✅ Worktree '${BRANCH_NAME}' eliminado exitosamente!${NC}"
echo ""
echo -e "${BLUE}📋 Comandos útiles:${NC}"
echo -e "${YELLOW}   git worktree list                    # Ver worktrees restantes${NC}"
echo -e "${YELLOW}   ./scripts/create-worktree.sh <name>  # Crear nuevo worktree${NC}"
echo ""
