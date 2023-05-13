import 'dart:io';
import 'dart:convert';

void main() {
  print("Welcome to the product data analyzer program. Please enter the name of the input file:");
  // Read the input file name from stdin
  String inputFileName = stdin.readLineSync()!;
  // Open the input file for reading
  File inputFile = File(inputFileName);
  // Create two output files for writing
  File outputFile0 = File('0_$inputFileName');
  File outputFile1 = File('1_$inputFileName');
  // Create two maps to store the product data
  Map<String, List<int>> productQuantity = {}; // product name -> [total quantity, order count]
  Map<String, Map<String, int>> productBrand = {}; // product name -> brand name -> order count
  int ordersCount = 0;
  // Read the input file line by line
  inputFile.openRead().transform(utf8.decoder).transform(LineSplitter()).listen((line) {
    ordersCount++;
    // Split the line by comma and extract the relevant columns
    List<String> columns = line.split(',');
    String area = columns[1];
    String product = columns[2];
    int quantity = int.parse(columns[3]);
    String brand = columns[4];
    // Update the product quantity map
    if (productQuantity.containsKey(product)) {
      productQuantity[product]![0] += quantity; // increment the total quantity
      productQuantity[product]![1]++; // increment the order count
    } else {
      productQuantity[product] = [quantity, 1]; // initialize the list with quantity and order count
    }
    // Update the product brand map
    if (productBrand.containsKey(product)) {
      if (productBrand[product]!.containsKey(brand)) {
        if (productBrand[product] != null && productBrand[product]![brand] != null) {
          productBrand[product]![brand] = productBrand[product]![brand]! + 1;
        } // increment the order count for the brand
      } else {
        productBrand[product]![brand] = 1; // initialize the order count for the brand
      }
    } else {
      productBrand[product] = {brand: 1}; // initialize the map with brand and order count
    }
  }, onDone: () {
    // print(productQuantity);
    // print(productBrand);

    // Write the output files after reading all the lines
    writeOutputFile0(outputFile0, productQuantity, ordersCount);
    writeOutputFile1(outputFile1, productBrand);
    print("Finished writing the output files. You can find them in the same directory as the input file.");
  });
}

// A function to write the output file 0 with average quantity per order
void writeOutputFile0(File outputFile, Map<String, List<int>> productQuantity, int ordersCount) {
  // Open the output file for writing
  IOSink sink = outputFile.openWrite();

  // Iterate over the product quantity map and write each line
  productQuantity.forEach((product, list) {
    int totalQuantity = list[0];
    int orderCount = list[1];
    double averageQuantity = totalQuantity / ordersCount; // compute the average quantity per order
    sink.writeln('$product, $averageQuantity'); // write the product name and average quantity separated by comma
  });
  // Close the output file
  sink.close();
}

// A function to write the output file 1 with most popular brand per product
void writeOutputFile1(File outputFile, Map<String, Map<String, int>> productBrand) {
  // Open the output file for writing
  IOSink sink = outputFile.openWrite();
  // Iterate over the product brand map and write each line
  productBrand.forEach((product, brandMap) {
    String mostPopularBrand = '';
    int maxOrderCount = 0;
    // Iterate over the brand map and find the most popular brand with the highest order count
    brandMap.forEach((brand, orderCount) {
      if (orderCount > maxOrderCount) {
        mostPopularBrand = brand;
        maxOrderCount = orderCount;
      }
    });
    sink.writeln('$product, $mostPopularBrand'); // write the product name and most popular brand separated by comma
  });
  // Close the output file
  sink.close();
}
