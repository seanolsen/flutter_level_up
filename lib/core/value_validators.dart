import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

import 'value_failure.dart';

Either<ValueFailure<String>, String> validateUsername(String input) {
  if (input.length >= 3) {
    return right(input);
  } else {
    return left(ValueFailure.invalidUsername(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex = r'''^[A-Za-z0-9]+([\._-]{1}[A-Za-z0-9]+)*@[A-Za-z0-9]+([\.-]{1}[A-Za-z0-9]+)*(\.[A-Za-z]{2,6})$''';
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateMinStringLength(
  String input,
  int minLength,
  {
    int spacesPercentAllowed = 50
  }
) {
  final spacesPercent = (input.length - input.trim().replaceAll(' ', '').length) / input.length * 100;
  if (input.trim().length >= minLength && spacesPercent <= spacesPercentAllowed) {
    return right(input);
  } else {
    return left(ValueFailure.tooShortLength(failedValue: input, min: minLength));
  }
}

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.exceededLength(failedValue: input, max: maxLength));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(
  String? input
) {
  if (input != null && input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input ?? ''));
  }
}

Either<ValueFailure<String>, String> validateStringHasOnlyLetters(
  String input
) {
  final nonLetterSymbols = input.replaceAll(RegExp('[a-zA-Z\\s]'), '');
  if (nonLetterSymbols.isEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.stringContainsNonLetterSymbols(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateStringWithoutDigits(
  String input
) {
  if (input.replaceAll(RegExp('\\d'), '') != input) {
    return right(input);
  } else {
    return left(ValueFailure.stringContainsDigits(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateSingleLine(
  String input
) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<List<T>>, List<T>> validateMaxListLength<T>(
  List<T> input,
  int maxLength
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.listTooLong(failedValue: input, max: maxLength));
  }
}

Either<ValueFailure<String>, int> validateStringIsNumberOrEmpty(String input) {
  const regex = r'^\d*$';
  if (
    RegExp(regex).hasMatch(input)
  ) {
    try {
      return right(int.parse(input));
    } catch (e) {
      return left(ValueFailure.stringIsNotANumber(failedValue: input));
    }
  } else {
    return left(ValueFailure.stringIsNotANumber(failedValue: input));
  }
}

Either<ValueFailure<String>, int> validateNumberBetween(
  int input,
  int min,
  int? max,
) {
  if (
    input >= min
    && (
      max == null
      || input <= max
    )
  ) {
    return right(input);
  } else {
    return left(ValueFailure.numberOutOfRange(failedValue: input));
  }
}

Either<ValueFailure<String>, DateTime> validateDateFormat(String input, String format) {
  final dateTime = DateFormat(format).tryParse(input);
  if (dateTime != null) {
    return right(dateTime);
  } else {
    return left(ValueFailure.invalidDateFormat(failedValue: input));
  }
}

Either<ValueFailure<String>, DateTime> validateDateRange(DateTime input, DateTime min, DateTime max) {
  if (input.compareTo(min) >= 0 && input.compareTo(max) <= 0) {
    return right(input);
  } else {
    return left(ValueFailure.dateOutOfRange(failedValue: input.toString()));
  }
}

Either<ValueFailure<String>, String> validateMimeType(String input, Map<String, String> allowedMimeTypes) {
  if (allowedMimeTypes.keys.contains(input)) {
    return right(input);
  } else {
    return left(ValueFailure.mimeTypeIsNotAllowed(
      failedValue: input,
      allowedValue: allowedMimeTypes.values.join(', '),
    ));
  }
}
