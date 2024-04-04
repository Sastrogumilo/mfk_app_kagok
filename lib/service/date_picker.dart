import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  final void Function(DateTime startDate, DateTime endDate) onDateRangeChanged;

  const DateRangePickerWidget({super.key, required this.onDateRangeChanged});

  @override
  // _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
    endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: startDate,
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (picked != null && picked != startDate) {
              setState(() {
                startDate = picked;
              });
              widget.onDateRangeChanged(startDate, endDate);
            }
          },
          child: Row(
            children: [
              const Text('Start Date: '),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  startDate.toString().split(' ')[0],
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 2),
        const Text("TO"),
        const SizedBox(width: 2),
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: endDate,
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (picked != null && picked != endDate) {
              setState(() {
                endDate = picked;
              });
              widget.onDateRangeChanged(startDate, endDate);
            }
          },
          child: Row(
            children: [
              const Text('End Date: '),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  endDate.toString().split(' ')[0],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
