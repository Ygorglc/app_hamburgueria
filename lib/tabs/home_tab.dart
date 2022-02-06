//Nesse arquivo é criado toda a parte visual do pagina home, contruindo as disposiçõa das imagens contidas nela

//Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo 
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      // Cria um container 
      decoration: BoxDecoration(
        // Cria um degrade  ou gradiente de cores no background
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 15, 15, 15),
            Color.fromARGB(255, 30, 30, 30)
          ],
          //define o começo e o fim do gradiente/degrade
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );
    //Para criar um proximo item sobreposto usamos o stack
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        //Cria a barra superior frutuante e que se movimenta e some ao rolar para baixo
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novos Sabores"),
                centerTitle: true,
              ),
            ),
            //Pega dados assincronos
            FutureBuilder<QuerySnapshot>(
              //Pega os dados do Firebase
              future: Firestore.instance
              //Pega a coleção Home e ordena pela "pos" posição
                .collection("Home").orderBy("pos").getDocuments(),
                //É o responsavel por contruir a tela de acordo com o que é retornado no futuro
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  // por estarmos dentro de um sliver temos de usar funções sliver
                  //função para criar a figura de carregamento
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      //cria a animação de carregamento
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  //Função para organizar a grade da tela inicial
                  return SliverStaggeredGrid.count(
                      //Definição dos espaçamentos 
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                      //Pega a dimensão das imagens e mapeia elas
                      (doc){
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                      //Cria uma lista com os dados pegos
                    ).toList(),
                    //Pega as imagens
                    children: snapshot.data.documents.map(
                      (doc){
                        //Adiciona a função de transição em transparencia
                        return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc.data["image"],
                            fit: BoxFit.cover,
                        );
                      }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}
