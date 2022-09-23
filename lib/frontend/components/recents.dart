import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class RecentTerms extends StatefulWidget {
  const RecentTerms({super.key});

  @override
  State<RecentTerms> createState() => _RecentTermsState();
}

class _RecentTermsState extends State<RecentTerms> {
  // int resolveLoad(int index) {

  // }

  @override
  Widget build(BuildContext context) {
    final recentsDao = context.read<RecentsDao>();

    // AnimatedListState();
    // AnimatedList();
    return StreamBuilder<int>(
      stream: recentsDao.recentsCount(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          final length = snapshot.data!;
          return AnimatedList(
            initialItemCount: length,
            itemBuilder: (context, index, animation) {
              return Container();
              // return Dismissible(key: const ValueKey(), child: child)
            },
            reverse: true,
          );
        }
      },
    );
    // return FutureBuilder(builder: , future: ,
    // );
  }
}
