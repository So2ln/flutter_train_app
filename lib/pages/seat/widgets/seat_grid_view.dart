import 'package:flutter/material.dart';
import 'package:flutter_train_app/models/seat.dart';

class SeatGridView extends StatelessWidget {
  final List<List<Seat>> seats;
  final Seat? selectedSeat;
  final Function(int row, int col) onSeatTap; // 좌석 탭 시 호출될 함수 전달받기

  const SeatGridView({
    super.key,
    required this.seats,
    required this.selectedSeat,
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: seats.length + 1,
      itemBuilder: (context, rowIndex) {
        if (rowIndex == 0) {
          return _buildHeaderRow(); //column A,B,C,D
        } else {
          return _buildSeatRow(seats[rowIndex - 1], rowIndex - 1);
        }
      },
    );
  }

  // ABCD labeling column UI 위젯
  Widget _buildHeaderRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // row: A label
          _buildSeatLabelBox('A'),
          const SizedBox(width: 4),
          // row: B label
          _buildSeatLabelBox('B'),

          // A,B그룹과 C,D 그룹 간의 큰 간격
          /// 행 번호가 들어갈만큼
          Expanded(child: SizedBox.shrink()),

          // row: C label
          _buildSeatLabelBox('C'),
          const SizedBox(width: 4),
          // row: D label
          _buildSeatLabelBox('D'),
        ],
      ),
    );
  }

  // ABCD label을 감싸는 50x50 박스 추가
  Widget _buildSeatLabelBox(String label) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 각 좌석의 column UI
  Widget _buildSeatRow(List<Seat> rowSeats, int rowIndex) {
    final actualRowNum = rowIndex + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // A열 좌석 (idx: 0)
          _buildSeatWidget(rowSeats[0]),
          const SizedBox(width: 4),
          //B열 좌석
          _buildSeatWidget(rowSeats[1]),

          // column labeling box
          const SizedBox(width: 20),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Text('$actualRowNum', style: const TextStyle(fontSize: 18)),
          ),

          // C열 좌석 (idx: 2)
          _buildSeatWidget(rowSeats[2]),
          const SizedBox(width: 4),
          //D열 좌석 (idx: 3)
          _buildSeatWidget(rowSeats[3]),
        ],
      ),
    );
  }

  Widget _buildSeatWidget(Seat seat) {
    Color seatColor;
    if (seat.isSelected) {
      seatColor = Colors.purple;
    } else {
      seatColor = Colors.grey[300]!;
    }
    return GestureDetector(
      onTap: () => onSeatTap(seat.row, seat.col),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: (seat.isSelected && selectedSeat == seat)
                ? Colors.purple.shade900
                : Colors.transparent,
            width: (seat.isSelected && selectedSeat == seat) ? 2.0 : 0.0,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
