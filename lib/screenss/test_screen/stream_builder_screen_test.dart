// import 'package:flutter/material.dart';
// class StreamScreen extends StatefulWidget {
//   const StreamScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StreamScreen> createState() => _StreamScreenState();
// }
//
// class _StreamScreenState extends State<StreamScreen> {
//   Stream<int> generateNumbers = (() async* {
//     await Future<void>.delayed(Duration(milliseconds: 2));
//
//     for (int i = 1; i <= 10; i++) {
//       await Future<void>.delayed(Duration(milliseconds: 1));
//       yield i;
//     }
//   })();
//   int number=2;
//   List<Widget> list=[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: StreamBuilder(
//               stream: generateNumbers,
//                 builder: (contest, snapshot){
//                 if(snapshot.connectionState==ConnectionState.waiting){
//                   return Center(child: CircularProgressIndicator(),);
//                 }
//                 else if(snapshot.hasData){
//                   int? res=snapshot.data;
//                   Widget data=Text("$number * $res = ${number*res!}",
//                     style: const TextStyle(color: Colors.red,fontSize: 40),
//                   );
//                   list.add(data);
//                   return ListView.builder(itemBuilder: (context,index){
//                     return Padding(padding: EdgeInsets.all(12),
//                     child: list[index],
//                     );
//                   });
//                   return Column(
//                     children: [
//                     Text("$number * $res = ${number*res!}",
//                     style: const TextStyle(color: Colors.red,fontSize: 40),
//                     )
//                     ],
//                   );
//                 }
//                 else if(snapshot.hasError){
//                   return Center(child: Text("${snapshot.error}"),);
//                 }
//                 else{
//                   return Center(child: Text("Please wait"),);
//                 }
//
//
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class StreamBuilderTestScreen extends StatefulWidget {
  const StreamBuilderTestScreen({Key? key}) : super(key: key);

  @override
  State<StreamBuilderTestScreen> createState() => _StreamBuilderTestScreenState();
}

class _StreamBuilderTestScreenState extends State<StreamBuilderTestScreen> {
  Stream<int> generateNumbers = (() async* {
    await Future<void>.delayed(Duration(seconds: 2));

    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  })();

  int number = 2;

  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<int>(
          stream: generateNumbers,
          builder: (
              BuildContext context,
              AsyncSnapshot<int> snapshot,
              ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                int? res = snapshot.data;
                Widget data = Text("$number x $res = ${number * res!}",
                    style:
                    const TextStyle(color: Colors.red, fontSize: 40));
                list.add(data);
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(12),
                        child: list[index],
                      );
                    });
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}

