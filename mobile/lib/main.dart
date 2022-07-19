import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_henrique/app/data/datasource/login_datasource.dart';
import 'package:tcc_henrique/app/data/datasource/register_datasource.dart';
import 'package:tcc_henrique/app/data/repositories/login_repository_impl.dart';
import 'package:tcc_henrique/app/data/repositories/register_repository_impl.dart';
import 'package:tcc_henrique/app/domain/usecases/login_usercase.dart';
import 'package:tcc_henrique/app/domain/usecases/register_usecase.dart';
import 'package:tcc_henrique/app/presentation/home/home_controller.dart';
import 'package:tcc_henrique/app/presentation/login/login_controller.dart';
import 'package:tcc_henrique/app/presentation/login/login_page.dart';
import 'package:tcc_henrique/app/presentation/receipt/receipt_controller.dart';
import 'package:tcc_henrique/app/presentation/register/register_controller.dart';
import 'package:tcc_henrique/app/presentation/register/register_validate.dart';

import 'app/presentation/home/home_validate.dart';
import 'app/presentation/login/login_validate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (_) => LoginValidate()),
        Provider(create: (_) => RegisterValidate()),
        Provider(create: (_) => HomeValidate()),
        Provider(
          create: (_) => LoginDatasouceImpl(
            dio: Provider.of<Dio>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => RegisterDatasourceImpl(
            dio: Provider.of<Dio>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => LoginRepositoryImpl(
            loginDatasource: Provider.of<LoginDatasouceImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => RegisterRepositoryImpl(
            registerDatasouce:
                Provider.of<RegisterDatasourceImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => LoginUsecaseImpl(
            loginRepository: Provider.of<LoginRepositoryImpl>(_, listen: false),
          ),
        ),
        Provider(
          create: (_) => RegisterUsecaseImpl(
            registerRepository:
                Provider.of<RegisterRepositoryImpl>(_, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(
            loginValidate: Provider.of<LoginValidate>(context, listen: false),
            loginUsecaseImpl:
                Provider.of<LoginUsecaseImpl>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterController(
            registerValidate:
                Provider.of<RegisterValidate>(context, listen: false),
            registerUsecaseImpl:
                Provider.of<RegisterUsecaseImpl>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(
            homeValidate: Provider.of<HomeValidate>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ReceiptController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
