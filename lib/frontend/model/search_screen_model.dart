import 'package:wordnet_dictionary_app/lib.dart';

enum SearchScreenState { search, recents }

class SearchScreenModel with ChangeNotifier {
  SearchScreenState _state = SearchScreenState.search;

  SearchScreenState get state => _state;

  set state(SearchScreenState state) {
    _state = state;
    notifyListeners();
  }

  late final _text = TextEditingController(text: "")
    ..addListener(() {
      notifyListeners();
    });
  String get text => _text.text;
  set text(String t) {
    _text.text = t;
    notifyListeners();
  }

  TextEditingController get textController => _text;


  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }
}
