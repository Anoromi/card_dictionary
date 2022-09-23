import 'package:go_router/go_router.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/frontend/components/card_pack_list.dart';
import 'package:wordnet_dictionary_app/frontend/components/main_navigation_bar.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardPackScreen extends StatelessWidget {
  const CardPackScreen({super.key});

  void openCard(BuildContext context, int index) {
    context.goNamed('card', params: {'cardId': index.toString()});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CardPackList(open: (index) => openCard(context, index)),
      bottomNavigationBar: const MainNavigationBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openCard(context, newItemsId),
        label: const Text("Added"),
        icon: const Icon(Icons.fiber_new_rounded),
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
