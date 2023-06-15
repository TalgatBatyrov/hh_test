import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/cart/cart_cubit.dart';
import 'package:shop_app/blocs/categories/categories_cubit.dart';
import 'package:shop_app/blocs/dishes/dishes_cubit.dart';
import 'package:shop_app/blocs/toggle/toggle_cubit.dart';
import 'package:shop_app/blocs/user_info/user_info_cubit.dart';
import 'package:shop_app/data/repository/app_repository.dart';
import 'package:shop_app/widgets/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AppRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserInfoCubit()),
          BlocProvider(create: (_) => ToggleCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(
            create: (context) => CategoriesCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => DishesCubit(context.read()),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Home(),
        ),
      ),
    );
  }
}
