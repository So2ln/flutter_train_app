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
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isSeatSelected ? onPressed : null,
          style: ElevatedButton.styleFrom(
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
      ),
    );
  }
}
