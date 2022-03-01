import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagarme_card_hash/pagarme_card_hash.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final cardNumber = TextEditingController();
  final cardHolder = TextEditingController();
  final cardExp = TextEditingController();
  final cardCvv = TextEditingController();

  final apiKey = TextEditingController();

  bool get isValidated => cardNumber.text.isNotEmpty && cardHolder.text.isNotEmpty && cardExp.text.isNotEmpty && cardCvv.text.isNotEmpty;

  @override
  void dispose() {
    cardNumber.dispose();
    cardHolder.dispose();
    cardExp.dispose();
    cardCvv.dispose();
    apiKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ATENÇÃO',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.red,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Não utilize dados de cartões reais, acesse o site 4devs.com.br\npara gerar dados de cartão fake para teste.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Este site é epenas um demonstrativo do package "pagarme_hash" para flutter\nque eu criei para utilização da empresa na qual eu trabalho\nporém está publicado no github para quem queira ver',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 24),
              _customTextField(
                label: 'Número do Cartão',
                controller: cardNumber,
              ),
              _customTextField(
                label: 'Nome do Titular',
                controller: cardHolder,
              ),
              _customTextField(
                label: 'Data de Validade',
                controller: cardExp,
              ),
              _customTextField(
                label: 'CVV',
                controller: cardCvv,
              ),
              FloatingActionButton.extended(
                heroTag: '1',
                label: Text('Gerar card hash'.toUpperCase()),
                onPressed: () => isValidated
                    ? showDialog(
                        context: context,
                        builder: (_) => Center(
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 32),
                                Text(
                                  'Insira sua chave de api pagarme',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                _customTextField(
                                  label: 'Chave de API',
                                  controller: apiKey,
                                ),
                                FloatingActionButton.extended(
                                  heroTag: '2',
                                  label: Text('CONFIRMAR'.toUpperCase()),
                                  onPressed: () async {
                                    if (apiKey.text.isEmpty) {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Por favor, insira sua chave de API da Pagarme!'),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          width: 480,
                                        ),
                                      );

                                      return;
                                    }

                                    final pagarmeCardHash = PagarmeCardHash(apiKey: apiKey.text);

                                    final cardHash = await pagarmeCardHash.cardHash(
                                      cardNumber: cardNumber.text,
                                      cardHolder: cardHolder.text,
                                      cardExp: cardExp.text,
                                      cardCvv: cardCvv.text,
                                    );

                                    Navigator.of(context).pop();

                                    await showDialog(
                                      context: context,
                                      builder: (_) => Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 100),
                                          child: Material(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(height: 32),
                                                Text(
                                                  'card_hash gerado com sucesso!',
                                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(8),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 4,
                                                        offset: Offset(2, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    width: 420,
                                                    height: 24,
                                                    color: Colors.grey.shade200,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                    alignment: Alignment.center,
                                                    child: ScrollConfiguration(
                                                      behavior: ScrollConfiguration.of(context).copyWith(
                                                        dragDevices: {
                                                          PointerDeviceKind.mouse,
                                                          PointerDeviceKind.touch,
                                                        },
                                                      ),
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: Text(
                                                          cardHash,
                                                          maxLines: 1,
                                                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                                color: Colors.black,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                FloatingActionButton.extended(
                                                  onPressed: () {
                                                    Clipboard.setData(ClipboardData(text: cardHash));

                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Copiado!'),
                                                        backgroundColor: Colors.green,
                                                        behavior: SnackBarBehavior.floating,
                                                        width: 480,
                                                      ),
                                                    );
                                                  },
                                                  label: const Text('Copiar para área de transferência'),
                                                  icon: const Icon(Icons.copy_rounded),
                                                ),
                                                const SizedBox(height: 32),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      )
                    : {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, preencha os dados do cartão'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            width: 480,
                          ),
                        ),
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required String label,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 480,
          maxHeight: 52,
          minHeight: 52,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
      ),
    );
  }
}
