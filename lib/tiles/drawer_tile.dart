//Nesse arquivo é configurado os botões, links referentes e as ações tomadas ao clicalos

 //Faz a importação de todos os arquivos necessario para funcionamento do app nesse arquivo 
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //passa para a pagina selecionada pelo respectivo botão
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        //cria um container que vai contex o icone e o texto
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              //faz as configurações dos icones
              Icon(
                icon,
                size: 32.0,
                color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              //faz as configurações do texto
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
