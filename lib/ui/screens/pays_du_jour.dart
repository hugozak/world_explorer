import 'package:flutter/material.dart';
import 'package:world_explorer/repositories/pays_du_jour_repository.dart';

class PaysDuJour extends StatefulWidget {
  const PaysDuJour({super.key});

  @override
  _PaysDuJourState createState() => _PaysDuJourState();
}

class _PaysDuJourState extends State<PaysDuJour> {
  List<dynamic> _paysDujour = [];

  @override
  void initState() {
    super.initState();
    _fetchPaysDuJour();
  }

  Future<void> _fetchPaysDuJour() async {
    final paysDuJour = await ApiService.fetchPaysDuJour();
    setState(() {
      _paysDujour = paysDuJour;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pays du jour'),
      ),
      body: _paysDujour.isEmpty
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : ListView.builder(
            itemCount: _paysDujour.length,
            itemBuilder: (context, index) {
              final country = _paysDujour[0];
              return ListTile(
                title: Text(country['name']['common']),
              );
            },
        )
    );
  }
}