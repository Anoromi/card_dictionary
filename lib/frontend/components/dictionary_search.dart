import 'dart:async';

import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/frontend/model/dictionary_model.dart';
import 'package:wordnet_dictionary_app/frontend/model/search_screen_model.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class SuggestionListController extends StatefulWidget {
  const SuggestionListController({Key? key}) : super(key: key);

  @override
  State<SuggestionListController> createState() =>
      _SuggestionListControllerState();
}

class _SuggestionListControllerState extends State<SuggestionListController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DictionaryModel>(
      future: DictionaryModel.create(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return ChangeNotifierProvider(
            create: ((context) => data),
            child: const SuggestionList(),
          );
        } else {
          return const SizedBox(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  String previousSuggestion = "";
  Future<List<PartialTerm>>? suggestions;
  bool loaded = false;
  CommonLoadingState cml = CommonLoadingState.closed;
  final displayedSuggestions = StreamController<List<PartialTerm>>();

  void updateLoadingDelayed(String cur, DictionaryModel m) async {
    if (cur == previousSuggestion) {
      return;
    }
    setState(() {
      previousSuggestion = cur;
      loaded = false;
      suggestions = m.suggestions(cur).then((value) async {
        setState(() {
          loaded = true;
        });
        return value.b!;
      });
      loaded = true;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    if (cur == previousSuggestion && loaded == true) {
      setState(() {
        cml = CommonLoadingState.loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DictionaryModel>(
      builder: (context, dictionaryModel, child) =>
          Selector<SearchScreenModel, String>(
        selector: (p0, p1) => p1.text,
        builder: ((context, searchModel, child) {
          if (previousSuggestion != searchModel) {
            previousSuggestion = searchModel;
            if (previousSuggestion.isNotEmpty) {
              dictionaryModel.suggestions(previousSuggestion).then((value) {
                if (previousSuggestion == value.a && value.b != null) {
                  displayedSuggestions.add(value.b!);
                }
              });
            }
          }
          return StreamBuilder<List<PartialTerm>>(
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) return Container();
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, i) => SuggestionItem(
                      term: data[i],
                      key: ValueKey(data[i]),
                    ),
                    reverse: true,
                    itemCount: data.length,
                  )
                  );
            },
            stream: displayedSuggestions.stream,
          );
        }),
      ),
    );
  }
}

enum CommonLoadingState { closed, loading, opened }

class SuggestionItem extends StatefulWidget {
  final PartialTerm term;
  const SuggestionItem({Key? key, required this.term}) : super(key: key);

  @override
  State<SuggestionItem> createState() => _SuggestionItemState();
}

class _SuggestionItemState extends State<SuggestionItem>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  FullTerm? fullTerm;
  Future<void>? termSearch;
  bool _expanded = false;

  bool get expanded => _expanded;

  set expanded(bool expanded) {
    _expanded = expanded;
    updateKeepAlive();
  }

  void openClose(DictionaryModel dictionaryModel) {
    if (!expanded) {
      if (fullTerm == null && termSearch == null) {
        termSearch = dictionaryModel.unwrap(widget.term).then((value) {
          setState(() {
            fullTerm = value.b;
            expanded = true;
          });
        });
      } else if (fullTerm != null) {
        setState(() {
          expanded = true;
        });
      }
    } else {
      setState(() {
        expanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    final dictionaryModel = context.watch<DictionaryModel>();
    final elevationLevel = expanded ? 5.0 : 0.0;
    final titleStyle = expanded
        ? theme.textTheme.displaySmall!.copyWith(
            color: theme.colorScheme.onSurface, fontWeight: FontWeight.w900)
        : theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface);
    final radius = BorderRadius.circular(15);

    return Material(
      borderRadius: radius,
      clipBehavior: Clip.hardEdge,
      elevation: elevationLevel,
      // color: theme.colorScheme.background,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FullTermItem(
              term: fullTerm,
              expanded: expanded,
            ),
            Material(
              borderRadius: radius,
              clipBehavior: Clip.antiAlias,
              type: MaterialType.transparency,
              child: InkWell(
                splashFactory: InkSparkle.splashFactory,
                onTap: () => openClose(dictionaryModel),
                child: AnimatedPadding(
                    padding: EdgeInsets.all(expanded ? 15 : 8),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedDefaultTextStyle(
                      child: Text(
                        widget.term.term,
                        // style: theme.textTheme.headlineSmall,
                      ),
                      duration: const Duration(milliseconds: 300),
                      style: titleStyle,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => expanded;
}

class FullTermItem extends StatelessWidget {
  final FullTerm? term;
  final bool expanded;
  const FullTermItem({Key? key, required this.term, required this.expanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardDao = context.read<CardsDao>();

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: !expanded
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  term?.data.length ?? 0,
                  (index) {
                    final data = term!.data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            data.wordType.typeToName(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                          Text(data.words.join(", "),
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 4,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "Definition: ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary)),
                            TextSpan(text: data.definition)
                          ])),
                          Container(
                            alignment: Alignment.centerRight,
                            child: _DefinitionExistenceIndicator(
                                term: term!.term,
                                definition: data.definition,
                                onAdd: () {
                                  cardDao.addToNew(term!, data);
                                }),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

extension Name on WordType {
  String typeToName() {
    switch (this) {
      case WordType.Noun:
        return "noun";
      case WordType.Verb:
        return "verb";
      case WordType.Adjective:
        return "adjective";
      case WordType.Satellite:
        return "satellite";
      case WordType.Adverb:
        return "adverb";
    }
  }
}

class _DefinitionExistenceIndicator extends StatefulWidget {
  final String term;
  final String definition;
  final VoidCallback onAdd;
  _DefinitionExistenceIndicator(
      {required this.term, required this.definition, required this.onAdd})
      : super(key: ValueKey(definition));

  @override
  State<_DefinitionExistenceIndicator> createState() =>
      _DefinitionExistenceIndicatorState();
}

class _DefinitionExistenceIndicatorState
    extends State<_DefinitionExistenceIndicator> {
  Future? loadingData;
  UseOption? data;

  void add() {
    widget.onAdd();
    setState(() {
      data = UseOption.inRecent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardDao = context.read<CardsDao>();
    loadingData ??= cardDao.used(widget.term, widget.definition).then((value) {
      setState(() {
        data = value;
      });
    });
    Widget animated({required double value, required Widget child}) {
      return AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: child,
      );
    }

    if (data == null) {
      return animated(value: 0, child: const SizedBox());
    } else {
      final data = this.data!;
      final theme = Theme.of(context);
      switch (data) {
        case UseOption.inRecent:
          return animated(
              value: 1,
              child: Text(
                "In recent",
                style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.secondary),
              ));
        case UseOption.exists:
          return animated(
              value: 1,
              child: TextButton(
                  onPressed: add, child: const Text("Add to cards")));
        case UseOption.no:
          return animated(
              value: 1,
              child: TextButton(
                  onPressed: add, child: const Text("Add to cards")));
      }
    }
  }
}
