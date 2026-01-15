import 'package:draftly/shared/constants/asset_paths.dart';
import 'package:flutter/material.dart';

class DraftlyScaffold extends StatelessWidget {
  final Widget body;
  final bool isScrollable;
  final Widget? bottomChild;

  const DraftlyScaffold({
    super.key,
    required this.body,
    this.isScrollable = false,
    this.bottomChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ImageAsset.background,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ImageAsset.backgroundPattern,
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: isScrollable
                          ? SingleChildScrollView(child: paddedBody)
                          : paddedBody,
                    ),
                    if (bottomChild != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: bottomChild!,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get paddedBody =>
      Padding(padding: const EdgeInsets.all(20), child: body);
}
