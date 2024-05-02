import 'package:expense_tracker/common/widgets/styled_text.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpenseDialog() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    ).then((value) => {
          if (value != null && value is Expense)
            {
              setState(() {
                _registeredExpenses.add(value);
              })
            }
        });
  }

  void _addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const StyledText('Expense removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  Widget get getMainContent {
    Widget mainContent = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('No expenses found. Start adding some!'),
        ],
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(_registeredExpenses, _removeExpense);
    }

    return mainContent;
  }

  List<Widget> get DrawChart => [
        Expanded(child: Chart(expenses: _registeredExpenses)),
        Expanded(
          child: getMainContent,
        ),
      ];

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseDialog,
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: DrawChart,
            )
          : Row(
              children: DrawChart,
            ),
    );
  }
}

class ExpenseBucket {
  const ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.fromExpenses(this.expenses) : category = expenses.first.category;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((element) => element.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalAmount => expenses.fold(0, (previousValue, element) => previousValue + element.amount);

  double get totalExpences {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
