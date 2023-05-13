import 'dart:io';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../bin/order_log.dart';
import 'order_log_test.mocks.dart'; // the file with the generated mock classes

// Add this annotation and specify the classes you want to mock
@GenerateMocks([File, IOSink])
void main() {
  // A test group for testing the writeOutputFile0 function
  group('writeOutputFile0', () {
    // A test case for writing the output file 0 with sample data
    test('should write the output file 0 with average quantity per order', () async {
      // Arrange
      // Create a mock output file using the generated class
      MockFile outputFile = MockFile();
      // Create a mock sink for writing to the output file using the generated class
      MockIOSink sink = MockIOSink();
      // Stub the openWrite method of the output file to return the mock sink
      when(outputFile.openWrite()).thenReturn(sink);
      when(sink.close()).thenAnswer((realInvocation) => Future(() => null));
      // Create a sample product quantity map
      Map<String, List<int>> productQuantity = {
        'Product A': [100, 10],
        'Product B': [50, 5],
        'Product C': [25, 2]
      };
      // Create a sample orders count
      int ordersCount = 20;
      // Act
      // Call the writeOutputFile0 function with the mock output file and the sample data
      writeOutputFile0(outputFile, productQuantity, ordersCount);
      // Assert
      // Verify that the sink has written the expected lines to the output file
      verify(sink.writeln('Product A, 5.0')).called(1);
      verify(sink.writeln('Product B, 2.5')).called(1);
      verify(sink.writeln('Product C, 1.25')).called(1);
      // Verify that the sink has closed the output file
      verify(sink.close()).called(1);
    });
  });

  // A test group for testing the writeOutputFile1 function
  group('writeOutputFile1', () {
    // A test case for writing the output file 1 with sample data
    test('should write the output file 1 with most popular brand per product', () {
      // Arrange
      // Create a mock output file using the generated class
      MockFile outputFile = MockFile();
      // Create a mock sink for writing to the output file using the generated class
      MockIOSink sink = MockIOSink();
      // Stub the openWrite method of the output file to return the mock sink
      when(outputFile.openWrite()).thenReturn(sink);
      when(sink.close()).thenAnswer((realInvocation) => Future(() => null));
      // Create a sample product brand map
      Map<String, Map<String, int>> productBrand = {
        'Product A': {'Brand X': 5, 'Brand Y': 3},
        'Product B': {'Brand Z': 4, 'Brand W': 2},
        'Product C': {'Brand V': 2, 'Brand U': 2}
      };
      // Act
      // Call the writeOutputFile1 function with the mock output file and the sample data
      writeOutputFile1(outputFile, productBrand);
      // Assert
      // Verify that the sink has written the expected lines to the output file
      verify(sink.writeln('Product A, Brand X')).called(1);
      verify(sink.writeln('Product B, Brand Z')).called(1);
      verify(sink.writeln('Product C, Brand V')).called(1); // arbitrary choice when there is a tie
      // Verify that the sink has closed the output file
      verify(sink.close()).called(1);
    });
  });
}
