#!/bin/bash
twarc2 search --start-time 2006-03-21 --end-time 2021-06-18 --archive '(diabetes OR #Diabetes OR #DiagnosedDiabetes OR #diagnosedDiabetes OR #Diagnoseddiabetes OR #diagnoseddiabetes OR diabetes) lang:en' > ../../data/diabetes.jsonl
