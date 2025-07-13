class Seat {
  final int row;
  final int col;
  bool isSelected;
  final bool isBooked;

  Seat({
    required this.row,
    required this.col,
    this.isSelected = false,
    this.isBooked = false,
  });

  String get seatID {
    final colLabel = String.fromCharCode('A'.codeUnitAt(0) + col);
    return '${row + 1}-$colLabel';
  }
}
