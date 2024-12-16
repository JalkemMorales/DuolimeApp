import 'package:duolime/handlers/listcategories.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  CardListState createState() => CardListState();
}

class CardListState extends State<Categories> {
  late Listcategories categories;
  late Map<String, String> args;
  bool _isLoading = true;
  bool _isDisposed = false;

  @override
  void initState() {
    categories = Listcategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      obtainData();
    }
  }

  Future<void> obtainData() async {
    debugPrint(_isDisposed.toString());
    if (!_isDisposed) {
      await categories.getCategories();
      if (!_isDisposed) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Categorias",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: categories.obtainLength(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/levels', arguments: {
                                            'category': categories.getNombre(index),
                                          });
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                            1,
                                      height: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              categories.getNombre(index),
                                              style: const TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 30.0),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 30.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
