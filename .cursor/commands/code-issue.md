Soluciona un problema basado en el identificador que se te pasa como argumento, creando una nueva rama que luego subirás como un pull request.

Usa el comando gh para comunicarte con GitHub.

## Pasos

1. Recupera la issue de Github
2. Crea un worktree de Git usando el script pre-creado: `./scripts/create-worktree.sh feature-{id}`
3. Navega al directorio del worktree y configura el entorno
4. Soluciona la issue
5. Crea un PR.