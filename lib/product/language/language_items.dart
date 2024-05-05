enum LanguageItem { appBarName, cardDefaultValue, textFieldHintText, elevatedButtonName }

extension LanguageItemExtension on LanguageItem {
  String languageItems() {
    switch (this) {
      case LanguageItem.appBarName:
        return 'Shared Prefernces';
      case LanguageItem.cardDefaultValue:
        return 'Enter your note.';
      case LanguageItem.textFieldHintText:
        return 'Write your note...';
      case LanguageItem.elevatedButtonName:
        return 'Save';
    }
  }
}
