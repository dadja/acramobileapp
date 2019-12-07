import 'package:acra/uidata.dart';
import 'package:flutter/material.dart';
import 'package:acra/app_localization.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Color selectedcolor;
  final Color unselectedcolor;
  final Function(List<String>) onSelectionChanged;
  MultiSelectChip(this.reportList, this.selectedcolor, this.unselectedcolor,
      {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

// MultiSelectChip(reportList),

class _MultiSelectChipState extends State<MultiSelectChip> {
  bool isSelected = false;

  List<String> selectedChoices = List();

  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          disabledColor: widget.unselectedcolor,
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey,
          selected: selectedChoices.contains(item),
          selectedColor: widget.selectedcolor,
          onSelected: (selected) {
            setState(() {
              // selectedChoice = item;
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white60,
        border: Border.all(
            color: UIData.watercolordark, width: 2.0, style: BorderStyle.solid),
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(AppLocalizations.of(context)
              .translate('water_form_usageeau_title')),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            children: _buildChoiceList(),
          ),
        ],
      ),
    );
  }
}
