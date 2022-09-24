import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/frontend/components/play_card.dart';
import 'package:wordnet_dictionary_app/frontend/material/custom_color.dart';
import 'package:wordnet_dictionary_app/frontend/pages/results_screen.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardPlayerScreen extends StatefulWidget {
  final PlayData data;
  const CardPlayerScreen({super.key, required this.data});

  @override
  State<CardPlayerScreen> createState() => _CardPlayerScreenState();
}

class CardData {
  final String front;
  final List<String> back;
  CardData(this.front, this.back);
}

class _CardPlayerScreenState extends State<CardPlayerScreen> {
  var currentIndex = 0;
  var currentFront = true;
  Set<int> rememberedIndexes = {};
  late List<CardData> cardData;

  void nextCard() {
    setState(() {
      currentIndex++;
      currentFront = true;
    });
  }

  void turn() {
    setState(() {
      currentFront = !currentFront;
    });
  }

  void remembered() {
    rememberedIndexes.add(currentIndex);
    move();
  }

  void forgot() {
    move();
  }

  void move() {
    if (currentIndex + 1 == cardData.length) {
      // context.pop();
      context.replaceNamed("play_results",
          extra: ResultsData(widget.data, cardData, rememberedIndexes));
    } else {
      nextCard();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardData = [];
    if (widget.data.mode == PlayMode.term) {
      cardData.addAll(widget.data.cardInformation.terms.map(
          (e) => CardData(e.text, e.connections.map((e) => e.text).toList())));
    } else {
      cardData.addAll(widget.data.cardInformation.definitions.map(
          (e) => CardData(e.text, e.connections.map((e) => e.text).toList())));
    }
    shuffle();
  }

  void shuffle() {
    final r = Random();
    for (var i = cardData.length - 1; i > 0; i--) {
      final ind = r.nextInt(i + 1);
      final v = cardData[ind];
      cardData[ind] = cardData[i];
      cardData[i] = v;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.data.cardInformation.terms.isNotEmpty &&
        widget.data.cardInformation.definitions.isNotEmpty);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  "${currentIndex + 1}/${cardData.length}",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 250, maxWidth: 350),
                          child: SizedBox.expand(
                            child: PlayCard(
                                front: cardData[currentIndex].front,
                                back: cardData[currentIndex].back,
                                currentFront: currentFront),
                          ),
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: turn,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                          child: currentFront
                              ? const Text("Show", key: ValueKey("Show"))
                              : const Text("Back", key: ValueKey("Back")),
                        ),
                        style: ElevatedButton.styleFrom(
                            textStyle: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: forgot,
                            child: const Text("Forgot"),
                            style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.error,
                                textStyle: theme.textTheme.titleLarge),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: remembered,
                              child: const Text(
                                "Remembered",
                              ),
                              style: TextButton.styleFrom(
                                  foregroundColor: theme.custom.green,
                                  textStyle: theme.textTheme.titleLarge)),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                    flex: 2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayData {
  final CardInformation cardInformation;
  final PlayMode mode;
  const PlayData(this.cardInformation, this.mode);
}

enum PlayMode {
  term,
  definition;

  String stringify() {
    switch (this) {
      case PlayMode.term:
        return "term";
      case PlayMode.definition:
        return "definition";
    }
  }

  static PlayMode fromString(String name) {
    switch (name) {
      case "term":
        return PlayMode.term;
      case "definition":
        return PlayMode.definition;
      default:
        throw ArgumentError(name);
    }
  }
}
