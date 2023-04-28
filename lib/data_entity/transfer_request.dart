import 'package:equatable/equatable.dart';

class TransferRequest extends Equatable {
  final String from;
  final String to;
  final int amount;

  const TransferRequest(this.from, this.to, this.amount);

  @override
  List<Object> get props => [from, to, amount];
}
