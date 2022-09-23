import 'package:wordnet_dictionary_app/lib.dart';

enum MainRoutes {
  dictionary,
  cardPacks;

  String routeName() {
    switch (this) {
      case MainRoutes.dictionary:
        return 'dictionary';
      case MainRoutes.cardPacks:
        return 'cards';
    }
  }
}

class MainNavigationModel with ChangeNotifier {
  MainRoutes _currentRoute = MainRoutes.dictionary;

  MainRoutes get currentRoute => _currentRoute;

  set currentRoute(MainRoutes currentRoute) {
    _currentRoute = currentRoute;
    notifyListeners();
  }
}
