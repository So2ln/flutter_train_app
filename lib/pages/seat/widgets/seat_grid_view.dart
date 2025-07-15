import 'package:flutter/material.dart';
import 'package:flutter_train_app/models/seat.dart';

class SeatGridView extends StatelessWidget {
  final List<List<Seat>> seats;
  // final Seat? selectedSeat;
  final List<Seat> multipleSelectedSeats; // 다중 선택된 좌석
  final Function(int row, int col) onSeatTap; // 좌석 탭 시 호출될 함수 전달받기

  const SeatGridView({
    super.key,
    required this.seats,
    // required this.selectedSeat,
    required this.multipleSelectedSeats, // 다중 선택된 좌석
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: seats.length + 1,
      itemBuilder: (context, rowIndex) {
        if (rowIndex == 0) {
          return _buildHeaderRow(context); //column A,B,C,D
        } else {
          return _buildSeatRow(context, seats[rowIndex - 1], rowIndex - 1);
        }
      },
    );
  }

  // ABCD labeling column UI 위젯
  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // row: A label
          _buildSeatLabelBox(context, 'A'),
          const SizedBox(width: 4),
          // row: B label
          _buildSeatLabelBox(context, 'B'),

          // 행 번호가 들어갈 자리를 _buildSeatLabelBox(null)로 비우기
          const SizedBox(width: 20), // B와 빈 공간 사이 간격
          _buildSeatLabelBox(context, null), // 50x50 투명 박스
          const SizedBox(width: 20), // 빈 공간과 C 사이 간격
          // row: C label
          _buildSeatLabelBox(context, 'C'),
          const SizedBox(width: 4),
          // row: D label
          _buildSeatLabelBox(context, 'D'),
        ],
      ),
    );
  }

  // ABCD label을 감싸는 50x50 박스 추가
  Widget _buildSeatLabelBox(BuildContext context, String? label) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: label != null
          ? Text(label, style: TextStyle(fontSize: 18, color: textColor))
          : null,
    );
  }

  // 각 좌석의 column UI
  Widget _buildSeatRow(
    BuildContext context,
    List<Seat> rowSeats,
    int rowIndex,
  ) {
    final actualRowNum = rowIndex + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // A열 좌석 (idx: 0)
          _buildSeatWidget(context, rowSeats[0]),
          const SizedBox(width: 4),
          //B열 좌석
          _buildSeatWidget(context, rowSeats[1]),

          // column labeling box
          const SizedBox(width: 20),

          // 행 번호를 _buildSeatLabelBox로 그리기
          _buildSeatLabelBox(context, '$actualRowNum'), // 행 번호 출력
          const SizedBox(width: 20),

          // C열 좌석 (idx: 2)
          _buildSeatWidget(context, rowSeats[2]),
          const SizedBox(width: 4),
          //D열 좌석 (idx: 3)
          _buildSeatWidget(context, rowSeats[3]),
        ],
      ),
    );
  }

  // 각 좌석 위젯을 생성
  // 좌석이 선택된 상태인지 확인하고 색상을 변경
  Widget _buildSeatWidget(BuildContext context, Seat seat) {
    final seatColor = Theme.of(context).colorScheme.surfaceContainer;
    Color selectColor;
    Color borderColor = Colors.transparent;
    double borderWidth = 0.0;

    if (multipleSelectedSeats.contains(seat)) {
      selectColor = Colors.purple;
      borderColor = Colors.purple.shade900;
      borderWidth = 2.0;
    } else {
      selectColor = seatColor;
    }
    return GestureDetector(
      onTap: () => onSeatTap(seat.row, seat.col),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
