import 'package:flutter/material.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    bool isKeyboardVisible,
    Widget? child,
  )
  builder;
  final Widget? child;

  const KeyboardVisibilityBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  @override
  State<KeyboardVisibilityBuilder> createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  final isKeyboardVisible = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    isKeyboardVisible.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newValue = bottomInset > 0;
    if (newValue != isKeyboardVisible.value) {
      isKeyboardVisible.value = newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isKeyboardVisible,
      builder: (context, value, child) {
        return widget.builder(context, value, widget.child);
      },
    );
  }
}
