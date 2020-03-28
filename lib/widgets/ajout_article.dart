import 'package:flutter/material.dart';
import 'dart:io';
import 'package:depotoir_test/modele/article.dart';
import 'package:depotoir_test/modele/bd_utilisateur.dart';

class Ajout extends StatefulWidget {

  int id;

  Ajout(int id) {
    this.id = id;
  }


  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {

  String image;
  String nom;
  String description;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ajouter'),
        actions: <Widget>[
          new FlatButton(
            onPressed: ajouter, 
            child: new Text('valider', style: new TextStyle(color: Colors.white)),
          )
        ]
      ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Text('Lieu a ajouter', textScaleFactor: 1.4, style: new TextStyle(color: Colors.red, fontStyle: FontStyle.italic),),
            new Card(
              elevation: 10.0,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (image == null)
                    ? new Image.asset('images\tof.jpg')
                    : new Image.file(new File(image)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new IconButton(icon: new Icon(Icons.camera_enhance), onPressed: null),
                      new IconButton(icon: new Icon(Icons.place), onPressed: null)
                    ],
                  ),
                  textField(TypeTextField.nom, 'nom du lieu'),
                  textField(TypeTextField.description, 'description du lieu'),
                ],
              ),
            )
          ]
        )
      ),
    );
  }

  TextField textField(TypeTextField type, String label) {
    return new TextField(
      decoration: new InputDecoration(labelText: label),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.description:
            description = string;
            break;
        }
      },
    );
  }

  void ajouter() {
    if (nom != null) {
      Map<String, dynamic> map = {'nom': nom, 'item': widget.id};
      if (description != null) {
        map['description'] = description;
      }
      if (image != null) {
        map['image'] = image;
      }
      Article article = new Article();
      article.fromMap(map);
      DatabaseClient().upsertArticle(article).then((value) {
        image = null;
        nom = null;
        description = null;
        Navigator.pop(context);
      });
    }
  }

}

enum TypeTextField {
  nom,
  description,
}