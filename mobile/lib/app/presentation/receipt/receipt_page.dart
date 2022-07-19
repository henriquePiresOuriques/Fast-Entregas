import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_henrique/app/domain/entities/address_home.dart';
import 'package:tcc_henrique/app/presentation/receipt/receipt_controller.dart';
import 'package:tcc_henrique/app/presentation/widgets/loading_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ReceiptPage extends StatefulWidget {
  final AddressHome addressHome;
  ReceiptPage({this.addressHome});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprovante'),
      ),
      body: Consumer<ReceiptController>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Valor de arranque :'),
                                Text(value.toCurrency(value.fixedRateValue)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${widget.addressHome.district}: '),
                                Text(
                                    value.toCurrency(widget.addressHome.price)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Rua: '),
                                Text(widget.addressHome.street),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Número: '),
                                Text(widget.addressHome.number),
                              ],
                            ),
                            widget.addressHome.complement.isNotEmpty
                                ? const SizedBox(height: 12)
                                : const SizedBox(),
                            widget.addressHome.complement.isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Complemento'),
                                      Text(widget.addressHome.complement),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Ponto de referência:'),
                                Text(widget.addressHome.reference),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total da Entrega:',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              value.toCurrency(value.fixedRateValue +
                                  widget.addressHome.price),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '*A entrega só será confirmada após o recebimento do pagamento',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                LoadingButtonWidget(
                  text: 'Confirmar pelo WhatsApp',
                  onPressed: () async {
// ...somewhere in your Flutter app...
                    launchWhatsApp() async {
                      final link = WhatsAppUnilink(
                          phoneNumber: '5551982775823',
                          text:
                              "Olá, gostaria de falar sobre seu anúncio na Works ,");
                      await launch('$link');
                    }
                  },
                  isLoading: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
