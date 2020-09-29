import 'package:flutter/material.dart';
import './../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeItem;

  TransactionList(this.transactions, this.removeItem);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    "Nenhuma transação casdastrada",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final trans = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text(
                          "R\$ ${trans.value}",
                        ))),
                  ),
                  title: Text(
                    trans.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat("d MMM y").format(trans.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () => removeItem(trans.id),
                          icon: Icon(Icons.delete),
                          label: Text("Excluir"),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => removeItem(trans.id),
                        ),
                ),
              );
            },
          );
  }
}
