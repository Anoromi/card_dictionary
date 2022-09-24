import 'package:wordnet_dictionary_app/frontend/components/card_definition.dart';
import 'package:wordnet_dictionary_app/frontend/material/custom_color.dart';
import 'package:wordnet_dictionary_app/frontend/pages/card_player.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class PlayResultsScreen extends StatefulWidget {
  final ResultsData data;
  const PlayResultsScreen({super.key, required this.data});

  @override
  State<PlayResultsScreen> createState() => _PlayResultsScreenState();
}

class _PlayResultsScreenState extends State<PlayResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Results"),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.playData.cardInformation.name.name,
                  style: theme.textTheme.displayMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    "${widget.data.rememberedIndexes.length}/${widget.data.cards.length}",
                    style: theme.textTheme.displaySmall,
                  ),
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final card = widget.data.cards[index];
            final gotRight = widget.data.rememberedIndexes.contains(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                // color: gotRight
                //     ? theme.colorScheme.surface
                //     : theme.colorScheme.errorContainer,
                color: theme.colorScheme.surface,
                surfaceTintColor: gotRight
                    ? theme.custom.greenContainer
                    : theme.colorScheme.errorContainer,
                elevation: 3,
                // textStyle: theme.textTheme.bodyLarge.copyWith(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: CardDefinition(
                    front: card.front,
                    back: card.back,
                    mode: DisplayMode.fromPlayMode(widget.data.playData.mode),
                    textColor: gotRight
                        ? theme.custom.onGreenContainer!
                        : theme.colorScheme.onErrorContainer),
              ),
            );
          }, childCount: widget.data.cards.length),
        )
      ]),
    );
  }
}

class ResultsData {
  final PlayData playData;
  final List<CardData> cards;
  final Set<int> rememberedIndexes;
  ResultsData(this.playData, this.cards, this.rememberedIndexes);
}
