//Nesse arquivo é criada as paginas e definida as ações do itens do menu lateral
//Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo 
import 'package:flutter/material.dart';
import 'package:hamburgueria/tabs/home_tab.dart';
import 'package:hamburgueria/tabs/orders_tab.dart';
import 'package:hamburgueria/tabs/places_tab.dart';
import 'package:hamburgueria/tabs/products_tab.dart';
import 'package:hamburgueria/widgets/cart_button.dart';
import 'package:hamburgueria/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  //É criado um controlador para auterar um pagina
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //Page view cria o menu que pertence a todas as paginas do app
    return PageView(
      //Executa a ação do controler
      controller: _pageController,
      //transforma a pagina em scroll
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
