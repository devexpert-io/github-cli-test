import { useApiKeyStore } from './stores/apiKeyStore';
import ApiKeyConfiguration from './components/ApiKeyConfiguration';

function App() {
    const { apiKey, isValid } = useApiKeyStore();

    // Si no hay clave de API o no es válida, mostrar la configuración
    if (!apiKey || !isValid) {
        return <ApiKeyConfiguration />;
    }

    // Aquí irá la interfaz principal del chat cuando esté implementada
    return (
        <div className="min-h-screen bg-gray-50 flex items-center justify-center">
            <div className="text-center">
                <h1 className="text-2xl font-bold text-gray-900 mb-4">
                    ¡Configuración completada!
                </h1>
                <p className="text-gray-600">
                    La interfaz de chat se implementará en las siguientes issues.
                </p>
            </div>
        </div>
    );
}

export default App;
