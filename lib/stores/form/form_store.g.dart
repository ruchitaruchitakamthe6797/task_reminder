// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _FormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool>? _$canRegisterMobileComputed;

  @override
  bool get canRegisterMobile => (_$canRegisterMobileComputed ??= Computed<bool>(
          () => super.canRegisterMobile,
          name: '_FormStore.canRegisterMobile'))
      .value;
  Computed<bool>? _$canRegisterYourSelfComputed;

  @override
  bool get canRegisterYourSelf => (_$canRegisterYourSelfComputed ??=
          Computed<bool>(() => super.canRegisterYourSelf,
              name: '_FormStore.canRegisterYourSelf'))
      .value;
  Computed<bool>? _$canRegisterContactComputed;

  @override
  bool get canRegisterContact => (_$canRegisterContactComputed ??=
          Computed<bool>(() => super.canRegisterContact,
              name: '_FormStore.canRegisterContact'))
      .value;
  Computed<bool>? _$canRegisterAddressComputed;

  @override
  bool get canRegisterAddress => (_$canRegisterAddressComputed ??=
          Computed<bool>(() => super.canRegisterAddress,
              name: '_FormStore.canRegisterAddress'))
      .value;
  Computed<bool>? _$canAddAddressComputed;

  @override
  bool get canAddAddress =>
      (_$canAddAddressComputed ??= Computed<bool>(() => super.canAddAddress,
              name: '_FormStore.canAddAddress'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_FormStore.canForgetPassword'))
      .value;

  late final _$userEmailAtom =
      Atom(name: '_FormStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_FormStore.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$mobileAtom = Atom(name: '_FormStore.mobile', context: context);

  @override
  String get mobile {
    _$mobileAtom.reportRead();
    return super.mobile;
  }

  @override
  set mobile(String value) {
    _$mobileAtom.reportWrite(value, super.mobile, () {
      super.mobile = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_FormStore.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_FormStore.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$pincodeAtom = Atom(name: '_FormStore.pincode', context: context);

  @override
  String get pincode {
    _$pincodeAtom.reportRead();
    return super.pincode;
  }

  @override
  set pincode(String value) {
    _$pincodeAtom.reportWrite(value, super.pincode, () {
      super.pincode = value;
    });
  }

  late final _$flatNameAtom =
      Atom(name: '_FormStore.flatName', context: context);

  @override
  String get flatName {
    _$flatNameAtom.reportRead();
    return super.flatName;
  }

  @override
  set flatName(String value) {
    _$flatNameAtom.reportWrite(value, super.flatName, () {
      super.flatName = value;
    });
  }

  late final _$streetNameAtom =
      Atom(name: '_FormStore.streetName', context: context);

  @override
  String get streetName {
    _$streetNameAtom.reportRead();
    return super.streetName;
  }

  @override
  set streetName(String value) {
    _$streetNameAtom.reportWrite(value, super.streetName, () {
      super.streetName = value;
    });
  }

  late final _$ageAtom = Atom(name: '_FormStore.age', context: context);

  @override
  String get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(String value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$genderAtom = Atom(name: '_FormStore.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$successAtom = Atom(name: '_FormStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_FormStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_FormStore.register', context: context);

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  late final _$loginAsyncAction =
      AsyncAction('_FormStore.login', context: context);

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$forgotPasswordAsyncAction =
      AsyncAction('_FormStore.forgotPassword', context: context);

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_FormStore.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_FormStoreActionController =
      ActionController(name: '_FormStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMobile(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setMobile');
    try {
      return super.setMobile(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setFirstName');
    try {
      return super.setFirstName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setLastName');
    try {
      return super.setLastName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAge(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setAge');
    try {
      return super.setAge(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPinCode(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setPinCode');
    try {
      return super.setPinCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFlatName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setFlatName');
    try {
      return super.setFlatName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStreetName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setStreetName');
    try {
      return super.setStreetName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGender(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setGender');
    try {
      return super.setGender(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateMobile(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateMobile');
    try {
      return super.validateMobile(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFirstName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateFirstName');
    try {
      return super.validateFirstName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLastName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateLastName');
    try {
      return super.validateLastName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAge(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateAge');
    try {
      return super.validateAge(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFlatName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateFlatName');
    try {
      return super.validateFlatName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateStreetName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateStreetName');
    try {
      return super.validateStreetName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePincode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePincode');
    try {
      return super.validatePincode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGender(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateGender');
    try {
      return super.validateGender(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
password: ${password},
confirmPassword: ${confirmPassword},
mobile: ${mobile},
firstName: ${firstName},
lastName: ${lastName},
pincode: ${pincode},
flatName: ${flatName},
streetName: ${streetName},
age: ${age},
gender: ${gender},
success: ${success},
loading: ${loading},
canLogin: ${canLogin},
canRegister: ${canRegister},
canRegisterMobile: ${canRegisterMobile},
canRegisterYourSelf: ${canRegisterYourSelf},
canRegisterContact: ${canRegisterContact},
canRegisterAddress: ${canRegisterAddress},
canAddAddress: ${canAddAddress},
canForgetPassword: ${canForgetPassword}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterMobileComputed;

  @override
  bool get hasErrorsInRegisterMobile => (_$hasErrorsInRegisterMobileComputed ??=
          Computed<bool>(() => super.hasErrorsInRegisterMobile,
              name: '_FormErrorStore.hasErrorsInRegisterMobile'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterYourSelfComputed;

  @override
  bool get hasErrorsInRegisterYourSelf =>
      (_$hasErrorsInRegisterYourSelfComputed ??= Computed<bool>(
              () => super.hasErrorsInRegisterYourSelf,
              name: '_FormErrorStore.hasErrorsInRegisterYourSelf'))
          .value;
  Computed<bool>? _$hasErrorsInRegisterAddressComputed;

  @override
  bool get hasErrorsInRegisterAddress =>
      (_$hasErrorsInRegisterAddressComputed ??= Computed<bool>(
              () => super.hasErrorsInRegisterAddress,
              name: '_FormErrorStore.hasErrorsInRegisterAddress'))
          .value;
  Computed<bool>? _$hasErrorsInAddAddressComputed;

  @override
  bool get hasErrorsInAddAddress => (_$hasErrorsInAddAddressComputed ??=
          Computed<bool>(() => super.hasErrorsInAddAddress,
              name: '_FormErrorStore.hasErrorsInAddAddress'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterContactComputed;

  @override
  bool get hasErrorsInRegisterContact =>
      (_$hasErrorsInRegisterContactComputed ??= Computed<bool>(
              () => super.hasErrorsInRegisterContact,
              name: '_FormErrorStore.hasErrorsInRegisterContact'))
          .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;

  late final _$userEmailAtom =
      Atom(name: '_FormErrorStore.userEmail', context: context);

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormErrorStore.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_FormErrorStore.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$mobileAtom =
      Atom(name: '_FormErrorStore.mobile', context: context);

  @override
  String? get mobile {
    _$mobileAtom.reportRead();
    return super.mobile;
  }

  @override
  set mobile(String? value) {
    _$mobileAtom.reportWrite(value, super.mobile, () {
      super.mobile = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_FormErrorStore.firstName', context: context);

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_FormErrorStore.lastName', context: context);

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$ageAtom = Atom(name: '_FormErrorStore.age', context: context);

  @override
  String? get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(String? value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$flatNameAtom =
      Atom(name: '_FormErrorStore.flatName', context: context);

  @override
  String? get flatName {
    _$flatNameAtom.reportRead();
    return super.flatName;
  }

  @override
  set flatName(String? value) {
    _$flatNameAtom.reportWrite(value, super.flatName, () {
      super.flatName = value;
    });
  }

  late final _$streetNameAtom =
      Atom(name: '_FormErrorStore.streetName', context: context);

  @override
  String? get streetName {
    _$streetNameAtom.reportRead();
    return super.streetName;
  }

  @override
  set streetName(String? value) {
    _$streetNameAtom.reportWrite(value, super.streetName, () {
      super.streetName = value;
    });
  }

  late final _$pincodeAtom =
      Atom(name: '_FormErrorStore.pincode', context: context);

  @override
  String? get pincode {
    _$pincodeAtom.reportRead();
    return super.pincode;
  }

  @override
  set pincode(String? value) {
    _$pincodeAtom.reportWrite(value, super.pincode, () {
      super.pincode = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_FormErrorStore.gender', context: context);

  @override
  String? get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String? value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
password: ${password},
confirmPassword: ${confirmPassword},
mobile: ${mobile},
firstName: ${firstName},
lastName: ${lastName},
age: ${age},
flatName: ${flatName},
streetName: ${streetName},
pincode: ${pincode},
gender: ${gender},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegisterMobile: ${hasErrorsInRegisterMobile},
hasErrorsInRegisterYourSelf: ${hasErrorsInRegisterYourSelf},
hasErrorsInRegisterAddress: ${hasErrorsInRegisterAddress},
hasErrorsInAddAddress: ${hasErrorsInAddAddress},
hasErrorsInRegisterContact: ${hasErrorsInRegisterContact},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}
