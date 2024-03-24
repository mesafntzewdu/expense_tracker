import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {required this.expeseList, required this.removeExpense, super.key});

  List<Expense> expeseList;
  final Function(Expense expense) removeExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expeseList.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: Theme.of(context).cardTheme.margin,
        ),
        onDismissed: (direction) {
          removeExpense(expeseList[index]);
        },
        key: ValueKey(expeseList[index]),
        child: ExpenseItem(expense: expeseList[index]),
      ),
    );
  }
}
