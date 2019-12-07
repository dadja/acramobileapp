import 'package:flutter/material.dart';
import 'package:acra/models/forms/listregionsdakar.dart';

class RegionDropDownFormFieldsec extends FormField<Region> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final String value;
  final List<Region> dataSource;
  final String textField;
  final Region valueField;
  final Function onChanged;

  RegionDropDownFormFieldsec(
      {FormFieldSetter<Region> onSaved,
      FormFieldValidator<Region> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value = "",
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<Region> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Region>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        // value: ,
                        onChanged: (Region newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<Region>(
                            value: item,
                            child: Text(item.nom),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}

class RegionDropDownFormField extends FormField<Region> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final Region value;
  final List<Region> dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;

  RegionDropDownFormField(
      {FormFieldSetter<Region> onSaved,
      FormFieldValidator<Region> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<Region> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Region>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: null ?? Region(),
                        onChanged: (Region newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<Region>(
                            value: item,
                            child: Text(item.nom),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}

class DepartementDropDownFormField extends FormField<Departement> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final Departement value;
  final List<Departement> dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;

  DepartementDropDownFormField(
      {FormFieldSetter<Departement> onSaved,
      FormFieldValidator<Departement> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<Departement> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Departement>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: value == null ? null : value,
                        onChanged: (Departement newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<Departement>(
                            value: item,
                            child: Text(item.nom),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}

class ArrondissementDropDownFormField extends FormField<Arrondissement> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final Arrondissement value;
  final List<Arrondissement> dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;

  ArrondissementDropDownFormField(
      {FormFieldSetter<Arrondissement> onSaved,
      FormFieldValidator<Arrondissement> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<Arrondissement> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Arrondissement>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: value == null ? null : value,
                        onChanged: (Arrondissement newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<Arrondissement>(
                            value: item,
                            child: Text(item.nom),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}

class CommuneDropDownFormField extends FormField<Commune> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final Commune value;
  final List<Commune> dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;

  CommuneDropDownFormField(
      {FormFieldSetter<Commune> onSaved,
      FormFieldValidator<Commune> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<Commune> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Commune>(
                        hint: Text(
                          hintText,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        value: value == null ? null : value,
                        onChanged: (Commune newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<Commune>(
                            value: item,
                            child: Text(item.nom),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700,
                        fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}
