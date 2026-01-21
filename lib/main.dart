import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:inspector/inspector.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '/core/router/router.dart';
import '/core/services/notification.dart';
import '/core/theme/app_theme.dart';
import '/features/auth/bloc/auth_bloc.dart';
import '/features/main/bloc/main_bloc.dart';
import '/shared/constants/asset_paths.dart';
import '/shared/constants/error_message.dart';
import '/shared/constants/urls.dart';
import '/shared/widgets/draftly_snackbar.dart';
import 'firebase_options.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final InternetConnectionChecker internetChecker;
  StreamSubscription<InternetConnectionStatus>? connectivitySubscription;

  final authBroadcastStream = FirebaseAuth.instance
      .authStateChanges()
      .asBroadcastStream();

  StreamSubscription<User?>? subAuthStream;

  InternetConnectionStatus? prevStatus;

  @override
  void initState() {
    super.initState();

    internetChecker = InternetConnectionChecker.createInstance(
      addresses: [AddressCheckOption(uri: Uri.parse(urlCheck))],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        precacheImage(ImageAsset.backgroundPattern, context),
        precacheImage(ImageAsset.background, context),
      ]);
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    subAuthStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => MainBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Draftly',
        theme: appTheme,
        supportedLocales: const [Locale('ru')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          if (child != null) {
            initConnectChecker(context);
            return Inspector(isEnabled: kDebugMode, child: child);
          }
          return const SizedBox.shrink();
        },
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          physics: const AlwaysScrollableScrollPhysics().applyTo(
            const BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }

  void initConnectChecker(BuildContext context) {
    connectivitySubscription?.cancel();
    connectivitySubscription = internetChecker.onStatusChange.listen((status) {
      if (context.mounted) {
        final String? message = switch ((status, prevStatus)) {
          (
            InternetConnectionStatus.connected,
            InternetConnectionStatus.disconnected,
          ) =>
            'connected',
          (InternetConnectionStatus.disconnected, _) => 'disconnected',
          _ => null,
        };

        prevStatus = status;
        if (message != null) {
          DraftlySnackbar.showSnackBar(context, getErrorMessage(message));
        }
      }
    });
  }
}
