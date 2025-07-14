import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train_app/models/seat.dart';

// widget files
import 'package:flutter_train_app/pages/seat/widgets/seat_header.dart';
import 'package:flutter_train_app/pages/seat/widgets/seat_grid_view.dart';
import 'package:flutter_train_app/pages/seat/widgets/seat_booking_button.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<Seat>> _seats = []; // 좌석 데이터

  // 현재 선택된 좌석
  Seat? _selectedSeat;

  @override
  void initState() {
    super.initState(); // 이게 뭔지 모르겠는데, 추가하니까 경고가 사라짐! 아마 상태를 받는거같음.
    // 좌석 리스트 초기화
    for (int r = 0; r < 20; r++) {
      List<Seat> rowSeats = [];
      for (int c = 0; c < 4; c++) {
        rowSeats.add(Seat(row: r, col: c));
      }
      _seats.add(rowSeats);
    }
  }

  // 좌석 탭하면 선택/해제 로직
  void _toggleSeatSelect(int row, int col) {
    setState(() {
      final tappedSeat = _seats[row][col];

      //이미 예약된 좌석은 선택할 수 없도록
      if (tappedSeat.isBooked) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('이미 예약된 좌석입니다.')));
        return;
      }
      // 이미 선택된 좌석이 있다면, 그 좌석의 선택 상태 해제
      if (_selectedSeat != null) {
        _selectedSeat!.isSelected = false;
      }
      // 새로 선택한 좌석의 선택 상태 업데이트
      /// 이미 선택되어있으면 해제하는거고, 아니면 선택하는것
      tappedSeat.isSelected = !tappedSeat.isSelected;

      // _selectedSeat 변수 업데이트
      if (tappedSeat.isSelected) {
        _selectedSeat = tappedSeat; // 새로 선택된 좌석으로 저장하기!
      } else {
        _selectedSeat = null; // 선택 해제되면 null값 출력
      }
    });
  }

  // 좌석 예매 확인하기 팝업
  void _showBookingConfirm() {
    if (_selectedSeat == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('좌석을 선택해주세요.')));
      return;
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('예매 하시겠습니까?'),
          content: Text('좌석 : ${_selectedSeat!.seatID}'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: const Text('취소'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                setState(() {
                  if (_selectedSeat != null) {
                    _selectedSeat!.isSelected = false;
                    _selectedSeat = null;
                  }
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('예매가 완료되었습니다.')));
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택')),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // 전체 body는 column으로 감싸고 아래 좌석 부분만 listview!
          children: [
            // [출발역, 도착역] 분리 (SeatHeader)
            SeatHeader(
              departureStation: widget.departureStation,
              arrivalStation: widget.arrivalStation,
            ),
            const SizedBox(height: 20),

            // SeatGridView 위젯 분리
            Expanded(
              child: SeatGridView(
                seats: _seats,
                selectedSeat: _selectedSeat,
                onSeatTap: _toggleSeatSelect,
              ),
            ),

            // 예매하기 버튼 (SeatBookingButton)
            SeatBookingButton(
              onPressed: _showBookingConfirm,
              isSeatSelected: _selectedSeat != null,
            ),
          ],
        ),
      ),
    );
  }
}
