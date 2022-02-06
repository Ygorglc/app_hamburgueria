//Esse arquivo que faz uma classe que vai possuir todas as funções de conexão e manipulação do banco de dados
//Contem as funções de:
//Login
//Cadastro
//
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
//pega o ususario do firebase
  FirebaseUser firebaseUser;
///pega os dados do usuario
  Map<String, dynamic> userData = Map();
//variavel que indica se tá carregando
  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }
//função para cadastrar a pessoa no banco de dados
  void signUp({@required Map<String, dynamic> userData, @required String pass,
      @required VoidCallback onSuccess, @required VoidCallback onFail}){

    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }
// Função de login do usuario e recupera seus dados de usuario 
  void signIn({@required String email, @required String pass,
      @required VoidCallback onSuccess, @required VoidCallback onFail}) async {

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
      (user) async {
        firebaseUser = user;

        await _loadCurrentUser();

        onSuccess();
        isLoading = false;
        notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }
// Função para fazero o Logout do usuario no aplicativo, limpando todo conteudo referente ao usuario que está no app
  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser =
          await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

}