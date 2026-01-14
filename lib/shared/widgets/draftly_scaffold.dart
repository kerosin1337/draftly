import 'package:flutter/material.dart';

class DraftlyScaffold extends StatelessWidget {
  final Widget body;
  final bool isScrollable;

  const DraftlyScaffold({
    super.key,
    required this.body,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: isScrollable ? SingleChildScrollView(child: body) : body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
