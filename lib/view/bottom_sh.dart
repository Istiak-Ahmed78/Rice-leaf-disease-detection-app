import 'package:flutter/material.dart';
import 'package:ml_web_app/models/response_model.dart';
import 'package:ml_web_app/view/methods.dart';

void showResultSheet(ResponseModel result, BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'আপনার শষ্য ${getDiseaseNameInBangle(result.predicted)} দ্বারা আক্রান্ত হয়েছে |',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'সম্ভাবনা: ${convertNumber((result.confidance * 100).round())}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              getHelpWidget(result.predicted, context),
            ],
          ),
        );
      });
}

String getDiseaseNameInBangle(String nameInEnglish) {
  switch (nameInEnglish) {
    case 'Leaf bright':
      return 'লীফ ব্লাইট';
    case 'Leaf smut':
      return 'লীফ ব্লাস্ট';
    case 'Brown spot':
      return 'ব্রাউন স্পট';
    default:
      return '';
  }
}

Widget getHelpWidget(String nameInEnglish, BuildContext context) {
  switch (nameInEnglish) {
    case 'Leaf bright':
      return leafBlightHelp(context);
    case 'Leaf smut':
      return brownSpotHelp(context);
    case 'Brown spot':
      return leafSmuttHelp(context);
    default:
      return const SizedBox();
  }
}

Widget leafBlightHelp(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'নিচের কাজগুলো করুন',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Icon(
              Icons.circle,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('আক্রান্ত পরিত্যক্ত অংশ সংগ্রহ করে নষ্ট করা।'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('কন্দ শোধন করা (প্রতি লিটার পানিতে ২ গ্রাম ব্যাভিষ্টিন বা ২.৫ গ্রাম ভিটাভেক্স ২০০)।')),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('প্রতি লিটার পানিতে ২ গ্রাম রোভরাল একক ভাবে বা ২ গ্রাম রিডোমেল গোল্ড একত্রে মিশিয়ে  স্প্রে করা।')),
          ],
        ),
      ],
    );
Widget brownSpotHelp(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'নিচের কাজগুলো করুন',
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Icon(
              Icons.circle,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('রোগমুক্ত বীজ ব্যবহার করুন ।'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('বপনের পূর্বে কেজি প্রতি ৩ গ্রাম প্রোভ্যাক্স বা কার্বেন্ডাজিম মিশিয়ে বীজ শোধন করুন।।')),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('ফসল কাটার পর আক্রান্ত জমি ও তার আসে-পাশের জমির নাড়া পুড়িয়ে দিন।')),
          ],
        ),
      ],
    );
Widget leafSmuttHelp(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'নিচের কাজগুলো করুন',
          style: TextStyle(color: Colors.red),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Icon(
              Icons.circle,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('ধান কাটার পর শুকিয়ে নিয়ে নাড়া জমিতেই পুড়িয়ে ফেলুন।'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('মাটি পরীক্ষা করে জমিতে সুষম সার প্রয়োগ করুন')),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.87, child: const Text('মাটিতে জৈব সার প্রয়োগ করুন এ রোগের আশঙ্কা থাকলে জমিতে পটাশ সার দুইবারে প্রয়োগ করুন')),
          ],
        ),
      ],
    );
