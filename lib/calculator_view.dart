import 'package:flutter/material.dart';
 
class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});
 
  @override
  State<CalculatorView> createState() => _CalculatorViewState();
 
}
 
class _CalculatorViewState extends State<CalculatorView> {
  dynamic displaytxt = 20;
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(color: txtcolor, fontSize: 35),
        ),
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: btncolor,
            padding: EdgeInsets.all(16)),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 20,
        title: Text('Caculator',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Calculator display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                ),
              ],
            ),
            // NUMBERS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.grey.shade800, Colors.white),
                calcButton('8', Colors.grey.shade800, Colors.white),
                calcButton('9', Colors.grey.shade800, Colors.white),
                calcButton('x', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.grey.shade800, Colors.white),
                calcButton('5', Colors.grey.shade800, Colors.white),
                calcButton('6', Colors.grey.shade800, Colors.white),
                calcButton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.grey.shade800, Colors.white),
                calcButton('2', Colors.grey.shade800, Colors.white),
                calcButton('3', Colors.grey.shade800, Colors.white),
                calcButton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.grey.shade800,
                      padding: EdgeInsets.fromLTRB(34, 15, 120, 15)),
                  onPressed: () {
                    calculation("0");
                  },
                  child: Text(
                    "0",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                calcButton('.', Colors.grey.shade800, Colors.white),
                calcButton('=', Colors.amber.shade700, Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
   //Calculator logic
  //Calculator logic
  dynamic text = '0';
double numOne = 0;
double numTwo = 0;
 
dynamic result = '';
dynamic finalResult = '';
dynamic opr = '';
dynamic preOpr = '';
 
void calculation(btnText) {
  if (btnText == 'AC') {
    clear();
  } else if (opr == '=' && btnText == '=') {
    if (preOpr == '+') {
      finalResult = add();
    } else if (preOpr == '-') {
      finalResult = sub();
    } else if (preOpr == 'x') {
      finalResult = mul();
    } else if (preOpr == '/') {
      finalResult = div();
    }
  } else if (btnText == '+' ||
      btnText == '-' ||
      btnText == 'x' ||
      btnText == '/' ||
      btnText == '=') {
    if (numOne == 0) {
      numOne = double.tryParse(result) ?? 0;
    } else {
      numTwo = double.tryParse(result) ?? 0;
    }
 
    if (opr == '+') {
      finalResult = add();
    } else if (opr == '-') {
      finalResult = sub();
    } else if (opr == 'x') {
      finalResult = mul();
    } else if (opr == '/') {
      finalResult = div();
    }
    preOpr = opr;
    opr = btnText;
    result = '';
  } else if (btnText == '%') {
    result = numOne / 100;
    finalResult = doesContainDecimal(result);
  } else if (btnText == '.') {
    if (!result.toString().contains('.')) {
      result = result.toString() + '.';
    }
    finalResult = result;
  } else if (btnText == '+/-') {
    result.toString().startsWith('-')
        ? result = result.toString().substring(1)
        : result = '-' + result.toString();
    finalResult = result;
  } else {
    result = result + btnText;
    finalResult = result;
  }
 
  setState(() {
    text = finalResult;
  });
}
 
double tryParseDouble(String value) {
  double? result = double.tryParse(value);
  return result ?? 0;
}
 
void clear() {
  numOne = 0;
  numTwo = 0;
  result = '';
  finalResult = '0';
  opr = '';
  preOpr = '';
}
 
String add() {
  result = (numOne + numTwo).toString();
  numOne = tryParseDouble(result);
  return doesContainDecimal(result);
}
 
String sub() {
  result = (numOne - numTwo).toString();
  numOne = tryParseDouble(result);
  return doesContainDecimal(result);
}
 
String mul() {
  result = (numOne * numTwo).toString();
  numOne = tryParseDouble(result);
  return doesContainDecimal(result);
}
 
String div() {
  if (numTwo != 0) {
    result = (numOne / numTwo).toString();
  } else {
    result = 'Error';
  }
  numOne = tryParseDouble(result);
  return doesContainDecimal(result);
}
 
String doesContainDecimal(dynamic result) {
  if (result.toString().contains('.')) {
    List<String> splitDecimal = result.toString().split('.');
    if (!(int.parse(splitDecimal[1]) > 0)) {
      return splitDecimal[0].toString();
    }
  }
  return result.toString();
}
}
