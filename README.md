
# Product Data Analyzer

This program reads a CSV file with product data and writes two output files with some analysis.

## How to compile and run the program

- Make sure you have Dart installed on your system. You can follow the instructions [here](https://dart.dev/get-dart) to install Dart.
- Clone this repository or download the source code as a ZIP file.
- Navigate to the directory where the source code is located.
- To compile the program, run this command:
dart compile exe bin/order_log.dart

This will create an executable file named main.exe in the same directory.
To run the program, run this command:
./bin/order_log.exe

The program will prompt you to enter the name of the input file. Make sure the input file is in the same directory as the executable file.
The program will read the input file and write two output files in the same directory. The output files will have names starting with 0_ and 1_, followed by the input file name.
The output file 0 will contain the average quantity per order for each product.
The output file 1 will contain the most popular brand for each product.

## How to run unit tests
To run unit tests, you need to have some additional packages installed. You can use the pub command to get them:
pub get

This will install the test and mockito packages that are used for testing.
You also need to run the build_runner command to generate the mock classes for testing:
pub run build_runner build

This will create a file named order_log_test.mocks.dart in the same directory as the test file.
To run the unit tests, run this command:
dart test

This will run all the test cases in the order_log_test.dart file and report the results.
