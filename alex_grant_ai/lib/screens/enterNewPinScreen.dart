import 'package:flutter/material.dart';
import 'confirmNewPinScreen.dart';
import 'confirmNewPinScreen.dart'; // Import the ConfirmNewPinScreen

class EnterNewPinScreen extends StatefulWidget {
  @override
  _EnterNewPinScreen createState() => _EnterNewPinScreen();
}

class _EnterNewPinScreen extends State<EnterNewPinScreen> {
  List<String> pin = [];

  void _onNumberTap(String number) {
    if (pin.length < 6) {
      setState(() {
        pin.add(number);
      });
      if (pin.length == 6) {
        _navigateToConfirmPinScreen();
      }
    }
  }

  void _onBackspace() {
    if (pin.isNotEmpty) {
      setState(() {
        pin.removeLast();
      });
    }
  }

  void _navigateToConfirmPinScreen() {
    String newPin = pin.join('');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmNewPinScreen(initialPin: newPin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Change Pin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter New Pin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildPinDots(),
            Spacer(),
            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: index < pin.length ? Colors.white : Colors.grey[800],
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
            .chunked(3)
            .map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((number) {
              return _buildNumberButton(number);
            }).toList(),
          );
        }),
        IconButton(
          icon: Icon(Icons.backspace, color: Colors.white),
          onPressed: _onBackspace,
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberTap(number),
      child: Container(
        margin: EdgeInsets.all(8),
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

extension on List {
  List<List<T>> chunked<T>(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks
          .add(List<T>.from(sublist(i, i + size > length ? length : i + size)));
    }
    return chunks;
  }
}
