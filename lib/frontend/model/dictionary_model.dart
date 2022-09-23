import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordnet_dictionary_app/bridge_generated.dart';
import 'package:wordnet_dictionary_app/main.dart';
import 'package:worker_configuration/worker_configuration.dart';

const dictionaryPath = "dictionary";

class DictionaryModel with ChangeNotifier {
  static Future<void> _copyAsset(String assetPath, String toPath) async {
    const indexData = "indexData";
    const indexReference = "indexReference";
    const indexWords = "indexWords";
    const relationData = "relationData";
    const relationReference = "relationReference";
    await Directory(toPath).create(recursive: true);
    Future<void> copy(String from, String to) async {
      var bytes = await rootBundle.load(from);

      var out = (await File(to).create()).openWrite();
      out.add(bytes.buffer.asUint8List());
      await out.flush();
    }

    await Future.wait([
      copy("$assetPath/$indexData", "$toPath/$indexData"),
      copy("$assetPath/$indexReference", "$toPath/$indexReference"),
      copy("$assetPath/$indexWords", "$toPath/$indexWords"),
      copy("$assetPath/$relationData", "$toPath/$relationData"),
      copy("$assetPath/$relationReference", "$toPath/$relationReference"),
    ]);
  }

  Future<Pair<String, List<PartialTerm>?>> suggestions(String text) async {
    print("start passing ${DateTime.now()}");
    final result = await api.findSuggestions(text: text, count: 20);
    print("end ${DateTime.now()}");
    return Pair(text, result);
  }

  Future<Pair<PartialTerm, FullTerm>> unwrap(PartialTerm t) async {
    return Pair(t, await api.unwrapTerm(term: t));
  }

  static Future<void> _loadData() async {
    var dir = (await getApplicationSupportDirectory()).path;
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      _copyAsset("assets/data/noun", "$dir/dictionary/noun"),
      _copyAsset("assets/data/adjective", "$dir/dictionary/adjective"),
      _copyAsset("assets/data/adverb", "$dir/dictionary/adverb"),
      _copyAsset("assets/data/verb", "$dir/dictionary/verb"),
    ]);
  }

  static Future<DictionaryModel> create() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getBool("values-loaded") != true) {
      await _loadData();
      pref.setBool("values-loaded", true);
    }

    var rep = "${(await getApplicationSupportDirectory()).path}/dictionary";
    await api.tryInit(path: rep);
    return DictionaryModel();
  }
}

Future<void> _loadData() async {
  var dir = (await getApplicationSupportDirectory()).path;

  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    DictionaryModel._copyAsset("assets/data/noun", "$dir/dictionary/noun"),
    DictionaryModel._copyAsset(
        "assets/data/adjective", "$dir/dictionary/adjective"),
    DictionaryModel._copyAsset("assets/data/adverb", "$dir/dictionary/adverb"),
    DictionaryModel._copyAsset("assets/data/verb", "$dir/dictionary/verb"),
  ]);
}
