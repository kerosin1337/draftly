const Map<String, String> _errorMessage = {
  'invalid-credential': 'Неправильный логин или пароль',
  'email-already-in-use': 'Пользователь уже существует',
  'password-match-validator': 'Пароли не совпадают',

  'unknown-error': 'Неизвестная ошибка',

  'disconnected': 'Отсутсвует подключение к интернету',
  'connected': 'Подключение к интернету восстановленно',
};

String getErrorMessage(String code) {
  return _errorMessage[code] ?? _errorMessage['unknown-error']!;
}
