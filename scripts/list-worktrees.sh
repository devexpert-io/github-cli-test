#!/bin/bash

# Script para listar todos los Git Worktrees con información detallada
# Uso: ./scripts/list-worktrees.sh

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}📋 Listado de Git Worktrees${NC}"
echo "=================================="
echo ""

# Obtener información de worktrees usando git worktree list
WORKTREES_OUTPUT=$(git worktree list)

if [ -z "$WORKTREES_OUTPUT" ]; then
    echo -e "${YELLOW}⚠️  No se encontraron worktrees${NC}"
    exit 0
fi

# Contador para el número de worktrees
COUNT=0

# Procesar cada línea del output de git worktree list
while IFS= read -r line; do
    COUNT=$((COUNT + 1))
    
    # Extraer información de la línea
    WORKTREE_PATH=$(echo "$line" | awk '{print $1}')
    COMMIT_HASH=$(echo "$line" | awk '{print $2}' | tr -d '[]')
    BRANCH_NAME=$(echo "$line" | awk '{print $3}' | tr -d '[]')
    
    # Obtener el nombre del directorio
    WORKTREE_DIR=$(basename "$WORKTREE_PATH")
    
    # Obtener información adicional de la branch
    if [ -n "$BRANCH_NAME" ]; then
        # Verificar si la branch está ahead/behind del remoto
        REMOTE_STATUS=""
        if git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}"; then
            AHEAD=$(git rev-list --count "${BRANCH_NAME}" @{upstream} 2>/dev/null || echo "0")
            BEHIND=$(git rev-list --count @{upstream} "${BRANCH_NAME}" 2>/dev/null || echo "0")
            
            if [ "$AHEAD" -gt 0 ] && [ "$BEHIND" -gt 0 ]; then
                REMOTE_STATUS="${YELLOW}[+${AHEAD}/-${BEHIND}]${NC}"
            elif [ "$AHEAD" -gt 0 ]; then
                REMOTE_STATUS="${GREEN}[+${AHEAD}]${NC}"
            elif [ "$BEHIND" -gt 0 ]; then
                REMOTE_STATUS="${RED}[-${BEHIND}]${NC}"
            else
                REMOTE_STATUS="${GREEN}[✓]${NC}"
            fi
        fi
        
        # Obtener el último commit
        LAST_COMMIT=$(git log -1 --format="%s" "${BRANCH_NAME}" 2>/dev/null || echo "N/A")
    else
        REMOTE_STATUS=""
        LAST_COMMIT="N/A"
    fi
    
    # Verificar si hay cambios sin commitear
    STATUS_ICON=""
    if [ -d "$WORKTREE_PATH" ]; then
        cd "$WORKTREE_PATH"
        if ! git diff --quiet || ! git diff --cached --quiet; then
            STATUS_ICON="${RED}●${NC}"
        else
            STATUS_ICON="${GREEN}●${NC}"
        fi
        cd - > /dev/null
    fi
    
    # Mostrar información del worktree
    echo -e "${CYAN}${COUNT}. ${WORKTREE_DIR}${NC}"
    echo -e "   ${BLUE}📁 Path:${NC} $WORKTREE_PATH"
    echo -e "   ${BLUE}🌿 Branch:${NC} $BRANCH_NAME $REMOTE_STATUS"
    echo -e "   ${BLUE}📝 Status:${NC} $STATUS_ICON"
    echo -e "   ${BLUE}🔗 Commit:${NC} ${COMMIT_HASH:0:8}"
    echo -e "   ${BLUE}💬 Last:${NC} $LAST_COMMIT"
    echo ""
    
done <<< "$WORKTREES_OUTPUT"

echo "=================================="
echo -e "${BLUE}📊 Total: ${COUNT} worktree(s)${NC}"
echo ""

# Mostrar comandos útiles
echo -e "${BLUE}🛠️  Comandos útiles:${NC}"
echo -e "${YELLOW}   ./scripts/create-worktree.sh <name>     # Crear nuevo worktree${NC}"
echo -e "${YELLOW}   ./scripts/remove-worktree.sh <name>     # Eliminar worktree${NC}"
echo -e "${YELLOW}   ./scripts/cleanup-worktrees.sh          # Limpiar worktrees huérfanos${NC}"
echo -e "${YELLOW}   git worktree prune                      # Eliminar referencias huérfanas${NC}"
echo ""
