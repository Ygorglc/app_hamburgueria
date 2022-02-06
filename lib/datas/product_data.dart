import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  //pega os dados dos produtos
  String category;
  String id;

  String title;
  String description;

  double price;

  List images;
  List sizes;

  //contrutor que recebe o documento do firebase para armazenar os seus dados
  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    images = snapshot.data["images"];
    sizes = snapshot.data["sizes"];
  }
  //função retorna os dados necessarios para a pagina do produto especifico
  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "description": description,
      "price": price
    };
  }

}