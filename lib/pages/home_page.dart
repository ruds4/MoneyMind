import 'dart:ui'; // Import this for BackdropFilter
import 'package:flutter/material.dart';
import 'package:money_mind/data/expenses_data.dart';
import 'package:money_mind/models/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); // Updated for null safety

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  void addNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown.shade200,
        title: const Text(
          'New Expense',
          style: TextStyle(color: Colors.black87),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle:  TextStyle(color: Colors.brown[100],),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.brown.shade100,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: TextStyle(color: Colors.brown.shade100),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.brown.shade100,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: cancel,
            child: const Text('Cancel', style: TextStyle(color: Colors.black87)),
          ),
          ElevatedButton(
            onPressed: save,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87, // Black color for the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Save', style: TextStyle(color: Colors.brown.shade100)), // Ensure text is white
          ),
        ],
      ),
    );
  }

  void save() {
    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: nameController.text,
        amount: amountController.text,
        dateTime: DateTime.now(),
      );

      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    nameController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color(0xFFF6EEE5), // Ensure background is white for contrast
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text('Expenses',
            style: TextStyle(
                color: Color(0xFFF6EEE5),
                fontWeight: FontWeight.bold,
                fontSize: 25),),
          backgroundColor: const Color(0xFF2D241E), // Black AppBar for contrast
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: addNewExpenseBox,
          label: Text('Add Expense', style: TextStyle(color: Colors.brown.shade100)), // White text for visibility
          icon: Icon(Icons.add, color: Colors.brown.shade100), // White icon for visibility
          backgroundColor: const Color(0xFF2D241E), // Black background for button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView.builder(
          itemCount: value.getAllExpenseList().length,
          itemBuilder: (context, index) {
            final expense = value.getAllExpenseList()[index];
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white.withOpacity(0.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: ListTile(
                    title: Text(expense.name, style: const TextStyle(
                        color: Color(0xFF2D241E))),
                    subtitle: Text(expense.dateTime.toString(), style: const TextStyle(color: Color(0xFF2D241E), fontSize: 12)),
                    trailing: Text('${expense.amount} rs', style: const TextStyle(color: Color(0xFF2D241E))),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}