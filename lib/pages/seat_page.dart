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
  final List<List<Seat>> _seats = []; // 좌석 데이터

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
        _showCustomCupertinoAlert('이미 예약된 좌석입니다.');
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
      _showCustomCupertinoAlert('좌석을 선택해주세요!');
      return;
    }

    //
    final String seatId = _selectedSeat!.seatID;

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('예매 하시겠습니까?'),
          content: Text('좌석 : $seatId'),
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
                // '예매하시겠습니까?' 팝업 닫기
                Navigator.of(context).pop();

                // 예매 완료 안내 팝업
                _showCustomCupertinoAlert('예매가 완료되었습니다.');
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

  // 커스텀 알림 팝업 (1.5초 후 자동 닫힘)
  // CupertinoAlertDialog 위젯을 사용하여 iOS 스타일의 팝업 만들기!
  void _showCustomCupertinoAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // CupertinoAlertDialog 위젯
        return CupertinoAlertDialog(
          content: Text(message, style: TextStyle(fontSize: 18)), // 안내 메시지
          /// 버튼을 눌러서 팝업 닫게 하려면 아래 코드
          // actions: <Widget>[
          //   CupertinoDialogAction(
          //     child: Text('확인'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );

    // 1.5초(1500밀리초) 후에 자동으로 팝업 닫기
    Future.delayed(const Duration(milliseconds: 1500), () {
      //자꾸 오류 떠서 추가
      // 현재 context가 유효한지 확인
      if (!mounted) return; // 위젯이 트리에 없으면 더 이상 진행하지 않음

      // 현재 context가 유효하다면, 팝업 닫기
      // 팝업이 아직 화면에 있다면 닫기
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }
}
