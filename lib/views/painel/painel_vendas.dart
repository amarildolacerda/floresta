import 'package:flutter/material.dart';
import 'package:models/models/metas_vendas_model.dart';
import '../../widgets/speedometer/speedometer.dart';

class PainelVendasPage extends StatelessWidget {
  const PainelVendasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        MetaVendaSpeedometro(),
      ],
    );
  }
}

class MetaVendaSpeedometro extends StatelessWidget {
  const MetaVendaSpeedometro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ano = 2017;
    var mes = 11;
    var vendedor = '1';
    return FutureBuilder<List<dynamic>>(
        future: MetasVendasItemModel().listNoCached(
            resource: 'metas_vendas_vendedor',
            filter:
                "ano eq $ano and mes eq $mes and sigven_codigo='$vendedor'"),
        builder: (context, snapshot) {
          print(snapshot.data);
          var dados = (!snapshot.hasData || snapshot.data.length == 0)
              ? {}
              : snapshot?.data[0] ?? {};
          var valor = getValor(dados['realizado'], dados['valor']);
          print(dados);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                //border: Border.all(width: 1, color: Colors.cyan),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.grey[200],
              ),
              width: 150,
              padding: EdgeInsets.all(1),
              child: Speedometer(
                size: 150,
                backgroundColor: Colors.transparent, //grey[100],
                meterColor: Colors.amber,
                kimColor: Colors.grey[200],
                pointColor: Colors.grey[500],
                currentValue: valor,
                minValue: 0,
                maxValue: 100 * 1.30 ~/ 1,
                warningValue: 100,
                warningColor: Colors.green,
                displayText: 'Meta',
                digits: 6,
                digitsValue: "${(dados['realizado'] ?? 0) ~/ 1}",
                label: Text('$valor%'),
              ),
            ),
          );
        });
  }

  getValor(valor, meta) {
    meta ??= 0;
    valor ??= 0;
    if (valor == 0) return 0;
    if (meta == 0) return 100;
    return (valor * 100 / meta) ~/ 1;
  }
}
