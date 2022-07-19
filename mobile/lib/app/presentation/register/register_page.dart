import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/presentation/register/register_controller.dart';
import 'package:tcc_henrique/app/presentation/widgets/custom_text_field_widget.dart';
import 'package:tcc_henrique/app/presentation/widgets/loading_button_widget.dart';
import 'package:tcc_henrique/app/presentation/widgets/show_password_widget.dart';

class RegisterPage extends StatefulWidget {
  final Profile profile;
  const RegisterPage({Key key, this.profile}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final controller =
          Provider.of<RegisterController>(context, listen: false);
      if (widget.profile != null) {
        controller.onInit(profile: widget.profile);
      } else {
        controller.onInit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua conta'),
      ),
      body: Consumer<RegisterController>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Dados pessoais',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormFieldWidget(
                    controller: value.nameController,
                    leftIcon: const Icon(Icons.person),
                    labelText: 'Nome completo',
                    textInputType: TextInputType.visiblePassword,
                    errorText:
                        value.errorText(value.nameisValid, value.nameError),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFieldWidget(
                    controller: value.emailController,
                    labelText: 'E-mail',
                    textInputType: TextInputType.emailAddress,
                    leftIcon: const Icon(Icons.email),
                    errorText: value.errorText(
                      value.emailIsValid,
                      value.emailError,
                    ),
                    enabled: !value.isEdit,
                  ),
                  value.isEdit
                      ? const SizedBox()
                      : Column(
                          children: [
                            const SizedBox(height: 16),
                            CustomTextFormFieldWidget(
                              controller: value.passwordController,
                              labelText: 'Senha',
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
                              leftIcon: const Icon(Icons.lock),
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormFieldWidget(
                              controller: value.confirmPasswordController,
                              labelText: 'Confirmar senha',
                              textInputType: TextInputType.visiblePassword,
                              icon: ShowPasswordWidget(
                                show: value.showConfirmPassword,
                                hidePassword: value.hideConfirmPassword,
                              ),
                              errorText: value.errorText(
                                value.confirmPasswordIsValid,
                                value.confirmPasswordError,
                              ),
                              obscureText:
                                  value.showConfirmPassword ? false : true,
                              leftIcon: const Icon(Icons.lock),
                            ),
                          ],
                        ),
                  const SizedBox(height: 24),
                  const Text(
                    'Endereço',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormFieldWidget(
                    controller: value.streetController,
                    labelText: 'Rua',
                    textInputType: TextInputType.text,
                    errorText:
                        value.errorText(value.streetIsValid, value.streetError),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFieldWidget(
                    controller: value.numberController,
                    labelText: 'Número',
                    textInputType: TextInputType.text,
                    errorText:
                        value.errorText(value.numberIsValid, value.numberError),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFieldWidget(
                    controller: value.districtController,
                    labelText: 'Bairro',
                    textInputType: TextInputType.text,
                    errorText: value.errorText(
                        value.districtIsValid, value.districtError),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFieldWidget(
                    controller: value.complementController,
                    labelText: 'Complemento',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormFieldWidget(
                    controller: value.referenceController,
                    labelText: 'Referência',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  value.isError
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Erro ao cadastrar usuario',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  value.isError ? const SizedBox(height: 16) : const SizedBox(),
                  LoadingButtonWidget(
                    text: 'Criar Conta',
                    onPressed: () async {
                      final result = await value.onPressed();
                      if (result) {
                        Navigator.of(context).pop();
                      }
                    },
                    isLoading: value.isLoading,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
