import 'package:flutter/material.dart';

import 'package:ug_quizapp/UI/welcome.dart';
const BASE_URL = 'https://staging.ugbazaar.com/api/V2/quiz';


void main() {
  runApp(MaterialApp(home: Welcome(scores: '',),));
}


