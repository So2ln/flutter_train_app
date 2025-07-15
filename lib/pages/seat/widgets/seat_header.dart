import 'package:flutter/material.dart';

class SeatHeader extends StatelessWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatHeader({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.secondary;
    final seatColor = Theme.of(context).colorScheme.surfaceContainer;

    return Column(
      children: [
        // 출발역, 도착역 정보
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // 역 이름 길어져도 알아서 정렬되도록 expanded - flex 활용
          children: [
            /// 첫번째 expanded: 출발역
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  departureStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
              ),
            ),

            // 두번째 expanded: 화살표 아이콘
            Expanded(
              flex: 1,
              child: Center(
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                  color: iconColor,
                ),
              ),
            ),

            // 세번째 expanded: 도착역
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  arrivalStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 좌석 상태 labeling
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSeatStatusLabel(context, color: Colors.purple, text: '선택됨'),
            const SizedBox(width: 20),
            _buildSeatStatusLabel(context, color: seatColor, text: '선택안됨'),
          ],
        ),
      ],
    );
  }
}

// 좌석 상태 레이블 UI 위젯
Widget _buildSeatStatusLabel(
  BuildContext context, {
  required Color color,
  required String text,
}) {
  final textColor = Theme.of(context).colorScheme.onSurface;

  return Row(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      const SizedBox(width: 4),
      Text(text, style: TextStyle(color: textColor)),
    ],
  );
}
