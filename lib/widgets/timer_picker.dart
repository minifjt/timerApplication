import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  final Function(int minutes, int seconds) callback;

  const Picker({
    super.key,
    required this.callback,
  });

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  final FixedExtentScrollController
      _controller = // контроллеры для скрола (контроллер контролирует и управляет)
      FixedExtentScrollController();
  int currentMinutesIndex = 0;
  int currentSecondsIndex = 0;

  static const List<String> timeDurations = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Timer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Image.asset('assets/images/pngwing.png'),
          Center(
            child: Container(
              height: 34,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 125, top: 5),
              child: Text(
                minuteString(currentMinutesIndex),
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.61,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Center(
            // надпись секунды секунд
            child: Padding(
              padding: const EdgeInsets.only(left: 155, top: 5),
              child: Text(
                seconds(currentSecondsIndex),
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.61,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 200,
                child: ListWheelScrollView(
                  controller: _controller, // контроллер созданный выше
                  scrollBehavior:
                      const CupertinoScrollBehavior(), // анимация скрола
                  physics: const FixedExtentScrollPhysics(), // физика скрола
                  onSelectedItemChanged: (index) => {
                    setState(() {
                      currentMinutesIndex = index;
                    }),
                  }, // при измеенении выбранного объекта
                  itemExtent: 30,
                  children: List.generate(
                    60, // длина листа (массива)
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 15, top: 4.5),
                      child: Text(
                        timeDurations[index],
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.61,
                            color: currentMinutesIndex == index
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 70,
                child: ListWheelScrollView(
                  controller: _controller,
                  scrollBehavior: const CupertinoScrollBehavior(),
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) => {
                    setState(() {
                      currentSecondsIndex = index;
                    }),
                  },
                  itemExtent: 30,
                  children: List.generate(
                    60,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 20, top: 4.5),
                      child: Text(
                        timeDurations[index],
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.61,
                          color: currentSecondsIndex == index
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  widget.callback(currentMinutesIndex, currentSecondsIndex);
                  Navigator.of(context).pop(); // назад на предыдущий экран
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      'Выбрать',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String minuteString(int index) {
  final lastNumber = index % 10;

  if (lastNumber > 4 || lastNumber == 0 || (index > 10 && index < 15)) {
    return 'минут';
  }
  if (lastNumber > 1) return 'минуты';
  if (lastNumber == 1) return 'минута';
  return '';
}

String seconds(int index) {
  final lastNumber = index % 10;
  if (lastNumber > 4 || lastNumber == 0 || (index > 10 && index < 15)) {
    return 'секунд';
  }
  if (lastNumber > 1) return 'секунды';
  if (lastNumber == 1) return 'секунда';
  return '';
}
