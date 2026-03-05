import 'package:flutter/material.dart';

import 'app.dart';
import 'core/network/token_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenStorage.init();
  runApp(const App());
}
