import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';

import '/core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Draftly',
      theme: appTheme,
      builder: (context, child) {
        if (child != null) {
          return Inspector(isEnabled: kDebugMode, child: child);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
