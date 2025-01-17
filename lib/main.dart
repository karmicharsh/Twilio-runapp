import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BookingHome(),
    );
  }
}

class BookingHome extends StatefulWidget {
  const BookingHome({super.key});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome> {
  final _formKeyBooking = GlobalKey<FormState>();
  final _formKeyCancellation = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bookingIdController = TextEditingController();

  void _submitBooking() {
    if (_formKeyBooking.currentState!.validate()) {
      // Send booking details to Twilio (logic to be added)
      print(
          "Booking Configured: ${_nameController.text}, ${_dateController.text}, ${_phoneController.text}");
    }
  }

  void _cancelBooking() {
    if (_formKeyCancellation.currentState!.validate()) {
      // Send cancellation details to Twilio (logic to be added)
      print("Booking Cancelled: ${_bookingIdController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking System")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Form
            const Text(
              "Configure Booking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKeyBooking,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Name is required" : null,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration:
                        const InputDecoration(labelText: "Date (YYYY-MM-DD)"),
                    validator: (value) =>
                        value!.isEmpty ? "Date is required" : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration:
                        const InputDecoration(labelText: "Phone Number"),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty || value.length != 10
                        ? "Valid phone number is required"
                        : null,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitBooking,
                    child: const Text("Submit Booking"),
                  ),
                ],
              ),
            ),
            const Divider(height: 32.0),

            // Booking Cancellation Form
            const Text(
              "Cancel Booking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKeyCancellation,
              child: Column(
                children: [
                  TextFormField(
                    controller: _bookingIdController,
                    decoration: const InputDecoration(labelText: "Booking ID"),
                    validator: (value) =>
                        value!.isEmpty ? "Booking ID is required" : null,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _cancelBooking,
                    child: const Text("Cancel Booking"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
