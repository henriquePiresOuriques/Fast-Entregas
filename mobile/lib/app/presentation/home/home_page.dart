import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/selected_item.dart';
import 'package:tcc_henrique/app/presentation/home/home_controller.dart';
import 'package:tcc_henrique/app/presentation/login/login_page.dart';
import 'package:tcc_henrique/app/presentation/receipt/receipt_page.dart';
import 'package:tcc_henrique/app/presentation/register/register_page.dart';
import 'package:tcc_henrique/app/presentation/widgets/custom_text_field_widget.dart';
import 'package:tcc_henrique/app/presentation/widgets/loading_button_widget.dart';

class HomePage extends StatefulWidget {
  final Profile profile;
  HomePage({this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final controller = Provider.of<HomeController>(context, listen: false);
      controller.onInit();
    });
  }

  List<SelectedItem> itens = [
    SelectedItem(
      name: 'Zona Nova',
      price: 10.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Centro',
      price: 8.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Araçá',
      price: 5.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Atlântida',
      price: 12.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Xangri-lá',
      price: 15.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Rainha do Mar',
      price: 20.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Arco íris',
      price: 25.0,
      isSelected: false,
    ),
    SelectedItem(
      name: 'Capão Novo',
      price: 17.0,
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Olá ${widget.profile.name}'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: profileOptionsAction,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: const Text(
                          'Valor de arranque : R\$ 8,00',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      itemCount: itens.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                value.selectedItem(itens[index], itens);
                              },
                              child: Ink(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      itens[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.toCurrency(itens[index].price),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(
                                          itens[index].isSelected
                                              ? Icons.check_box_rounded
                                              : Icons.check_box_outline_blank,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Valor de arranque : ${value.toCurrency(8.0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      CustomTextFormFieldWidget(
                        controller: value.streetController,
                        labelText: 'Rua',
                        textInputType: TextInputType.text,
                        errorText: value.errorText(
                          value.streetIsValid,
                          value.streetError,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormFieldWidget(
                        controller: value.numberController,
                        labelText: 'Número',
                        textInputType: TextInputType.text,
                        errorText: value.errorText(
                          value.numberIsValid,
                          value.numberError,
                        ),
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
                        errorText: value.errorText(
                          value.referenceIsValid,
                          value.referenceError,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LoadingButtonWidget(
                    text: 'Continuar',
                    onPressed: () {
                      final result = value.onPressed();
                      if (result) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReceiptPage(
                              addressHome: value.addressHome,
                            ),
                          ),
                        );
                      }
                    },
                    isLoading: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void profileOptionsAction(String option) async {
    switch (option) {
      case "Editar perfil":
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterPage(profile: widget.profile)));
        break;
      case "Sair do App":
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
        break;
    }
  }
}

class Constants {
  static const String privacy = ("Editar perfil");
  static const String logout = ("Sair do App");

  static const List<String> choices = <String>[privacy, logout];
}
