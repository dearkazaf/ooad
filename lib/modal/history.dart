import 'dart:convert';
import 'dart:io';

import 'package:mahjong_cal/data_entity/record/match_record.dart';
import 'package:path_provider/path_provider.dart';

class History {
  List<MatchRecord> _histories = [];

  List<MatchRecord> get histories => _histories;

  Future<void> loadFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    File historyFile = File('${dir.path}/history.json');
    if (!historyFile.existsSync()) return;
    _histories = (jsonDecode(historyFile.readAsStringSync()) as List<dynamic>)
        .map((e) => MatchRecord.fromJson(e))
        .toList();
  }

  Future<void> addRecord(MatchRecord record) async {
    _histories.insert(0, record);
    Directory dir = await getApplicationDocumentsDirectory();
    File historyFile = File('${dir.path}/history.json');
    if (!historyFile.existsSync()) {
      historyFile.createSync(recursive: true);
    }
    historyFile.writeAsStringSync(jsonEncode(histories));
  }
}
