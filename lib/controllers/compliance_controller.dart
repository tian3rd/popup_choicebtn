import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:popup_choicebtn/second_screen.dart';

import '../data/compliance.dart';

List<Compliance> compliances = [
  Compliance(
    content: "Compliance 1",
    isChecked: false,
  ),
  Compliance(
    content: "Compliance 2",
    isChecked: false,
  ),
  Compliance(
    content: "Compliance 3",
    isChecked: false,
  ),
  Compliance(
    content: "Compliance 4",
    isChecked: false,
  ),
];

List<dynamic> selectedCompliances = [];

String legalInfo = """
    This clinical item represents part (or completion) of an annual cycle of care '
    for a patient with a chronic disease.
    
    Use this cycle template in conjunction with the GYHSAC GPMP Letter Template '
    once annually or if there has been a significant change in a patients '
    condition.
    
    For a client with a chronic disease/condition
    it is beneficial to update both the template and the clinical indicators
    at a minimum of every 6 months to provide the minimum level of care.
    
    Refer to CARPA for the appropriate minimum interval for client review.
    Refer to RACGPOnline for further information.
    Consider billing the following MBS Items - 721, 723, 732, 2517 relevant
    to the completion of each stage of the review cycle.
  """;

String warningInfo = """
    Please tick all items to enter the detailed page.
  """;

class ComplianceController extends GetxController {
  var selectedComplianceValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void showMultiCheck() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return const ResponsiveMultiSelect();
      },
    );
  }
}

/*
 To rebuild the widget every time user changes the selection,
 we need to wrap MultiSelectDialog with a StatefulWidget.
 */
class ResponsiveMultiSelect extends StatefulWidget {
  const ResponsiveMultiSelect({
    Key? key,
  });

  @override
  _ResponsiveMultiSelectState createState() => _ResponsiveMultiSelectState();
}

class _ResponsiveMultiSelectState extends State<ResponsiveMultiSelect> {
  @override
  Widget build(BuildContext context) {
    bool allChecked = compliances.every((e) => e.isChecked!);
    return Container(
      child: MultiSelectDialog(
        listType: MultiSelectListType.LIST,
        initialValue: selectedCompliances,
        items: compliances.map((e) => MultiSelectItem(e, e.content!)).toList(),
        title: Column(
          children: [
            const Text("Compliances"),
            const SizedBox(
              height: 24,
            ),
            Text(legalInfo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                )),
            const SizedBox(
              height: 8,
            ),
            Text(
              warningInfo,
              style: TextStyle(
                fontSize: 10,
                color: allChecked ? Colors.transparent : Colors.red,
              ),
            ),
          ],
        ),
        selectedColor: Colors.blue,
        onSelectionChanged: (results) {
          // disable the confirm button if not every item is selected
          if (kDebugMode) {
            // print(results);
            print('${results.length} selected');
          }
          setState(() {
            selectedCompliances = results;
            var selectedItems = selectedCompliances.map((e) => e.content!);
            for (var e in compliances) {
              e.isChecked = selectedItems.contains(e.content!);
            }
            allChecked = compliances.every((e) => e.isChecked!);
          });
          if (kDebugMode) {
            print(selectedCompliances);
          }
        },
        height: MediaQuery.of(context).size.height * 0.2,
        confirmText: allChecked
            ? const Text("Confirm")
            : const Text("Confirm", style: TextStyle(color: Colors.grey)),
        onConfirm: (results) {
          if (allChecked) {
            // don't forget to reset the selection
            selectedCompliances = [];
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SecondScreen()));
          } else {
            if (kDebugMode) {
              print('Before rebuilding: $selectedCompliances');
            }
            // rebuild the widget to show the warning message
            ComplianceController().showMultiCheck();
            Get.snackbar("title", "message");
          }
        },
      ),
    );
  }
}
