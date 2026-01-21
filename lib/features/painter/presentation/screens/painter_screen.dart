import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:go_router/go_router.dart';
import 'package:saver_gallery/saver_gallery.dart';

import '/core/services/notification.dart';
import '/features/main/bloc/main_bloc.dart';
import '/features/main/data/models/image_model.dart';
import '/features/painter/presentation/widgets/painter_actions.dart';
import '/shared/constants/asset_paths.dart';
import '/shared/widgets/draftly_scaffold.dart';
import '/shared/widgets/draftly_svg.dart';

class PainterData {
  final String? imagePath;
  final Color? backgroundColor;

  const PainterData({this.imagePath, this.backgroundColor});

  PainterData copyWith({
    String? Function()? imagePath,
    Color? backgroundColor,
  }) {
    return PainterData(
      imagePath: imagePath != null ? imagePath() : this.imagePath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

class PainterScreen extends StatefulWidget {
  final ImageModel? imageModel;

  const PainterScreen({super.key, required this.imageModel});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  late final MainBloc mainBloc = context.read<MainBloc>();

  final DrawingController drawingController = DrawingController();
  final ValueNotifier<PainterData> painterDataNotifier = ValueNotifier(
    const PainterData(),
  );

  String? get imagePath => painterDataNotifier.value.imagePath;

  Color? get backgroundColor => painterDataNotifier.value.backgroundColor;

  ImageModel? get imageModel => widget.imageModel;

  bool get isEdit => imageModel != null;

  String get title => isEdit ? 'Редактирование' : 'Новое изображение';

  bool isSaving = false;

  @override
  void dispose() {
    drawingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraftlyScaffold(
      isLoading: isSaving,
      title: title,
      trailing: IconButton(
        iconSize: 24,
        icon: const DraftlySvg(
          assetName: SvgAsset.linearCheck,
          width: 24,
          height: 24,
        ),
        onPressed: handleSaveImage,
      ),
      body: Column(
        spacing: 24,
        children: [
          PainterActions(
            drawingController: drawingController,
            painterDataNotifier: painterDataNotifier,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return DrawingBoard(
                  controller: drawingController,
                  boardScaleEnabled: false,
                  background: ValueListenableBuilder(
                    valueListenable: painterDataNotifier,
                    builder: (context, value, child) {
                      return Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: ShapeDecoration(
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          image: canvas(),
                          color: backgroundColor ?? Colors.white,
                        ),
                      );
                    },
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
    } else if (imageModel != null && backgroundColor == null) {
      return DecorationImage(
        image: MemoryImage(base64Decode(imageModel!.image)),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  Future<void> handleSaveImage() async {
    setState(() {
      isSaving = true;
    });
    try {
      final completer = Completer();
      final image = await drawingController.getImageData();
      if (image?.buffer != null) {
        final imageBytes = image!.buffer.asUint8List();
        final base64String = base64.encode(imageBytes);
        final fileName =
            imageModel?.fileName ??
            'drawing_${DateTime.now().millisecondsSinceEpoch}.png';

        final onSuccess = handleOnSuccessSaveImage(
          imageBytes,
          fileName,
          completer,
        );

        mainBloc.add(
          isEdit
              ? MainUpdateImageEvent(
                  id: imageModel!.id,
                  image: base64String,
                  onSuccess: onSuccess,
                )
              : MainSaveImageEvent(
                  port: {'fileName': fileName, 'image': base64String},
                  onSuccess: onSuccess,
                ),
        );
      }
      await completer.future;
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  Function() handleOnSuccessSaveImage(
    Uint8List imageBytes,
    String fileName,
    Completer completer,
  ) {
    return () async {
      await SaverGallery.saveImage(
        imageBytes,
        skipIfExists: false,
        fileName: fileName,
      );

      NotificationService.showSimpleNotification(
        title: 'Успешно!',
        body: 'Рисунок сохранен.',
      );

      if (mounted) {
        context.pop();
      }

      completer.complete();
    };
  }
}
