import 'dart:io';

import 'package:draftly/features/painter/presentation/widgets/draftly_icon_button.dart';
import 'package:draftly/shared/constants/asset_paths.dart';
import 'package:draftly/shared/widgets/draftly_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PainterScreen extends StatefulWidget {
  const PainterScreen({super.key});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  final DrawingController drawingController = DrawingController();

  String? imagePath;

  @override
  void dispose() {
    drawingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraftlyScaffold(
      body: Column(
        spacing: 24,
        children: [
          actionButtons(),
          DrawingBar(
            controller: drawingController,
            tools: [DefaultActionItem.slider()],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return DrawingBoard(
                  controller: drawingController,
                  boardScaleEnabled: false,
                  background: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration: ShapeDecoration(
                      shape: const RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      image: canvas(),
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DecorationImage? canvas() {
    if (imagePath != null) {
      return DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.cover);
    }
    return null;
  }

  Widget actionButtons() {
    return Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DraftlyIconButton(
          assetName: SvgAsset.linearDownload,
          onPressed: handleDownload,
        ),
        DraftlyIconButton(
          assetName: SvgAsset.boldGallery,
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                imagePath = image.path;
              });
            }
          },
        ),
        DraftlyIconButton(
          assetName: SvgAsset.boldEdit,
          onPressed: () => drawingController.setPaintContent(SimpleLine()),
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
                print(Colors.primaries.first.keys);
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
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Column(
                            children: Colors.primaries.reversed
                                .map(
                                  (materialColor) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: materialColor.keys
                                        .map(
                                          (shade) => GestureDetector(
                                            onTap: () {
                                              drawingController.setStyle(
                                                color: materialColor[shade],
                                              );
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
                          ),
                        ),
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

  Future<void> handleDownload() async {
    final image = await drawingController.getImageData();
    if (image?.buffer != null) {
      final pngBytes = image!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      await SharePlus.instance.share(ShareParams(files: [XFile(filePath)]));

      await file.delete();
    }
  }
}
