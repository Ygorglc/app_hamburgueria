//Nesse arquivo é criada toda a extrutura do menu lateral que contem as opções do app(botões), login e titulo.

//Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo 
import 'package:flutter/material.dart';
import 'package:hamburgueria/models/user_model.dart';
import 'package:hamburgueria/screens/login_screen.dart';
import 'package:hamburgueria/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  //cria o controlador da pagina
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          //Cria um degrade 
          gradient: LinearGradient(
              colors: [
                //define as cores do degrade
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              //define a posição do degrade
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );
    //criação do drawer que é o menu lateral
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          //cria uma lista para o menu
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              //cria o container para o titulo do menu 
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      //Titulo do menu
                      child: Text("Burguer\nLouco",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //Adiciona a mensagem Olá e pega o nome da pessoa
                            children: <Widget>[
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              //cria o botão/texto de entrar ou cadrastar
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou cadastre-se >"
                                  : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  //função para fazer o login
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                    //função para sair do login
                                  else
                                    model.signOut();
                                  },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              //faz uma divisão entre os itens
              Divider(),
              //define os botões do Drawer
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
