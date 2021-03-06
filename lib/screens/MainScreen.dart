import 'package:flutter/material.dart';
import 'package:budgetplanner/services/Expenses_Data.dart';
import 'package:budgetplanner/Component/Widgets/Card.dart';
import 'package:budgetplanner/Component/Widgets/ListView.dart';
import 'package:budgetplanner/Component/Widgets/ModalBottomSheetWidget.dart';
import 'package:budgetplanner/Component/Widgets/TextWidget.dart';
import 'package:budgetplanner/Component/Constants/Constants.dart';
import 'package:budgetplanner/utilities/SizeConfig.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    SizeConfig().init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: ModalSheetWidget(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Constants.mainColor,
          size: SizeConfig.screenWidth * 10,
        ),
        backgroundColor: Constants.secondaryColor,
      ),
      backgroundColor: Constants.mainColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextWidget(
                  text: 'Balance',
                  size: SizeConfig.screenWidth * 5,
                  color: Constants.shadeOfSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  child: TextWidget(
                    text: Provider.of<ExpensesData>(context)
                        .currentBalance
                        .toString(),
                    size: SizeConfig.screenWidth * 20,
                  ),
                  onTap: () {
                    setState(() {
                      Provider.of<ExpensesData>(context).deleteAll();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CardWidget(
                      amount: Provider.of<ExpensesData>(context)
                          .totalIncome
                          .toString(),
                      kind: 'Income',
                      iconKind: Constants.incomeIcon,
                    ),
                    CardWidget(
                      amount: Provider.of<ExpensesData>(context)
                          .totalSpent
                          .toString(),
                      kind: 'Spent   ',
                      iconKind: Constants.spentIcon,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextWidget(
                  text: 'History',
                  size: SizeConfig.screenWidth * 10,
                  fontWeight: FontWeight.w600,
                ),
                const Divider(
                  color: Color(0xff212121),
                  height: 20,
                  thickness: 5,
                  indent: 10,
                  endIndent: 10,
                ),
                ListViewWidget (
                  expenses: Provider.of<ExpensesData>(context).getAllExpenses(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
