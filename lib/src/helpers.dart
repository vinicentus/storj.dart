import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart';

extension StringHelpers on String {
  Pointer<Int8> stringToInt8Pointer() => toNativeUtf8().cast<Int8>();
}

extension PointerHelpers on Pointer {
  bool isNullPtr() => address == nullptr.address;
}

extension Int8Helpers on Pointer<Int8> {
  // TODO: check that the length of the returned string is correct
  String int8PointerToString() => cast<Utf8>().toDartString();
}

extension IntHelpers on int {
  /// To be used only on integer values that are known to be booleans.
  /// Throws if any other value than 1 or 0 is encountered.
  bool convertToBool() {
    switch (this) {
      case 1:
        return true;
      case 0:
        return false;
      default:
        throw FormatException(
            'Can\'t convert value to bool, unsupported value: ', this);
    }
  }
}

extension BoolHelpers on bool {
  convertToInt() => this ? 1 : 0;
}

void throwIfError(Pointer<UplinkError> error) {
  if (error.isNullPtr()) {
    // This is a nullptr
    print(
        'Nullpointer encounted, we shouldn\'t try to do anything with the value of this pointer...');
    return;
  }

  var actualError = error.ref;

  if (!actualError.message.isNullPtr()) {
    var errorMessage = actualError.message.cast<Utf8>().toDartString();
    throw Exception([actualError.code, errorMessage]);
  } else {
    throw Exception(actualError.code);
  }
}
