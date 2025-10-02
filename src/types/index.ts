export interface ApiKeyState {
  apiKey: string | null;
  isValid: boolean | null;
  isLoading: boolean;
}

export interface ApiKeyActions {
  setApiKey: (key: string) => void;
  validateApiKey: (key: string) => Promise<boolean>;
  clearApiKey: () => void;
}
