import 'package:flutter/material.dart';

import 'app/app_module.dart';
import 'package:firebase_core/firebase_core.dart';

void main ()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppModule());
}
