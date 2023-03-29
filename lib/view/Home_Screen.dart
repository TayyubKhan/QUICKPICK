import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/res/Components/Row_component.dart';
import 'package:mvvm/res/colors.dart';
import 'package:mvvm/utils/Routes/routes_name.dart';
import 'package:mvvm/utils/utilis.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Home_screen_View extends StatefulWidget {
  const Home_screen_View({Key? key}) : super(key: key);

  @override
  State<Home_screen_View> createState() => _Home_screen_ViewState();
}

class _Home_screen_ViewState extends State<Home_screen_View> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    final Userprefrences = Provider.of<UserViewModel>(context);
    return Scaffold(
        backgroundColor: const Color(0xff263238),
        appBar: AppBar(
          backgroundColor: primarycolor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Movies List",
            style: TextStyle(color: textcolor),
          ),
          actions: [
            InkWell(
              onTap: () {
                Userprefrences.remove();
              },
              child: const Center(child: Text("Logout")),
            )
          ],
        ),
        body: SafeArea(
          child: ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context) => homeViewViewModel,
            child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
              switch (value.moviesList.status!) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.moviesList.message.toString());
                case Status.COMPLETED:
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(22),
                          child: Container(
                            width: width,
                            height: height,
                            child: Column(
                              children: [
                                Image.network(
                                    fit: BoxFit.contain,
                                    width: 500,
                                    height: 350,
                                    value.moviesList.data!.movies![index]
                                        .posterurl!
                                        .toString(),
                                    errorBuilder: (context, error, stack) {
                                  return const Icon(
                                    size: 100,
                                    Icons.error,
                                    color: Colors.red,
                                  );
                                }),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                    value.moviesList.data!.movies![index].title!
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textcolor)),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row_Component(
                                    string1: "Genre:    ",
                                    string2: value
                                        .moviesList.data!.movies![index].genres!
                                        .toString()),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row_Component(
                                    string1: "Actors:   ",
                                    string2: value
                                        .moviesList.data!.movies![index].actors!
                                        .toString()),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row_Component(
                                    string1: "Release Date:   ",
                                    string2: value.moviesList.data!
                                        .movies![index].releaseDate!
                                        .toString()),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row(
                                  children: [
                                    const Text("Story Line:  ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: textcolor)),
                                    Flexible(
                                        child: Text(
                                      value.moviesList.data!.movies![index]
                                          .storyline!
                                          .toString(),
                                      style: const TextStyle(color: textcolor),
                                    )),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Row(
                                  children: [
                                    const Text('Rating:    ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: textcolor)),
                                    Text(
                                        Utilis.averageRating(value.moviesList
                                                .data!.movies![index].ratings!)
                                            .toStringAsFixed(1),
                                        style:
                                            const TextStyle(color: textcolor)),
                                    const Text("\\ 10",
                                        style: TextStyle(color: textcolor)),
                                    const Icon(
                                      Icons.star_outlined,
                                      color: Colors.yellow,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
              }
              return Container();
            }),
          ),
        ));
  }
}
