import 'dart:async';
import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/backend/card_database.dart';
import 'package:wordnet_dictionary_app/frontend/material/theme_mixin.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardPackList extends StatefulWidget {
  final void Function(int index) open;
  const CardPackList({super.key, required this.open});

  @override
  State<CardPackList> createState() => _CardPackListState();
}

class ListSubscription {
  final int offset;
  final ValueStream<List<CardPackData>> stream;
  final Set<int> subscribedIndexes = {};

  ListSubscription(
      {required Stream<List<CardPackData>> stream, required this.offset})
      : stream = stream.shareValue();

  Stream<CardPackData> request(int index) {
    // assert(!subscribedIndexes.contains(index));
    subscribedIndexes.add(index);
    final leveled = index % offset;
    return stream.map((event) => event[leveled]);
  }

  bool finish(int index) {
    subscribedIndexes.remove(index);
    return subscribedIndexes.isEmpty;
  }
}

class _CardPackListState extends State<CardPackList> {
  HashMap<int, ListSubscription> providers = HashMap();

  static const int offset = 50;
  List<int> selected = [];

  Stream<CardPackData> request(int index) {
    final cardDao = context.read<CardsDao>();

    final leveled = index % offset;
    final indexOffset = index - leveled;

    return providers.putIfAbsent(indexOffset, () {
      return ListSubscription(
          stream: cardDao.watchRecentCardPacks(indexOffset, offset),
          offset: offset);
    }).request(index);
  }

  void finish(int index) {
    // assert(providers.containsKey(index));
    final indexOffset = index - (index % offset);
    final provider = providers[indexOffset]!;
    if (provider.finish(index)) {
      providers.remove(indexOffset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardDao = context.read<CardsDao>();
    final theme = Theme.of(context);
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
              itemBuilder: (context, index, animation) => _CardPackListItem(
                  stream: request(index),
                  open: widget.open,
                  dispose: () => finish(index)),
            ),
          ],
        );
      },
    );
  }
}

class _CardPackListItem extends StatefulWidget {
  final Stream<CardPackData> stream;
  final VoidCallback dispose;
  final Function(int id) open;

  const _CardPackListItem({
    required this.stream,
    required this.open,
    required this.dispose,
  });

  @override
  State<_CardPackListItem> createState() => __CardPackListItemState();
}

class __CardPackListItemState extends State<_CardPackListItem>
    with StatefulThemeMixin {
  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget buildWith(BuildContext context) {
    final cardTitles = theme.textTheme.titleLarge
        ?.copyWith(color: theme.colorScheme.onSurface);
    return StreamBuilder<CardPackData>(
        stream: widget.stream,
        builder: (context, snapshot) {
          Widget animate(double value, Widget child) {
            return AnimatedScale(
              child: child,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              scale: value,
              alignment: Alignment.center,
            );
          }

          print(snapshot.connectionState);
          if (!snapshot.hasData) {
            return Container(
              height: 30,
            );
            // animate(
            //     0,
            //     const SizedBox(
            //       height: 20,
            //     ));
          } else {
            final item = snapshot.data!;

            return Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () => widget.open(item.id),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        item.name,
                        style: cardTitles,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}


// class SingleBufferedStream<T> extends Stream<T> {
//   final Stream<T> stream;
//   late final StreamSubscription lastItemSubscription = stream.listen((event) {
//     previousValue = event;
//   });
//   T? previousValue;
//   // List<StreamSubscription> subscribers = [];

//   SingleBufferedStream(Stream<T> stream) : stream = stream.asBroadcastStream();

//   @override
//   StreamSubscription<T> listen(void Function(T event)? onData,
//       {Function? onError, void Function()? onDone, bool? cancelOnError}) {
//     final controller = StreamController<T>();
//     controller.
//     final value = StreamZip(
//             [if (previousValue != null) Stream.value(previousValue!), stream])
//         .listen(onData,
//             onError: onError, onDone: onDone, cancelOnError: cancelOnError);
//     // if () ;
//     // throw UnimplementedError();
//   }
//
//   @override
//   bool get isBroadcast => true;
// }