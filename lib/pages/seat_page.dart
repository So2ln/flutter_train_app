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
  final int countPassangers; // 선택된 인원 수!!

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
    required this.countPassangers,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final List<List<Seat>> _seats = []; // 좌석 데이터

  // 현재 선택된 좌석
  // Seat? _selectedSeat; // single choice selection
  List<Seat> _multipleSelectedSeats = []; // multiple choice selection

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

      // //이미 예약된 좌석은 선택할 수 없도록
      // if (tappedSeat.isBooked) {
      //   _showCustomCupertinoAlert('이미 예약된 좌석입니다.');
      //   return;
      // }

      // // 이미 선택된 좌석이 있다면, 그 좌석의 선택 상태 해제
      // if (_selectedSeat != null) {
      //   _selectedSeat!.isSelected = false;
      // }
      // // 새로 선택한 좌석의 선택 상태 업데이트
      // /// 이미 선택되어있으면 해제하는거고, 아니면 선택하는것
      // tappedSeat.isSelected = !tappedSeat.isSelected;

      // _selectedSeat 변수 업데이트
      if (tappedSeat.isSelected) {
        tappedSeat.isSelected = false; // 이미 선택된 좌석이면 선택 해제
        _multipleSelectedSeats.remove(tappedSeat); // 선택 해제된 좌석 리스트에서 제거
      } else {
        // 선택 안된 좌석이고,
        //
        //선택된 좌석의 수가 허용 인원보다 적으면 선택
        if (_multipleSelectedSeats.length < widget.countPassangers) {
          // 인원 수 제한!!!
          tappedSeat.isSelected = true; // 새로 선택된 좌석의 선택 상태 업데이트
          _multipleSelectedSeats.add(tappedSeat); // 선택된 좌석을 리스트에 추가
        }
        // 인원 수 제한 초과 시
        else {
          _showCustomCupertinoAlert(
            '사과해요 나한테!!! \n ${widget.countPassangers}명까지만 선택 가능!!!',
          );
          return; // 인원 수 제한 초과 시 함수 종료
        }
      }
    });
  }

  // 좌석 예매 확인하기 팝업
  void _showBookingConfirm() {
    // if (_multipleSelectedSeats.length != widget.countPassangers) {
    //   // 리스트 길이와 인원 수 비교
    //   _showCustomCupertinoAlert(
    //     '사과해요 나한테!!! \n ${widget.countPassangers}개의 좌석을 모두 선택해주세요!',
    //   );
    //   return;
    // }

    //
    final String seatIds = _multipleSelectedSeats
        .map((seat) => seat.seatID)
        .join('\n');

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('예매 하시겠습니까?'),
          content: Text('좌석 : \n$seatIds'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text(
                '취소',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ), // theme.dart에서 seed color를 보라색으로 하는 바람에 default는 보라색이 됨. 그래서 따로 지정해줘야한다~
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                setState(() {
                  // 선택된 좌석을 초기화
                  for (var seat in _multipleSelectedSeats) {
                    seat.isSelected = false; // 선택된 좌석의 선택 상태 해제
                  }
                  _multipleSelectedSeats.clear(); // 선택된 좌석 리스트 초기화
                });

                //   if (_selectedSeat != null) {
                //     _selectedSeat!.isSelected = false;
                //     _selectedSeat = null;
                //   }
                // });
                // '예매하시겠습니까?' 팝업 닫기
                Navigator.of(context).pop();

                // 예매 완료 안내 팝업
                _showCustomCupertinoAlert('예매가 완료되었습니다.');
              },
              child: Text('확인'), // 얘는 isDestructiveAction 때문에 자동으로 빨간색이 됨
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: wallColor,
      appBar: AppBar(title: Text('좌석 선택')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // 전체 body는 column으로 감싸고 아래 좌석 부분만 listview!
          children: [
            // [출발역, 도착역] 분리 (SeatHeader)
            SeatHeader(
              departureStation: widget.departureStation,
              arrivalStation: widget.arrivalStation,
              countPassangers: widget.countPassangers, // 인원 수 전달
            ),
            const SizedBox(height: 20),

            // SeatGridView 위젯 분리
            Expanded(
              child: SeatGridView(
                seats: _seats,
                // selectedSeat: _selectedSeat,
                multipleSelectedSeats: _multipleSelectedSeats,
                onSeatTap: _toggleSeatSelect,
              ),
            ),

            // 예매하기 버튼 (SeatBookingButton)
            SeatBookingButton(
              // 선택된 좌석이 인원 수와 일치할 때만 활성화!!!!
              onPressed: _showBookingConfirm,
              // isSeatSelected: _selectedSeat != null,
              isSeatSelected:
                  _multipleSelectedSeats.length == widget.countPassangers,
            ),
          ],
        ),
      ),
    );
  }

  // 커스텀 알림 팝업 (1.8초 후 자동 닫힘)
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

    // 1.8초(1800밀리초) 후에 자동으로 팝업 닫기
    Future.delayed(const Duration(milliseconds: 1800), () {
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
