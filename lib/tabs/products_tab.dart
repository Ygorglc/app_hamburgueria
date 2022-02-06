import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamburgueria/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      //pega a coleção de produtos que está no firebase
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          //cria a função animada de carregamento
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          //é criada a lista com...
          var dividedTiles = ListTile
              //pega cada documento por category Tile e retorna uma lista de documentos
              .divideTiles(
                  tiles: snapshot.data.documents.map((doc) {
                    return CategoryTile(doc);
                  }).toList(),
                  //cria a divisão entre os menu de produtos
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
