import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 *  记住ios info.plist  修改！！！！
 *  flutter pub pub run intl_translation:extract_to_arb --output-dir=core/lib/src/i18n lib/message_localization.dart core/lib/src/i18n/messages.dart
 *  flutter pub pub run intl_translation:generate_from_arb --output-dir=core/lib/src/i18n/ --no-use-deferred-loading lib/message_localization.dart core/lib/src/i18n/messages.dart  core/lib/src/i18n/intl_*.arb
 * */

class MessageIntl {
  final Messages messages;
  MessageIntl(this.messages);

  static Future<MessageIntl> load(Locale local) {
    final String name = local.countryCode.isEmpty ? local.languageCode : local.toString();
    final String localName = Intl.canonicalizedLocale(name);
    
    return initializeMessages(localName).then((_) {
      Intl.defaultLocale = localName;
      return MessageIntl(Messages());
    });
  }
  
  static Messages of(BuildContext context) {
    return Localizations.of<MessageIntl>(context, MessageIntl).messages;
  }
}

class LEELocalizationDelegate extends LocalizationsDelegate<MessageIntl> {
  const LEELocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'fi', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MessageIntl> load(Locale locale) {
    print(locale.languageCode);
    return MessageIntl.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<MessageIntl> old) {
    // TODO: implement shouldReload
    return false;
  }
  
}