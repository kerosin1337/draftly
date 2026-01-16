import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/features/auth/bloc/auth_bloc.dart';
import '/features/main/bloc/main_bloc.dart';
import '/features/main/presentation/widgets/image_card.dart';
import '/shared/constants/asset_paths.dart';
import '/shared/widgets/draftly_button.dart';
import '/shared/widgets/draftly_scaffold.dart';
import '/shared/widgets/draftly_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final AuthBloc authBloc = context.read<AuthBloc>();
  late final MainBloc mainBloc = context.read<MainBloc>();

  @override
  void initState() {
    super.initState();
    mainBloc.add(MainGetImagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final imagesLoaded = state is MainLoadedImagesState;
        final hasImages = imagesLoaded && state.images.isNotEmpty;
        return DraftlyScaffold(
          title: 'Галерея',
          leading: IconButton(
            iconSize: 24,
            icon: const DraftlySvg(
              assetName: SvgAsset.brokenLogout,
              width: 24,
              height: 24,
            ),
            onPressed: handleLogout,
          ),
          trailing: hasImages
              ? IconButton(
                  iconSize: 24,
                  icon: const DraftlySvg(
                    assetName: SvgAsset.boldPaintRoller,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: handleNavigatePainter,
                )
              : null,
          body: imagesLoaded
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: state.images.length,
                  itemBuilder: (context, index) =>
                      ImageCard(imageModel: state.images[index]),
                )
              : const Center(child: CircularProgressIndicator()),
          bottomChild: !hasImages
              ? DraftlyButton(text: 'Создать', onPressed: handleNavigatePainter)
              : null,
        );
      },
    );
  }

  void handleNavigatePainter() {
    context.push('/painter');
  }

  void handleLogout() {
    mainBloc.add(
      MainCloseStream(
        onSuccess: () {
          authBloc.add(
            AuthLogoutEvent(
              onSuccess: () {
                context.go('/login');
              },
            ),
          );
        },
      ),
    );
  }
}
