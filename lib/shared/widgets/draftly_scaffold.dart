import 'dart:ui';

import 'package:flutter/material.dart';

import '/shared/constants/asset_paths.dart';

class DraftlyScaffold extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final Widget? trailing;

  final Widget body;
  final bool isScrollable;
  final Widget? bottomChild;

  const DraftlyScaffold({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    required this.body,
    this.isScrollable = false,
    this.bottomChild,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              flexibleSpace: backgroundAppBar(),
              leading: leading,
              actions: trailing != null ? [trailing!] : null,
            )
          : null,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ImageAsset.background,
              fit: BoxFit.cover,
            ),
          ),
          child: DecoratedBox(
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

  Widget backgroundAppBar() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const ShapeDecoration(
        color: Color(0x66E3E3E3),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xB8382752),
                blurRadius: 30,
                spreadRadius: 20,
              ),
            ],
          ),
          child: Column(),
        ),
      ),
    );
  }
}
