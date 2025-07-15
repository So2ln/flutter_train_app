import 'package:flutter/material.dart';

class SeatBookingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSeatSelected;

  const SeatBookingButton({
    super.key,
    required this.onPressed,
    required this.isSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        // 버튼이 활성화된 상태에서만 onPressed 콜백을 호출하도록 설정
        // isSeatSelected가 true일 때만 버튼이 활성화되고, 그렇지 않으면 비활성화
        onPressed: isSeatSelected ? onPressed : null,
        style: ElevatedButton.styleFrom(
          // 활성화 시 보라색
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        child: Text(
          '예매 하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
