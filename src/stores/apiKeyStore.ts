import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { ApiKeyState, ApiKeyActions } from '../types';

interface ApiKeyStore extends ApiKeyState, ApiKeyActions { }

export const useApiKeyStore = create<ApiKeyStore>()(
    persist(
        (set) => ({
            apiKey: null,
            isValid: null,
            isLoading: false,

            setApiKey: (key: string) => {
                set({ apiKey: key });
            },

            validateApiKey: async (key: string): Promise<boolean> => {
                set({ isLoading: true });

                try {
                    // Validar la clave de API contra OpenRouter
                    const response = await fetch('https://openrouter.ai/api/v1/models', {
                        headers: {
                            'Authorization': `Bearer ${key}`,
                            'Content-Type': 'application/json',
                        },
                    });

                    const isValid = response.ok;
                    set({ isValid, apiKey: key });
                    return isValid;
                } catch (error) {
                    console.error('Error validating API key:', error);
                    set({ isValid: false });
                    return false;
                } finally {
                    set({ isLoading: false });
                }
            },

            clearApiKey: () => {
                set({ apiKey: null, isValid: null });
            },
        }),
        {
            name: 'api-key-storage',
            partialize: (state) => ({ apiKey: state.apiKey }),
        }
    )
);
