import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pagarme_card_hash/pagarme_card_hash.dart';
import 'package:pagarme_card_hash_generator/string_extension.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:url_launcher/url_launcher.dart';

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
              TextRenderer(
                style: TextRendererStyle.header6,
                child: Text(
                  'ATENÇÃO',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              TextRenderer(
                style: TextRendererStyle.paragraph,
                child: Text(
                  'Não utilize dados de cartões reais, acesse o site 4devs.com.br\npara gerar dados de cartão fake para teste.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 480,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextRenderer(
                    style: TextRendererStyle.paragraph,
                    child: Text.rich(
                      TextSpan(
                        text: 'Este site é epenas um demonstrativo do package ',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                            ),
                        children: [
                          TextSpan(
                            text: 'pagarme_card_hash',
                            recognizer: TapGestureRecognizer()..onTap = () => launch('https://github.com/tihrasguinho/pagarme_card_hash'),
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: ' para Flutter que eu criei para utilizar na empresa na qual eu trabalho, porém está publicado no github para quem quiser ver!',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _customTextField(
                label: 'Número do Cartão',
                controller: cardNumber,
                formatters: [
                  MaskTextInputFormatter(
                    mask: '#### #### #### ####',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy,
                  ),
                ],
              ),
              _customTextField(
                label: 'Nome do Titular',
                controller: cardHolder,
              ),
              _customTextField(
                label: 'Data de Validade',
                controller: cardExp,
                formatters: [
                  MaskTextInputFormatter(
                    mask: '##/##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy,
                  ),
                ],
              ),
              _customTextField(
                label: 'CVV',
                controller: cardCvv,
                formatters: [
                  MaskTextInputFormatter(
                    mask: '###',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy,
                  ),
                ],
              ),
              FloatingActionButton.extended(
                heroTag: '1',
                label: TextRenderer(
                  style: TextRendererStyle.paragraph,
                  child: Text('Gerar card hash'.toUpperCase()),
                ),
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
                                TextRenderer(
                                  style: TextRendererStyle.header6,
                                  child: Text(
                                    'Insira sua chave de api pagarme',
                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _customTextField(
                                  label: 'Chave de API',
                                  controller: apiKey,
                                ),
                                FloatingActionButton.extended(
                                  heroTag: '2',
                                  label: TextRenderer(
                                    style: TextRendererStyle.paragraph,
                                    child: Text('CONFIRMAR'.toUpperCase()),
                                  ),
                                  onPressed: () async {
                                    if (apiKey.text.isEmpty) {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: TextRenderer(
                                            style: TextRendererStyle.paragraph,
                                            child: Text('Por favor, insira sua chave de API da Pagarme!'),
                                          ),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          width: 480,
                                        ),
                                      );

                                      return;
                                    }

                                    final pagarmeCardHash = PagarmeCardHash(apiKey: apiKey.text);

                                    final cardHash = await pagarmeCardHash.cardHash(
                                      cardNumber: cardNumber.text.withOutSpecialChars,
                                      cardHolder: cardHolder.text,
                                      cardExp: cardExp.text.withOutSpecialChars,
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
                                                TextRenderer(
                                                  style: TextRendererStyle.header6,
                                                  child: Text(
                                                    'card_hash gerado com sucesso!',
                                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                                          color: Colors.black,
                                                        ),
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
                                                        child: TextRenderer(
                                                          style: TextRendererStyle.paragraph,
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
                                                ),
                                                const SizedBox(height: 16),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                                  child: FloatingActionButton.extended(
                                                    onPressed: () {
                                                      Clipboard.setData(ClipboardData(text: cardHash));

                                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: TextRenderer(
                                                            style: TextRendererStyle.paragraph,
                                                            child: Text('Copiado!'),
                                                          ),
                                                          backgroundColor: Colors.green,
                                                          behavior: SnackBarBehavior.floating,
                                                          width: 480,
                                                        ),
                                                      );
                                                    },
                                                    label: const TextRenderer(
                                                      style: TextRendererStyle.paragraph,
                                                      child: Text('Copiar para área de transferência'),
                                                    ),
                                                    icon: const Icon(Icons.copy_rounded),
                                                  ),
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
                            content: TextRenderer(
                              style: TextRendererStyle.paragraph,
                              child: Text('Por favor, preencha os dados do cartão'),
                            ),
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
    List<TextInputFormatter>? formatters,
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
          inputFormatters: formatters,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
