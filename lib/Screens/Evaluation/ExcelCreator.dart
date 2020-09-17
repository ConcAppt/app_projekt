import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:appprojekt/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/Database.dart';

Future<void> createExportFile(BuildContext context, User user, List docList, Map map,
    String quename, datum, List array) async {
  var excel = Excel.createExcel();
  int sheetName = 1;
  List<Sheet> mySheets = [];
  // print('array: $array');
  for (var sheetCounter = 0; sheetCounter < array.length; sheetCounter++) {
    if (array[sheetCounter] == true) {
      Future val = DBProvider.db.getValues(user.email, quename.toUpperCase(), sheetCounter);
      await val.then((data) async {
        Map answers = data;
        Future dat = DBProvider.db.getDate(user.email, quename.toUpperCase(), sheetCounter);
        await dat.then((data) async {
          print('answers: $answers');
          datum = data;

          mySheets.add(excel['Report $sheetName']);
          // print('sheet: $sheet');
          var cellName = mySheets[sheetName - 1].cell(CellIndex.indexByString("A1"));
          cellName.value = "Name: ${user.name}";

          var cellAge = mySheets[sheetName - 1].cell(CellIndex.indexByString("B1"));
          cellAge.value = "Age: ${user.age.toString()}";

          var cellMail = mySheets[sheetName - 1].cell(CellIndex.indexByString("C1"));
          cellMail.value = "E-Mail: ${user.email}";

          var cellQuestionnaire = mySheets[sheetName - 1].cell(CellIndex.indexByString("A3"));
          cellQuestionnaire.value = "Questionnaire: $quename";

          var cellDate = mySheets[sheetName - 1].cell(CellIndex.indexByString("A4"));
          cellDate.value = "Date: $datum";

          for (int counter = 0; counter < docList.length; counter++) {
            var cellA =
                mySheets[sheetName - 1].cell(CellIndex.indexByString("A${6 + counter * 5}"));
            cellA.value = "Question ${counter + 1}";
            var cellE =
                mySheets[sheetName - 1].cell(CellIndex.indexByString("E${6 + counter * 5}"));
            cellE.value = "Selected answer:";
            var cellE2 =
                mySheets[sheetName - 1].cell(CellIndex.indexByString("E${7 + counter * 5}"));
            cellE2.value = "${answers["Question ${counter + 1}"]}";

            DocumentSnapshot document = docList[counter];

            var mergedCellQuestion = mySheets[sheetName - 1].merge(
                CellIndex.indexByString("A${7 + counter * 5}"),
                CellIndex.indexByString("C${9 + counter * 5}"),
                customValue: document['description']);

            var cellQuestion =
                mySheets[sheetName - 1].cell(CellIndex.indexByString("A${7 + counter * 5}"));
            CellStyle cellStyle = CellStyle(
                textWrapping: TextWrapping.WrapText,
                verticalAlign: VerticalAlign.Top,
                horizontalAlign: HorizontalAlign.Left);
            cellQuestion.cellStyle = cellStyle;
          }
          sheetName = sheetName + 1;
        }, onError: (e) {
          print(e);
        });
      }, onError: (e) {
        print(e);
      });
    } else {}
  }

  Future<void> save() async {
    String outputFile = await localPath;
    excel.encode().then((onValue) {
      File(join(outputFile, 'exportfile.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

  save();
}

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
