import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_henrique/app/presentation/home/home_page.dart';
import 'package:tcc_henrique/app/presentation/login/login_controller.dart';
import 'package:tcc_henrique/app/presentation/register/register_page.dart';
import 'package:tcc_henrique/app/presentation/widgets/custom_text_field_widget.dart';
import 'package:tcc_henrique/app/presentation/widgets/loading_button_widget.dart';
import 'package:tcc_henrique/app/presentation/widgets/show_password_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<LoginController>(
        builder: (BuildContext context, value, child) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 8,
              color: Colors.grey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormFieldWidget(
                      controller: value.emailController,
                      labelText: 'E-mail',
                      textInputType: TextInputType.emailAddress,
                      leftIcon: const Icon(Icons.email),
                      errorText: value.errorText(
                        value.emailIsValid,
                        value.emailError,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormFieldWidget(
                      controller: value.passwordController,
                      labelText: 'Senha',
                      leftIcon: const Icon(Icons.lock),
                      textInputType: TextInputType.visiblePassword,
                      icon: ShowPasswordWidget(
                        show: value.showPassword,
                        hidePassword: value.hidePassword,
                      ),
                      errorText: value.errorText(
                        value.passwordIsValid,
                        value.passwordError,
                      ),
                      obscureText: value.showPassword ? false : true,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Ink(
                            child: const Text('Cadastre-se'),
                          ),
                        ),
                      ],
                    ),
                    value.isError
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Erro ao fazer Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    LoadingButtonWidget(
                      text: 'Login',
                      onPressed: () async {
                        final result = await value.onPressed();
                        if (result) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                profile: value.profile,
                              ),
                            ),
                          );
                        }
                      },
                      isLoading: value.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
