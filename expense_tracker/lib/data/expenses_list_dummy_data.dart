import 'package:expense_tracker/models/expense.dart';

final List<Expense> registeredExpenses = [
  Expense(
      title: "Flutter Course",
      date: DateTime.now(),
      amount: 449.99,
      category: Category.work),
  Expense(
      title: "Football",
      date: DateTime.now(),
      amount: 15.0,
      category: Category.leisure),
];
