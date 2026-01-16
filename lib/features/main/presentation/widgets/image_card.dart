import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/theme/app_colors.dart';
import '/features/main/data/models/image_model.dart';
import '/shared/widgets/draftly_image.dart';

class ImageCard extends StatelessWidget {
  final ImageModel imageModel;

  const ImageCard({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.grey),
      ),
      color: AppColors.white,
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          context.push('/painter', extra: imageModel);
        },
        child: DraftlyImage(image: imageModel.image),
      ),
    );
  }
}
