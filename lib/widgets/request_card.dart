import 'package:flutter/material.dart';
import '../models/request.dart';

class RequestCard extends StatelessWidget {
  final HelpRequest req;
  final VoidCallback? onMarkHandled;
  final VoidCallback? onDelete;

  const RequestCard({Key? key, required this.req, this.onMarkHandled, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urgencyColor = req.urgency == 'High'
        ? Colors.red[700]
        : req.urgency == 'Medium'
            ? Colors.orange[700]
            : Colors.green[700];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(req.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: urgencyColor, borderRadius: BorderRadius.circular(8)),
                  child: Text(req.urgency, style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(req.description),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateTime.fromMillisecondsSinceEpoch(req.timestamp).toLocal().toString().split('.')[0], style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                Row(children: [
                  if (req.status == 'pending')
                    TextButton(onPressed: onMarkHandled, child: Text('Mark as Handled')),
                  if (onDelete != null)
                    TextButton(onPressed: onDelete, child: Text('Delete', style: TextStyle(color: Colors.red)))
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
