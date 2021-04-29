import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'blocs/profile_bloc.dart';
import 'helper/constants/app_colors.dart';
import 'helper/constants/app_strings.dart';
import 'helper/hive_init.dart';
import 'helper/graphql_client/graphql_client.dart';
import 'repositories/github_repository.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _client = GraphQLClientService.shared;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.APP_NAME,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppStrings.INITIAL_ROUTE,
      routes: {
        AppStrings.INITIAL_ROUTE: (context) => const SplashScreen(),
        AppStrings.PROFILE_ROUTE: (context) =>  Provider<ProfileBloc>(
          create: (context) => ProfileBloc(githubRepository:  GithubRepository(
            client: _client.getGraphQlClient(),
          ),),
          dispose: (_, bloc) => bloc.dispose(),
          child: const ProfileScreen(),
        ),
      },
    );
  }
}


