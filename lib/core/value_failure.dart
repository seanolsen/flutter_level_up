import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidValue({
    required String failedValue,
  }) = InvalidValue<T>;
  const factory ValueFailure.invalidUsername({
    required String failedValue,
  }) = InvalidUsername<T>;
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = InvalidPassword<T>;
  const factory ValueFailure.tooShortLength({
    required String failedValue,
    required int min,
  }) = TooShort<T>;
  const factory ValueFailure.exceededLength({
    required String failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    required String failedValue,
  }) = Empty<T>;
  const factory ValueFailure.multiline({
    required String failedValue,
  }) = Multiline<T>;
  const factory ValueFailure.listTooLong({
    required List failedValue,
    required int max,
  }) = ListTooLong<T>;
  const factory ValueFailure.numberOutOfRange({
    required num failedValue,
  }) = NumberOutOfRange<T>;
  const factory ValueFailure.stringIsNotANumber({
    required String failedValue,
  }) = StringIsNotANumber<T>;
  const factory ValueFailure.stringContainsDigits({
    required String failedValue,
  }) = StringContainsDigits<T>;
  const factory ValueFailure.stringContainsNonLetterSymbols({
    required String failedValue,
  }) = StringContainsNonLetterSymbols<T>;
  const factory ValueFailure.invalidDateFormat({
    required String failedValue,
  }) = InvalidDateFormat<T>;

  const factory ValueFailure.dateOutOfRange({
    required String failedValue,
  }) = DateOutOfRange<T>;

  const factory ValueFailure.imageWidthLowerThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageWidthLowerThanAllowed<T>;

  const factory ValueFailure.imageWidthHigherThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageWidthHigherThanAllowed<T>;

  const factory ValueFailure.imageHeightLowerThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageHeightLowerThanAllowed<T>;

  const factory ValueFailure.imageHeightHigherThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageHeightHigherThanAllowed<T>;

  const factory ValueFailure.imageSizeLowerThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageSizeLowerThanAllowed<T>;

  const factory ValueFailure.imageSizeHigherThanAllowed({
    required num failedValue,
    required num allowedValue,
  }) = ImageHeightSizeThanAllowed<T>;

  const factory ValueFailure.mimeTypeIsNotAllowed({
    required String failedValue,
    required String allowedValue,
  }) = MimeTypeIsNotAllowed<T>;
}
