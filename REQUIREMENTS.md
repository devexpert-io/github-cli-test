Feature: Configuración y Conectividad con OpenRouter
Como usuario, necesito configurar la aplicación para que se comunique de forma segura con la API de OpenRouter,
permitiéndome empezar a chatear con los modelos de IA.

Scenario: Introducir una clave de API válida por primera vez
Given soy un usuario nuevo y estoy en la página de configuración
When introduzco mi clave de API de OpenRouter válida en el campo de texto
And hago clic en el botón "Guardar"
Then la clave de API se guarda de forma persistente y segura en mi navegador
And veo un mensaje de éxito que confirma que la clave es válida

Scenario: Introducir una clave de API inválida
Given soy un usuario y estoy en la página de configuración
When introduzco una clave de API de OpenRouter que es inválida
And hago clic en el botón "Guardar"
Then veo un mensaje de error claro explicando que la clave no es correcta
And la clave inválida no se guarda

Scenario: Visualización ofuscada de la clave de API
Given estoy en la página de configuración
When introduzco mi clave de API en el campo de texto
Then el texto que escribo debe mostrarse ofuscado (como una contraseña)

Feature: Interacción Principal de Chat
Como usuario, necesito una interfaz de chat funcional para comunicarme con el modelo de IA seleccionado,
enviando preguntas y recibiendo respuestas claras.

Scenario: Enviar un mensaje y recibir una respuesta
Given he configurado correctamente mi clave de API
And he seleccionado un modelo de IA de la lista
And estoy en la pantalla de un chat nuevo
When escribo "Hola, ¿cómo estás?" en el campo de texto
And presiono el botón "Enviar"
Then mi mensaje "Hola, ¿cómo estás?" aparece inmediatamente en la ventana de chat
And veo un indicador de que el modelo está generando una respuesta
And después de un momento, recibo y veo la respuesta del modelo debajo de mi mensaje

Scenario: Seleccionar un modelo de IA diferente para una conversación
Given estoy en una conversación activa
When abro el selector de modelos
And elijo un modelo diferente, por ejemplo "GPT-4"
Then el modelo seleccionado para la conversación actual se actualiza a "GPT-4"
And mi próximo mensaje será enviado a este nuevo modelo

Scenario: Visualización de bloques de código en las respuestas
Given estoy conversando con un modelo de IA
When hago una pregunta que requiere una respuesta con código, como "Escribe una función 'hello world' en Python"
Then la respuesta del modelo muestra el bloque de código con un formato monoespaciado y resaltado de sintaxis

Feature: Gestión de Conversaciones
Como usuario, necesito organizar mis interacciones en diferentes conversaciones
para mantener el contexto, el orden y poder acceder a ellas más tarde.

Scenario: Crear una nueva conversación
Given estoy en la aplicación con una conversación existente abierta
When hago clic en el botón "Nuevo Chat"
Then la ventana de chat principal se vacía, lista para una nueva conversación
And una nueva conversación con un título por defecto como "Chat sin título" aparece al principio de mi historial de chats

Scenario: Cambiar entre conversaciones existentes
Given tengo varias conversaciones en mi historial de chats
And estoy viendo la "Conversación A"
When hago clic en la "Conversación B" en el panel lateral
Then el contenido completo de la "Conversación B" se carga en la ventana de chat principal

Scenario: Renombrar una conversación
Given tengo una conversación en mi historial con el título "Chat sin título"
When hago clic en la opción para editar el nombre de esa conversación
And escribo "Ideas para mi proyecto" y confirmo el cambio
Then el nombre de la conversación en la lista se actualiza a "Ideas para mi proyecto"

Scenario: Eliminar una conversación
Given tengo una conversación en mi historial que quiero borrar
When hago clic en el icono de eliminar de esa conversación
And confirmo mi decisión en el diálogo de confirmación
Then la conversación se elimina permanentemente de mi historial de chats