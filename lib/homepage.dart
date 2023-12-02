import 'package:ab_jokes/JokesModel.dart';
import 'package:ab_jokes/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AB'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
            child: FutureBuilder<JokesModel>(
          future: apiController.getApiRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              print('snapshot is here  $snapshot.data');
              return Center(
                child: Text('Opps Something went wrong $snapshot'),
              );
            } else if (!snapshot.hasData) {
              return const Text('Data not available');
            } else {
              return Center(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    print("Index: $index");
                    print("Data: ${snapshot.data}");
                    print("Joke Content: ${snapshot.data?.jokeContent}");

                    // Check if snapshot.data and snapshot.data!.jokeContent are not null
                    if (snapshot.data != null && snapshot.data!.jokeContent != null) {
                      return ListTile(
                        title: Text(
                          snapshot.data!.jokeContent![index] ?? "",
                          style: TextStyle(color: Colors.white),
                        ),
                        // You can add more widgets to display additional information
                      );
                    } else {
                      return ListTile(
                        title: Text(
                          'No jokes available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              );

            }
          },
        )),
      ),
    );
  }
}
