import 'package:card_hash_generator/card_hash_generator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pagarme_card_hash_generator/string_extension.dart';
import 'package:pagarme_card_hash_generator/web_image.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:html' as html;

const title = 'Não utilize dados de cartões reais, acesse o site 4devs.com.br\npara gerar dados de cartão fake para teste.';

const subtitle =
    'Este site é apenas um demonstrativo do package card_hash_generator para Flutter que eu criei para utilizar na empresa na qual eu trabalho, porém está publicado no github para quem quiser ver!';

const how2use = 'Importe o package ';

const text =
    'Porém lembre-se, esta opção só vai funcionar no ambiente de teste da pagar.me, qualquer tentativa de cartão fake no ambiente de produção vai acarretar em erro da pagar.me, até porque o cartão nem existe! Caso você tenha alguma dúvida, critica ou sugestão, fique a vontade para entrar em contato comigo. =)';

const text2 =
    'Com um cartão fake você pode testar a api sem se preocupar com valores, prestações ou afins, visto que digitar qualquer número provavelmente não irá funcionar, os números precisam fazer sentido para a api processar, mesmo que fake!';

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
  void initState() {
//     html.document.head!.append(html.ScriptElement()
//       ..async = true
//       ..src = 'https://securepubads.g.doubleclick.net/tag/js/gpt.js');

//     html.document.head!.append(html.ScriptElement()
//       ..text = '''
// window.googletag = window.googletag || {cmd: []};
//   googletag.cmd.push(function() {
//     googletag
//         .defineSlot(
//             '/6355419/Travel/Europe/France/Paris', [300, 250], 'banner-ad')
//         .addService(googletag.pubads());
//     googletag.enableServices();
//   });
// ''');

//     html.document.head!.append(html.ScriptElement()
//       ..async = true
//       ..crossOrigin = 'anonymous'
//       ..src = 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-9927286313504915');

//     html.document.body!.appendHtml(
//       '''
// <ins class="adsbygoogle"
//      style="display:block"
//      data-ad-client="ca-pub-9927286313504915"
//      data-ad-slot="9576838047"
//      data-ad-format="auto"
//      data-full-width-responsive="true"></ins>
// ''',
//       validator: html.NodeValidatorBuilder.common()
//         ..allowElement(
//           'ins',
//           attributes: [
//             'data-full-width-responsive',
//             'data-ad-format',
//             'data-ad-slot',
//             'data-ad-client',
//             'style',
//           ],
//         ),
//     );

//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory('googleads', (int viewId) {
//       final html.Element htmlElement = html.ScriptElement()
//         ..style.width = '100%'
//         ..style.height = '100%'
//         ..text = '''
// (adsbygoogle = window.adsbygoogle || []).push({});
// ''';

//       return htmlElement;
//     });

    html.document.body!.append(html.HeadingElement.h1()..text = 'ATENÇÃO');

    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1024.0,
              minWidth: 420.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 128),
                TextRenderer(
                  style: TextRendererStyle.header1,
                  text: 'ATENÇÃO',
                  child: SelectableText(
                    'ATENÇÃO',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                TextRenderer(
                  style: TextRendererStyle.paragraph,
                  text: title,
                  child: SelectableText(
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
                      text: subtitle,
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Este site é epenas um demonstrativo do package ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: 'card_hash_generator',
                              recognizer: TapGestureRecognizer()..onTap = () => launch('https://pub.dev/packages/card_hash_generator'),
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
                      filter: {'#': RegExp(r'[0-9]')},
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
                      filter: {'#': RegExp(r'[0-9]')},
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
                      filter: {'#': RegExp(r'[0-9]')},
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                                child: Text('Por favor, insira sua chave de API da Pagar.me!'),
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior: SnackBarBehavior.floating,
                                              width: 480,
                                            ),
                                          );

                                          return;
                                        }

                                        final pagarmeCardHash = CardHashGenerator(apiKey: apiKey.text);

                                        final cardHash = await pagarmeCardHash
                                            .generate(
                                          cardNumber: cardNumber.text.cardNumbersOnly,
                                          cardHolderName: cardHolder.text,
                                          cardExpirationDate: cardExp.text.cardExpirationNumbersOnly,
                                          cardCvv: cardCvv.text,
                                        )
                                            .catchError((e) {
                                          if (e is CardHashException) {
                                            print(e.message);
                                          }
                                        });

                                        Navigator.of(context).pop();

                                        await showDialog(
                                          context: context,
                                          builder: (_) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                            child: Center(
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
                const SizedBox(height: 256),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.header1,
                      text: 'Utilizando o package em seu projeto Flutter',
                      child: SelectableText(
                        'Utilizando o package em seu projeto Flutter',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text:
                          'Adicione o package card_hash_generator no arquivo pubspec.yaml que está na raiz do seu projeto Flutter, o package é compatível com todas as versões do flutter que estão em null safety, então você não tetrá problemas utilizando este package, desde que esteja com o projeto em null safety',
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Adicione o package ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: 'card_hash_generator',
                              recognizer: TapGestureRecognizer()..onTap = () => launch('https://pub.dev/packages/card_hash_generator'),
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  ' no arquivo pubspec.yaml que está na raiz de seu projeto Flutter, o package é compatível com todas as versões do flutter que estão em null safety, então você não terá problemas utilizando este package, desde que esteja com o projeto em null safety!',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text: 'Crie uma instância da classe CardHashGenerator passando sua chave de api da pagar.me!',
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Crie uma instância da classe CardHashGenerator passando sua chave de api da ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: 'pagar.me',
                              recognizer: TapGestureRecognizer()..onTap = () => launch('https://pagar.me/'),
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text: '!',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: WebImage.asset('assets/img1.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text:
                          'Após realizar a inicialização da classe com sua chave de api o processo é bastante simples, basta chamar o método .generate() passando os dados do cartão em que se deseja criar o card_hash! É necessário tratar os dados obtidos do usuário antes de enviar para criar o card_hash, os números do cartão não podem conter nada além dos números, deve ser uma String desta forma: 0000000000000000. O mesmo vale para o nome do titular do cartão que deve conter apenas letras (afinal nome próprio não tem números não é mesmo?), a data de validade do cartão dois digitos para o mês e dois digitos para o ano assim: 0000 e o cvv que deve conter também apenas números! Caso algum desses dados não seja passados corretamente uma exceção será lançada!',
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Após realizar a inicialização da classe com sua chave de api o processo é bastante simples, basta chamar o método ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: '.generate()',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text: ' passando os dados do cartão em que se deseja criar o card_hash!',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  ' É necessário tratar os dados obtidos do usuário antes de enviar para criar o card_hash, os números do cartão não podem conter nada além dos números, deve ser uma String desta forma: ',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            TextSpan(
                              text: '0000000000000000',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '. O mesmo vale para o nome do titular do cartão que deve conter apenas letras (afinal nome próprio não tem números não é mesmo?), a data de validade do cartão dois digitos para o mês e dois digitos para o ano assim: ',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            TextSpan(
                              text: '0000',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text: ' e o cvv que deve conter também apenas números! Caso algum desses dados não seja passados corretamente uma exceção será lançada!',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: WebImage.asset('assets/img2.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text: 'Pronto seu cartão encriptado foi gerado com sucesso e já está pronto para ser utilizado na pagar.me em uma transação ou para gerar um card_id! Fácio não é mesmo?',
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Pronto seu cartão encriptado foi gerado com sucesso e já está pronto para ser utilizado na ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: 'pagar.me',
                              recognizer: TapGestureRecognizer()..onTap = () => launch('https://pagar.me/'),
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                            TextSpan(
                              text: ' em uma transação ou para gerar um card_id! Fácil não é mesmo?',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.header1,
                      text: 'Não sabe criar um cartão fake?',
                      child: SelectableText(
                        'Não sabe criar um cartão fake?',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text: 'Para criar um cartão de crédito fake para teste, basta acessar 4devs.com.br e gerar um número para utilização na api da pagar.me.',
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Para criar um cartão de crédito fake para teste, basta acessar ',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey,
                              ),
                          children: [
                            TextSpan(
                              text: '4devs.com.br',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch('https://www.4devs.com.br/gerador_de_numero_cartao_credito'),
                            ),
                            TextSpan(
                              text: ' e gerar um número para utilização na api da pagar.me.',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text: text,
                      child: SelectableText(
                        text,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.header1,
                      text: 'Porque utilizar um cartão fake?',
                      child: SelectableText(
                        'Porque utilizar um cartão fake?',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextRenderer(
                      style: TextRendererStyle.paragraph,
                      text: text2,
                      child: SelectableText(
                        text2,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 128),
                TextRenderer(
                  style: TextRendererStyle.paragraph,
                  child: Text.rich(
                    TextSpan(
                      text: 'Site feito utilizando Flutter por ',
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Colors.grey,
                          ),
                      children: [
                        TextSpan(
                          text: '@tihrasguinhodev',
                          style: Theme.of(context).textTheme.overline!.copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                          recognizer: TapGestureRecognizer()..onTap = () => launch('https://twitter.com/tihrasguinhodev'),
                        ),
                        TextSpan(
                          text: '.',
                          style: Theme.of(context).textTheme.overline!.copyWith(
                                color: Colors.grey,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
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
        child: TextField(
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
