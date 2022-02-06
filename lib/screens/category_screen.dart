//Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamburgueria/datas/product_data.dart';
import 'package:hamburgueria/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  //cria um constutor para pegar o documento passado para recuperar os dados dos itens
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    //cria o container para mostrar os intem em especifico em uma pagina
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            //define a divisão de tela para organização em lista ou grade dos itens dos produtos 
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)
            ],
          ),
        ),
        //pega os dados futuros
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("products").document(snapshot.documentID)
            .collection("items").getDocuments(),
            builder: (context, snapshot){
              //função de crregamento animado
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              else

                return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      //configura o grade de itens que vai ser mostrado
                      GridView.builder(
                        padding: EdgeInsets.all(4.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.65,
                          ),
                          //pega a quantidade de itens que seram mostrados
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            //transforma o documento para um objeto para facilitar a manipulação dos dados  
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.snapshot.documentID;
                            return ProductTile("grid", data);
                          }
                      ),
                      //configura a lista de itens que vai ser mostrado
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.snapshot.documentID;
                            return ProductTile("list", data);
                          }
                      )
                    ]
                );
            }
        )
      ),
    );
  }
}
