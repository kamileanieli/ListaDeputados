import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'styles.dart';
import 'deputadosInfo.dart';
import 'package:busca_deputados/model/deputados_model.dart';


class DeputadosList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeputadosListState();
  }
}

class _DeputadosListState extends State<DeputadosList> {
  final List<Deputado> items = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Deputados", style: Styles.navBarTitle,)),
      body: ListView.builder(
        itemCount: this.items.length,
        itemBuilder: _listViewItemBuilder
        )
    );
  }
  
  Widget _listViewItemBuilder(BuildContext context, int index){
    var deputados = this.items[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(deputados),
      title: _itemTitle(deputados),
      onTap: (){
        _navigationToDeputadosDetail(context, deputados);
    });
  }

  void _navigationToDeputadosDetail(BuildContext context, Deputado deputado) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context){return DeputadoInfo(deputado);}
    ));
  }

  Widget _itemThumbnail(Deputado deputado){
    return Container(
      constraints: BoxConstraints.tightFor(width: 50.0),
      child: deputado.imagem == null ? null : Image.network(deputado.imagem, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Deputado deputado){
    return Text(deputado.nome, style: Styles.textDefault);
  }

  void getNews() async{    
    final http.Response response = await http.get("https://dadosabertos.camara.leg.br/api/v2/deputados");
    final Map<String, dynamic> responseData = json.decode(response.body);
    responseData['dados'].forEach((d) {
      print(d);
      final Deputado deputado = Deputado(
        id: d["id"],
        nome: d["nome"],
        email: d["email"],
        siglaPartido: d["siglaPartido"],
        siglaUf: d["siglaUf"],
        imagem: d["urlFoto"],
      );
      setState(() {
        items.add(deputado);
      });
    });
  }
}