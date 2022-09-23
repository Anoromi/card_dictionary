import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/backend/card_database.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardPackList extends StatefulWidget {
  final void Function(int index) open;
  const CardPackList({super.key, required this.open});

  @override
  State<CardPackList> createState() => _CardPackListState();
}

class _CardPackListState extends State<CardPackList> {
  HashMap<int, Stream<List<CardPackData>>> providers = HashMap();
  static const int offset = 50;

  Stream<CardPackData> request(int index) {
    final cardDao = context.read<CardsDao>();
    final leveled = index % offset;
    final indexOffset = index - leveled;
    return providers
        .putIfAbsent(
            indexOffset,
            () => cardDao
                .watchRecentCardPacks(indexOffset, offset)
                .asBroadcastStream())
        .map((event) {
      return event[leveled];
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardDao = context.read<CardsDao>();
    final theme = Theme.of(context);
    final cardTitles = theme.textTheme.titleLarge
        ?.copyWith(color: theme.colorScheme.onSurface);
    return FutureBuilder<int>(
      future: cardDao.getCardPacksCount(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: const Text("All card packs"),
            ),
            SliverAnimatedList(
              initialItemCount: snapshot.data!,
              itemBuilder: (context, index, animation) =>
                  StreamBuilder<CardPackData>(
                      stream: request(index),
                      builder: (context, snapshot) {
                        Widget opacity(double opacity, Widget child) {
                          return AnimatedScale(
                            child: child,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            scale: opacity,
                            alignment: Alignment.center,
                          );
                        }

                        if (!snapshot.hasData) {
                          return opacity(0, const SizedBox());
                        } else {
                          final item = snapshot.data!;
                          return opacity(
                              1,
                              Card(
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () => widget.open(item.id),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          item.name,
                                          style: cardTitles,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }
                      }),
            ),
          ],
        );
      },
    );
  }
}
