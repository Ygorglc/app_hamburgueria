 //Nesse arquivo é definido os parametros principais do app

 //Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo 
 import 'package:flutter/material.dart';
import 'package:hamburgueria/models/cart_model.dart';
import 'package:hamburgueria/models/user_model.dart';
import 'package:hamburgueria/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: "Buguerlouco",
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      //define a cor princiapal do app 
                      primaryColor: Color.fromARGB(255, 30, 30, 30)
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()
              ),
            );
          }
      ),
    );
  }
}
