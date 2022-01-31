import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/localization/localization.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class LocalizationHandle<CustomTheme> extends ConsumerWidget {
  const LocalizationHandle({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    return ComparisonHandle<Locale, CustomTheme>(
      multiRender: ComparisonSetting.localization,
      items: ref.read(localizationProvider).supportedLocales,
      buildItem: (Locale e) => SelectionItem(
        name: e.toLanguageTag(),
        selectedItem: workbenchState.locale,
        item: e,
        onPressed: () {
          workbenchProvider.changedLocale(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousLocale,
      onNextPressed: workbenchProvider.nextLocale,
    );
  }
}
