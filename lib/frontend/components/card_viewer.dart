import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardList extends StatefulWidget {
  final CardInformation information;
  const CardList({super.key, required this.information});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    final cardPackDao = context.read<CardsDao>();
    final info = widget.information;
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
              info.cardPack.id == newItemsId ? "Recent" : info.cardPack.name),
        ),
        SliverAnimatedList(
          itemBuilder: (context, index, animation) {
            final item = info.terms[index];
            return Padding(
              padding: const EdgeInsets.all(0),
              child: _CardViewerItem(item: item),
            );
          },
          initialItemCount: info.terms.length,
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ))
      ],
    );
  }
}

class _CardViewerItem extends StatelessWidget {
  const _CardViewerItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DisplayTerm item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.topCenter,
                child: Text(
                  item.text,
                  style: theme.textTheme.titleMedium?.copyWith(),
                ),
              ),
              flex: 2,
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Icon(Icons.arrow_forward_ios_rounded,
                  color: theme.colorScheme.onSurface.withOpacity(0.6)),
            )),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: item.connections
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(e.text),
                        ))
                    .toList(),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
