import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '/features/painter/presentation/screens/painter_screen.dart';
import '/shared/constants/asset_paths.dart';
import 'draftly_icon_button.dart';

class PainterActions extends StatelessWidget {
  final DrawingController drawingController;
  final ValueNotifier<PainterData> painterDataNotifier;

  const PainterActions({
    super.key,
    required this.drawingController,
    required this.painterDataNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Builder(
          builder: (context) {
            return DraftlyIconButton(
              assetName: SvgAsset.linearDownload,
              onPressed: handleDownload(context),
            );
          },
        ),
        DraftlyIconButton(
          assetName: SvgAsset.boldGallery,
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              painterDataNotifier.value = painterDataNotifier.value.copyWith(
                imagePath: () => image.path,
              );
            }
          },
        ),
        Builder(
          builder: (context) {
            return DraftlyIconButton(
              assetName: SvgAsset.boldEdit,
              onPressed: () {
                drawingController.setPaintContent(SimpleLine());
                final offset = (context.findRenderObject() as RenderBox)
                    .localToGlobal(Offset.zero);
                showMenu<dynamic>(
                  useRootNavigator: true,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy,
                    100000,
                    0,
                  ),
                  popUpAnimationStyle: AnimationStyle.noAnimation,
                  constraints: const BoxConstraints(),
                  items: [
                    PopupMenuItem(
                      enabled: false,
                      height: 0,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Column(
                          spacing: 8,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: drawingController.drawConfig,
                              builder: (context, value, child) {
                                return Slider(
                                  value: drawingController
                                      .drawConfig
                                      .value
                                      .strokeWidth,
                                  max: 50,
                                  min: 1,
                                  onChanged: (value) {
                                    drawingController.setStyle(
                                      strokeWidth: value,
                                    );
                                  },
                                );
                              },
                            ),
                            colorsGrid(context, true),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        DraftlyIconButton(
          assetName: SvgAsset.boldErase,
          onPressed: () => drawingController.setPaintContent(Eraser()),
        ),
        Builder(
          builder: (context) {
            return DraftlyIconButton(
              assetName: SvgAsset.boldPalette,
              onPressed: () async {
                final offset = (context.findRenderObject() as RenderBox)
                    .localToGlobal(Offset.zero);
                showMenu<dynamic>(
                  useRootNavigator: true,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy,
                    100000,
                    0,
                  ),
                  popUpAnimationStyle: AnimationStyle.noAnimation,
                  constraints: const BoxConstraints(),
                  items: [
                    PopupMenuItem(
                      height: 0,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: colorsGrid(context),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget colorsGrid(BuildContext context, [bool isBrush = false]) {
    return Column(
      children: Colors.primaries.reversed
          .map(
            (materialColor) => Row(
              mainAxisSize: MainAxisSize.min,
              children: materialColor.keys
                  .map(
                    (shade) => GestureDetector(
                      onTap: () {
                        final newBackgroundColor = materialColor[shade];
                        if (newBackgroundColor != null) {
                          if (isBrush) {
                            drawingController.setStyle(
                              color: newBackgroundColor,
                            );
                          } else {
                            painterDataNotifier.value = painterDataNotifier
                                .value
                                .copyWith(
                                  imagePath: () => null,
                                  backgroundColor: newBackgroundColor,
                                );
                          }
                        }
                        context.pop();
                      },
                      child: Container(
                        color: materialColor[shade],
                        width: 26,
                        height: 26,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Function() handleDownload(BuildContext context) {
    return () async {
      final image = await drawingController.getImageData();
      if (image?.buffer != null) {
        final pngBytes = image!.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        final filePath =
            '${tempDir.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';

        final file = File(filePath);
        await file.writeAsBytes(pngBytes);

        if (context.mounted) {
          final box = context.findRenderObject() as RenderBox?;

          await SharePlus.instance.share(
            ShareParams(
              files: [XFile(filePath)],
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            ),
          );
        }

        await file.delete();
      }
    };
  }
}
