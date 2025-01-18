import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(
      {super.key, required this.onAddExpense, required this.context});
  final void Function(Expense newExpense) onAddExpense;
  final BuildContext context;
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

// // var _enteredValue = "";
// // void _saveTitleInput(String input) {
// //   _enteredValue = input;
// // }

Category _selectedCategory = Category.leisure;

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;
  void _showDatePicker() async {
    final initDate = DateTime.now();
    final firstDate = DateTime(initDate.year - 5, initDate.month, initDate.day);
    final lastDate = DateTime(initDate.year + 5, initDate.month, initDate.day);

    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSubmitExpense() {
    final bool isInValidTitle = _titleController.text.trim().isEmpty;
    final convertedAmount = double.tryParse(_amountController.text);
    final bool isInValidAmount = convertedAmount == null || convertedAmount < 0;
    final isInvalidDate = _selectedDate == null;

    if (isInvalidDate || isInValidAmount || isInValidTitle) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid input"),
          content: Text(
              "Please make sure all input fields are filled with valid data"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }
    Expense newExpense = Expense(
        title: _titleController.text,
        date: _selectedDate!,
        amount: convertedAmount,
        category: _selectedCategory);
    widget.onAddExpense(newExpense);
    Navigator.pop(widget.context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            // keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text("Enter amount"),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Select date"
                          : formatter.format(_selectedDate!),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _onSubmitExpense,
                  child: Text("Save expense"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
