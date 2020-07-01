abstract class AppEnvironment {
  static String headerKey;
  static String apiUrl;
  static setupEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        {
          headerKey = "Auth";
          apiUrl = "https://api-todo-flutter.herokuapp.com/";
          break;
        }

      case Environment.prod:
        {
          headerKey = "Auth";
          apiUrl = "https://api-todo-flutter.herokuapp.com/";
          break;
        }
    }
  }
}

enum Environment { dev, prod }
