import 'package:flutter/material.dart';
import 'dart:math';
import 'package:money_mind/datetime/date_time_helper.dart';
import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
  //list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //add neww expense
  void addNewExpense(ExpenseItem newExpense){
    overallExpenseList.add(newExpense);

    notifyListeners();
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
  }

  //get weekday
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the date for the start of the week
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    //get today's date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++){
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek= today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;

  }
  /*
  convert overall list of expenses
  */
  Map<String,double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {
      //date (yyyymmdd) : amountTotForDay
    };

    for (var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }
      else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}