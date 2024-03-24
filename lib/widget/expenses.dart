import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpeses = [
    Expense(
      title: 'flutter course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpeses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    var indexOfItem = _registeredExpeses.indexOf(expense);
    setState(() {
      _registeredExpeses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Expense deleted',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpeses.insert(indexOfItem, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget expense = _registeredExpeses.isEmpty
        ? Container(
            child: Center(
                child: Text(
              'No expense found, Harray add one!.',
              style: Theme.of(context).textTheme.titleLarge,
            )),
          )
        : ExpensesList(
            expeseList: _registeredExpeses,
            removeExpense: _removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        title: Text(
          'Flutter expense tracker',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: width < 600
          ? Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Expenses list',
                    style: Theme.of(context).textTheme.titleLarge),
                Expanded(
                  child: expense,
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Expenses this is test expense list list',
                    style: Theme.of(context).textTheme.titleLarge),
                Expanded(
                  child: expense,
                ),
              ],
            ),
    );
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expense, required this.category});

  ExpenseBucket.fromCategory(List<Expense> allExpenses, this.category)
      : expense = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expense;
  final Category category;

  double get totalExpenses {
    double sum = 0;

    for (Expense expenses in expense) {
      sum += expenses.amount;
    }

    return sum;
  }
}
