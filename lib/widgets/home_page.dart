import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_application/widgets/timer_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isStartedTimer = false;

  // timer method
  void _timerMethod() {
    isStartedTimer = !isStartedTimer;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isStartedTimer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isStartedTimer = false;
          });
          timer.cancel();
        }
      } else {
        setState(() {
          isStartedTimer = false;
        });
        timer.cancel();
      }
    });
  }

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
          Center(
            child: Image.asset('assets/images/pngwing.png'),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      //переход на экран пикер
                      MaterialPageRoute(
                        builder: (context) {
                          return Picker(
                            callback: (minutes, seconds) {
                              setState(() {
                                _counter = minutes * 60 + seconds;
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width -
                        50, //ширина экрана минус 50
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                minuteString((_counter / 60)
                                    .floor()), // функция возвращает минут минуты минута
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                (_counter / 60)
                                    .floor()
                                    .toString(), // сколько минут с оркгулением (floor) вниз
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 66),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 60),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                seconds(_counter % 60),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                (_counter % 60).toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 66),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20), // отступ

                GestureDetector(
                  onTap: _timerMethod,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: !isStartedTimer ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        isStartedTimer ? 'Стоп' : 'Старт',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ), // кнопка старт/стоп

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _counter = 0;
                      isStartedTimer = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        'Сброс',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ), // кнопка сброс
              ],
            ),
          )
        ],
      ),
    );
  }
}
