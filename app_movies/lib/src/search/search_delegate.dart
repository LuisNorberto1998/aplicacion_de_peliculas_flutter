import 'package:flutter/material.dart';
import 'package:app_movies/src/models/pelicula_model.dart';
import 'package:app_movies/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = [
    'Spiderman',
    'Venom',
    'Wonder woman',
    'Iron Man',
    'Iron Man 2',
    'Iron Man 3',
    'Avengers',
  ];
  final peliculasRecientes = ['Rapidos y furiosos 9', 'La vuelta al mundo xd'];

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de nuestro AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Instruccion que crea los resultados a mostrar
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.blueAccent,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((peliculas) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peliculas.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(peliculas.title),
                subtitle: Text(peliculas.originalTitle),
                onTap: (){
                  close(context, '');
                  peliculas.uniqueId='';
                  Navigator.pushNamed(context, 'detalle', arguments: peliculas);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// Instruccion que crea los resultados a mostrar
//  final listaSugerida = (query.isEmpty)
//         ? peliculasRecientes
//         : peliculas
//             .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
//             .toList();

//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (contex, i) {
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida[i]),
//           onTap: () {
//             seleccion = listaSugerida[i];
//             showResults(context);
//           },
//         );
//       },
//     );
