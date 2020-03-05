import 'package:flutter/material.dart';
import 'package:busca_deputados/model/deputados_model.dart';
import 'styles.dart';

class DeputadoInfo extends StatelessWidget{
  final Deputado deputado;

  DeputadoInfo(this.deputado);

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(deputado.nome, style: Styles.navBarTitle,)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _renderBody(context, deputado),
      )
    );
  }
  
  List<Widget> _renderBody(BuildContext context, Deputado deputado){
    var result = List<Widget>();
    result.add(_bannerImage(deputado.imagem, 350.0));
    result.addAll(_renderInfo(context, deputado));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, Deputado deputado){
    var result = List<Widget>();
    result.add(_sectionTitle(deputado.nome));
    result.add(_sectionText("Email: " +deputado.email));
    result.add(_sectionText("Partido: " +deputado.siglaPartido));
    result.add(_sectionText("UF: " +deputado.siglaUf));
    return result;
  }

  Widget _sectionTitle(String text){
    return Container(
      padding: EdgeInsets.fromLTRB(25.0,25.0,25.0,10.0),
      child: Text(text, 
        textAlign: TextAlign.left, 
        style: Styles.headerLarge));
  }
  Widget _sectionText(String text){
    return Container(
      padding: EdgeInsets.fromLTRB(25.0,15.0,25.0,15.0),
      child:Text(text, style: Styles.textDefault,)
    );
  }
  
  Widget _bannerImage(String url, double height){
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth)
    );
  }
}
