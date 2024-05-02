import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.onExpenseDismissed, {super.key});

  final List<Expense> expenses;
  final void Function(Expense) onExpenseDismissed;

  List<Widget> buildExpenses() {
    List<Widget> result = [];

    return result;
  }

  @override
  Widget build(context) => ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) => onExpenseDismissed(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete),
            ),
            child: ExpenseItem(expenses[index]),
          ));
}
