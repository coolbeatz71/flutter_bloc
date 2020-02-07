import 'dart:async';
import 'package:flutter_app/bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  CounterBloc() {
    _counterEventCtrl.stream.listen(_mapEventToState);
  }

  final _counterStateCtrl = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateCtrl.sink;
  Stream<int> get counter$ => _counterStateCtrl.stream;

  final _counterEventCtrl = StreamController<CounterEvent>();
  Sink<CounterEvent> get inCounterEvent => _counterEventCtrl.sink;

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else if (_counter > 0) _counter--;
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateCtrl.close();
    _counterEventCtrl.close();
  }
}
