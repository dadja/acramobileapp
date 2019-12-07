import 'package:flutter/material.dart';

Widget loadingcompleteWidget(Function whattodo, Color rightcolor) {
  return Container(
    child: Center(
      child: Column(
        children: <Widget>[
          Text("Collecte enrtegistree"),
          Container(
            padding: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: rightcolor,
              child: Text(
                "Revenir a la page de collecte",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // whattodo;
                whattodo();
              },
            ),
          )
        ],
      ),
    ),
  );
}

Widget noDataFoundWidget(String nodatafound) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: 100,
          height: 100,
          child: Image.asset("assets/folder.png"),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(nodatafound),
        SizedBox(
          height: 10.0,
        ),
      ],
    ),
  );
}

Widget noCustomDataFoundWidget(String imgpath, String msg) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Center(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: 100,
          height: 100,
          child: Image.asset(imgpath ?? "assets/folder.png"),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(msg ?? "No Data Found"),
        SizedBox(
          height: 10.0,
        ),
      ],
    )),
  );
}

formTextCol(String label, String val, {Color color}) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
    child: Column(
      children: <Widget>[
        // Expanded(
        //   flex: 1,
        // child:
        Text(
          label,
          style: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              color: color != null ? color : Colors.grey[900]),
          textAlign: TextAlign.right,
        ),
        // ),
        // Expanded(
        //   flex: 1,
        // child:
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            initialValue: val,
            enabled: false,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              fillColor: Colors.grey[300],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            style: TextStyle(
                fontSize: 14.0,
                color: color != null ? color : Colors.grey[900]),
          ),
        ),
        // ),
      ],
    ),
  );
}

formTextRow(String label, String val, {Color color}) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
    child: Row(
      children: <Widget>[
        // Expanded(
        //   flex: 1,
        // child:
        Text(
          label,
          style: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              color: color != null ? color : Colors.grey[900]),
          textAlign: TextAlign.right,
        ),
        // ),
        // Expanded(
        //   flex: 1,
        // child:
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextFormField(
            initialValue: val,
            enabled: false,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              fillColor: Colors.grey[300],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            style: TextStyle(
                fontSize: 14.0,
                color: color != null ? color : Colors.grey[900]),
          ),
        ),
        // ),
      ],
    ),
  );
}

class TextWithPadding extends StatelessWidget {
  final String text;
  final bool bold;
  final int fontSize;
  final int padding;
  final bool textCenter;
  final Color color;

  TextWithPadding(this.text,
      {this.bold = false,
      this.fontSize = 14,
      this.padding: 20,
      this.textCenter = true,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: padding.toDouble(), bottom: padding.toDouble()),
      child: Text(
        text,
        textAlign: textCenter ? TextAlign.center : TextAlign.left,
        style: TextStyle(
            color: color,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize.toDouble()),
      ),
    );
  }
}

// header(Client client) {
//   return (Column(
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//                 // color: Colors.green,
//                 border: Border.all(width: 2.0, color: Colors.grey),
//                 borderRadius: BorderRadius.all(Radius.circular(40))),
//             child: Icon(
//               Icons.person,
//               color: Colors.grey,
//               size: 48.0,
//             ),
//             padding: EdgeInsets.all(10.0),
//             margin: EdgeInsets.only(bottom: 10.0, top: 32.0),
//           ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//       TextWithPadding(
//         "${client.name}".toUpperCase(),
//         padding: 5,
//         bold: true,
//         fontSize: 16,
//       ),
//       TextWithPadding("${client.phone}", padding: 5, fontSize: 14),
//     ],
//   ));
// }

escape(String value) {
  return value != null ? value : "N/A";
}

textField(String label, String text, Color labelcolor) {
  return (TextFormField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: labelcolor),
    ),
    initialValue: text,
    enabled: false,
  ));
}
