import 'package:draftly/shared/widgets/draftly_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/shared/widgets/draftly_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    return DraftlyScaffold(
      body: Column(children: []),
      bottomChild: DraftlyButton(
        text: 'Создать',
        onPressed: handleNavigatePainter,
      ),
    );
  }

  void handleNavigatePainter() {
    context.push('/painter');
  }
}
