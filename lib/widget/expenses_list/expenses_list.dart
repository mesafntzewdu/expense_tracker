import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({required this.expeseList, super.key});

  List<Expense> expeseList;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expeseList.length,
        itemBuilder: (ctx, index) =>
            Center(child: ExpenseItem(expense: expeseList[index])));
  }
}
