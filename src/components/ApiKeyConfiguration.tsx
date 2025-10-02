import React, { useState } from 'react';
import { useApiKeyStore } from '../stores/apiKeyStore';
import { CheckCircle, XCircle, Loader2, Eye, EyeOff } from 'lucide-react';

const ApiKeyConfiguration: React.FC = () => {
    const { apiKey, isValid, isLoading, validateApiKey } = useApiKeyStore();
    const [inputKey, setInputKey] = useState(apiKey || '');
    const [showKey, setShowKey] = useState(false);
    const [message, setMessage] = useState<{ type: 'success' | 'error'; text: string } | null>(null);

    const handleSave = async () => {
        if (!inputKey.trim()) {
            setMessage({ type: 'error', text: 'Por favor, introduce una clave de API' });
            return;
        }

        setMessage(null);
        const isValidKey = await validateApiKey(inputKey.trim());

        if (isValidKey) {
            setMessage({ type: 'success', text: 'Clave de API válida y guardada correctamente' });
        } else {
            setMessage({ type: 'error', text: 'La clave de API no es válida. Por favor, verifica e intenta nuevamente.' });
        }
    };

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setInputKey(e.target.value);
        setMessage(null);
    };

    return (
        <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
            <div className="max-w-md w-full bg-white rounded-lg shadow-md p-6">
                <div className="text-center mb-6">
                    <h1 className="text-2xl font-bold text-gray-900 mb-2">
                        Configuración de OpenRouter
                    </h1>
                    <p className="text-gray-600">
                        Introduce tu clave de API de OpenRouter para comenzar a chatear
                    </p>
                </div>

                <div className="space-y-4">
                    <div>
                        <label htmlFor="apiKey" className="block text-sm font-medium text-gray-700 mb-2">
                            Clave de API
                        </label>
                        <div className="relative">
                            <input
                                id="apiKey"
                                type={showKey ? 'text' : 'password'}
                                value={inputKey}
                                onChange={handleInputChange}
                                placeholder="sk-or-v1-..."
                                className="w-full px-3 py-2 pr-20 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                                disabled={isLoading}
                            />
                            <button
                                type="button"
                                onClick={() => setShowKey(!showKey)}
                                className="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
                                disabled={isLoading}
                            >
                                {showKey ? <EyeOff size={20} /> : <Eye size={20} />}
                            </button>
                        </div>
                    </div>

                    {message && (
                        <div className={`flex items-center space-x-2 p-3 rounded-md ${message.type === 'success'
                                ? 'bg-green-50 text-green-800 border border-green-200'
                                : 'bg-red-50 text-red-800 border border-red-200'
                            }`}>
                            {message.type === 'success' ? (
                                <CheckCircle size={20} className="flex-shrink-0" />
                            ) : (
                                <XCircle size={20} className="flex-shrink-0" />
                            )}
                            <span className="text-sm">{message.text}</span>
                        </div>
                    )}

                    <button
                        onClick={handleSave}
                        disabled={isLoading || !inputKey.trim()}
                        className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center space-x-2"
                    >
                        {isLoading ? (
                            <>
                                <Loader2 size={20} className="animate-spin" />
                                <span>Validando...</span>
                            </>
                        ) : (
                            <span>Guardar</span>
                        )}
                    </button>

                    {isValid && (
                        <div className="text-center">
                            <p className="text-sm text-green-600 font-medium">
                                ✓ Clave de API configurada correctamente
                            </p>
                        </div>
                    )}
                </div>

                <div className="mt-6 text-center">
                    <p className="text-xs text-gray-500">
                        No tienes una clave de API?{' '}
                        <a
                            href="https://openrouter.ai/keys"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-blue-600 hover:text-blue-800 underline"
                        >
                            Obtener una aquí
                        </a>
                    </p>
                </div>
            </div>
        </div>
    );
};

export default ApiKeyConfiguration;
