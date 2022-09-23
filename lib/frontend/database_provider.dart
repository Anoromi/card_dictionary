import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wordnet_dictionary_app/backend/card_database.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class DatabaseProvider extends SingleChildStatelessWidget {
  const DatabaseProvider({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Provider(
        create: (context) => AppDatabase(),
        builder: (context, _) {
          final database = context.read<AppDatabase>();
          return MultiProvider(
            providers:  [
              Provider(
                create: (context) => database.cardsDao,
                lazy: false,
              ),
              Provider(
                create: (context) => database.recentsDao,
                lazy: false,
              ),
            ],
            child: child,
          );
        });
  }
}
