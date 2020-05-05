import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),

            Expanded(
              child: ListaNoticias(newsService.getArticulosCategoriaSeleccionada)
            ),

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 75,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) {

          final cName = categorias[index].name;

          return Container(
            //width: 90,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    _CategoryBoton(categorias[index]),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${ cName[0].toUpperCase() }${ cName.substring(1) }',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}

class _CategoryBoton extends StatelessWidget {
  final CategoryModel categoria;

  const _CategoryBoton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final selectedCategory = Provider.of<NewsService>(context).selectedCategory;


    return GestureDetector(
      onTap: (){
        //print('${categoria.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (selectedCategory == this.categoria.name) ? miTema.accentColor : Colors.black54,
        ),
      ),
    );
  }
}
