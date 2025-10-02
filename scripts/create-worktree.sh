#!/bin/bash

# Script para crear un nuevo Git Worktree
# Uso: ./scripts/create-worktree.sh <branch-name> [remote-branch]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 <branch-name> [remote-branch]"
    echo ""
    echo "Argumentos:"
    echo "  branch-name    Nombre de la nueva branch y directorio"
    echo "  remote-branch  (Opcional) Branch remota desde la cual crear la nueva branch"
    echo ""
    echo "Ejemplos:"
    echo "  $0 feature-api-key                    # Crear nueva branch desde main"
    echo "  $0 hotfix-bug origin/develop          # Crear branch desde develop"
    echo "  $0 review-pr-123 origin/feature-chat  # Crear worktree para revisar PR"
    echo ""
}

# Verificar que se proporcione al menos un argumento
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: Se requiere al menos el nombre de la branch${NC}"
    show_help
    exit 1
fi

BRANCH_NAME="$1"
REMOTE_BRANCH="${2:-main}"
WORKTREE_DIR="../worktrees/${BRANCH_NAME}"

echo -e "${BLUE}🚀 Creando Git Worktree...${NC}"
echo -e "${YELLOW}Branch: ${BRANCH_NAME}${NC}"
echo -e "${YELLOW}Desde: ${REMOTE_BRANCH}${NC}"
echo -e "${YELLOW}Directorio: ${WORKTREE_DIR}${NC}"
echo ""

# Verificar si el directorio de worktrees existe
if [ ! -d "../worktrees" ]; then
    echo -e "${YELLOW}📁 Creando directorio worktrees...${NC}"
    mkdir -p ../worktrees
fi

# Verificar si el worktree ya existe
if [ -d "$WORKTREE_DIR" ]; then
    echo -e "${RED}❌ Error: El worktree '${BRANCH_NAME}' ya existe${NC}"
    echo -e "${YELLOW}💡 Usa: git worktree list para ver worktrees existentes${NC}"
    exit 1
fi

# Verificar si la branch ya existe localmente
if git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}"; then
    echo -e "${YELLOW}⚠️  La branch '${BRANCH_NAME}' ya existe localmente${NC}"
    echo -e "${BLUE}📋 Creando worktree desde branch existente...${NC}"
    git worktree add "$WORKTREE_DIR" "$BRANCH_NAME"
else
    echo -e "${BLUE}📋 Creando nueva branch '${BRANCH_NAME}' desde '${REMOTE_BRANCH}'...${NC}"
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" "$REMOTE_BRANCH"
fi

echo ""
echo -e "${GREEN}✅ Worktree creado exitosamente!${NC}"
echo ""
echo -e "${BLUE}📋 Próximos pasos:${NC}"
echo -e "${YELLOW}   cd ${WORKTREE_DIR}${NC}"
echo -e "${YELLOW}   npm install${NC}"
echo -e "${YELLOW}   npm run dev${NC}"
echo ""
echo -e "${BLUE}📋 Comandos útiles:${NC}"
echo -e "${YELLOW}   git worktree list                    # Ver todos los worktrees${NC}"
echo -e "${YELLOW}   git worktree remove ${WORKTREE_DIR}  # Eliminar este worktree${NC}"
echo ""
