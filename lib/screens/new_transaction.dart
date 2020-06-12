import 'package:budget_app/models/transaction_rec.dart';
import 'package:budget_app/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewTransactionScreen extends StatelessWidget {
  const NewTransactionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, top: 24, left: 16, right: 16),
                child: Text(
                  "New Transaction",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          NewTransactionForm(
            key: Key("newTransactionForm"),
          ),
        ],
      ),
    );
  }
}

class CategoriesList extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;

  CategoriesList({
    Key key,
    this.onCategorySelected,
  }) : super(key: key);
  @override
  CategoriesListState createState() => CategoriesListState();
}

// CTN Creating category lists
class CategoriesListState extends State<CategoriesList> {
  int _selectedIndex = -1;
  bool _valid = true;
  final List<String> categories = [
    "Eating Out",
    "Shopping",
    "Groceries",
    "Travelling",
    "Entertainment",
    "Bills",
    "General"
  ];

  bool validate() {
    if (_selectedIndex == -1) {
      setState(() {
        _valid = false;
      });
      return false;
    }
    return true;
  }

  _onSelected(int index) {
    widget.onCategorySelected(categories[index]);
    setState(() {
      _selectedIndex = index;
      _valid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _valid ? 170 : 180,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    key: Key("${categories[index]}Tile"),
                    index: index,
                    name: categories[index],
                    selectedColor: Color(0xFF36F1AC),
                    selectedShadowColor: Color(0x2636F1AC),
                    selected: _selectedIndex == index,
                    onTap: _onSelected,
                  ),
                );
              }),
              scrollDirection: Axis.horizontal,
            ),
          ),
          !_valid
              ? Text(
                  "Please select a category for your transaction",
                  style: TextStyle(color: Theme.of(context).errorColor),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String name;
  final ValueChanged<int> onTap;
  final bool selected;
  final Color selectedColor;
  final Color selectedShadowColor;
  final int index;
  CategoryTile(
      {Key key,
      this.name,
      this.onTap,
      this.selected = false,
      @required this.selectedColor,
      @required this.selectedShadowColor,
      this.index})
      : super(key: key);

  String _categoryIcon() {
    switch (this.name) {
      case "Eating Out":
        {
          return 'assets/eating_out.svg';
        }
      case "Shopping":
        {
          return 'assets/shopping.svg';
        }
      case "Travelling":
        {
          return 'assets/travelling.svg';
        }
      case "Groceries":
        {
          return 'assets/groceries.svg';
        }
      case "Entertainment":
        {
          return 'assets/entertainment.svg';
        }
      case "Bills":
        {
          return 'assets/bills.svg';
        }
      default:
        {
          return 'assets/general.svg';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: selected ? 1 : 2,
          color: selected ? selectedColor : Color(0xFFDFDFDF),
        ),
        boxShadow: [
          selected
              ? BoxShadow(
                  color: selectedColor,
                  offset: Offset(0, 0),
                  blurRadius: 2.0,
                )
              : BoxShadow(
                  color: Color.fromARGB(0, 0, 0, 0),
                ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap(index),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(
                    _categoryIcon(),
                    semanticsLabel: 'Acme Logo',
                    height: 85,
                    width: 85,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewTransactionForm extends StatefulWidget {
  const NewTransactionForm({
    Key key,
  }) : super(key: key);

  @override
  NewTransactionFormState createState() => NewTransactionFormState();
}

class NewTransactionFormState extends State<NewTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryListKey = GlobalKey<CategoriesListState>();
  final _dateController = TextEditingController();
  TransactionRec transaction = new TransactionRec();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  CategoriesList(
                    key: _categoryListKey,
                    onCategorySelected: (String category) {
                      transaction.category = category;
                    },
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              key: Key("dateField"),
                              onSaved: (val) {
                                transaction.date =
                                    Timestamp.fromDate(selectedDate);
                              },
                              controller: _dateController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: "Date",
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter a date for your transaction";
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: TextFormField(
                          key: Key("nameField"),
                          onSaved: (val) => transaction.name = val,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter a name for your transaction";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: TextFormField(
                          key: Key("amountField"),
                          keyboardType: TextInputType.number,
                          onSaved: (val) => transaction.amount = num.parse(val),
                          decoration: InputDecoration(
                            labelText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter an amount for your transaction";
                            if (num.tryParse(value) == null)
                              return "Please use numbers only";
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: RaisedButton(
                    key: Key("newTransactionButton"),
                    onPressed: () {
                      _submitForm(context);
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    highlightElevation: 2,
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff36F1AC), Color(0xff2ECCAC)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Add Transaction",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Add loading in button when clicked
  _submitForm(BuildContext context) {
    final transactionsService =
        Provider.of<TransactionsService>(context, listen: false);
    final categoryListValid = _categoryListKey.currentState.validate();
    final textEntriesValid = _formKey.currentState.validate();
    final formValid = categoryListValid && textEntriesValid;
    if (formValid) {
      _formKey.currentState.save();
      transactionsService
          .addTransaction(
              Provider.of<FirebaseUser>(context, listen: false), transaction)
          .then(
        (value) {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
