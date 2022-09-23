import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/frontend/components/dictionary_search.dart';
import 'package:wordnet_dictionary_app/frontend/components/main_navigation_bar.dart';
import 'package:wordnet_dictionary_app/frontend/components/recents.dart';
import 'package:wordnet_dictionary_app/frontend/model/search_screen_model.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  var alignment = MainAxisAlignment.end;
  late AnimationController _animationController;
  late Animation _animation;
  late var focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0),
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    _animation =
        IntTween(begin: 4 * 100, end: 10).animate(_animationController);
    _animation.addListener(animationUpdate);
    var keyVisContr = KeyboardVisibilityController();
    keyboardSubscription = keyVisContr.onChange.listen((event) {
      if (event) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void animationUpdate() {
    setState(() {});
  }

  void updateAlignment(MainAxisAlignment alignment) {
    if (this.alignment != alignment) {
      setState(() {
        this.alignment = alignment;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      bottomNavigationBar: const MainNavigationBar(),
      body: ChangeNotifierProvider(
        create: (context) => SearchScreenModel(),
        builder: (context, _) {
          final searchModel =
              context.select<SearchScreenModel, SearchScreenState>(
                  (value) => value.state);
          Widget stateToSearch() {
            switch (searchModel) {
              case SearchScreenState.search:
                return SuggestionListController();
              case SearchScreenState.recents:
                return const RecentTerms();
            }
          }

          return Column(
            mainAxisAlignment: alignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: AnimatedSwitcher(
                    child: stateToSearch(),
                    duration: const Duration(milliseconds: 500),
                  ),
                  flex: 20 * 100),
              const SearchBar(),
              Expanded(child: Container(), flex: _animation.value),
            ],
          );
        },
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  void actionIconClicked(SearchScreenModel searchModel) {
    if (searchModel.text.isNotEmpty) {
      searchModel.text = "";
    } else {
      switch (searchModel.state) {
        case SearchScreenState.search:
          searchModel.state = SearchScreenState.recents;
          break;
        case SearchScreenState.recents:
          searchModel.state = SearchScreenState.search;
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchModel = context.watch<SearchScreenModel>();

    IconData actionIcon;
    if (searchModel.text.isNotEmpty) {
      actionIcon = Icons.close_outlined;
    } else {
      switch (searchModel.state) {
        case SearchScreenState.search:
          actionIcon = Icons.history;
          break;
        case SearchScreenState.recents:
          actionIcon = Icons.search_rounded;
          break;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchModel.textController,
              decoration: InputDecoration(
                  border: searchBorder(theme),
                  enabledBorder: searchBorder(theme),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                        width: 2.4,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  label: const Text("Search")),
              style: TextStyle(
                  inherit: true,
                  fontSize: theme.textTheme.titleMedium?.fontSize),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: FloatingActionButton(
                onPressed: () => actionIconClicked(searchModel),
                elevation: 0,
                backgroundColor: theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    actionIcon,
                    size: 30,
                  ),
                )),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder searchBorder(ThemeData theme) => OutlineInputBorder(
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15)),
    borderSide: BorderSide(color: theme.colorScheme.outline, width: 2));
