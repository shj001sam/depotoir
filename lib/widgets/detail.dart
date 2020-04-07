import 'package:depotoir_test/modele/item.dart';
import 'package:flutter/material.dart';
import 'package:depotoir_test/modele/article.dart';
import 'donnée_vide.dart';
import 'ajout_article.dart';
import 'package:depotoir_test/modele/bd_utilisateur.dart';
import 'dart:io';

class ItemDetail extends StatefulWidget {

  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }

  @override
  _ItemDetailState createState() => new _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {

  List<Article> article;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseClient().allArticle(widget.item.id).then((liste) {
      setState(() {
        article = liste;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
        actions: <Widget>[
          new FlatButton(onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
              return new Ajout(widget.item.id);
            })).then((value) {
              DatabaseClient().allArticle(widget.item.id).then((liste) {
                setState(() {
                  article = liste;
                });
              });
            });
          }, 
          child: new Text('ajouter', style: new TextStyle(color: Colors.white))),
        ],
      ),
      body: (article == null || article.length == 0)
      ? new DonneesVide()
        : new GridView.builder(
          itemCount: article.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
          itemBuilder: (context, i) {
            Article articles = article[i];
            return new Card(
              child: new Column(children: <Widget>[
                new Text(articles.nom),
                (articles.image == null)
                  ? new Image.asset('images/tof.jpg')
                  : new Image.file(new File(articles.image)),
                new Text((articles.description == null) ? 'Aucune description donnée': "Description: ${articles.description}"),
              ],)
            );
          }
          )
    );
  }
}