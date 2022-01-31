import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/devices/devices.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class DeviceHandle<CustomTheme> extends ConsumerWidget {
  const DeviceHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    return ComparisonHandle<Device, CustomTheme>(
      multiRender: ComparisonSetting.devices,
      items: ref.read(devicesProvider).devices,
      buildItem: (Device e) => SelectionItem(
        name: e.name,
        selectedItem: workbenchProvider.state.device,
        item: e,
        onPressed: () {
          workbenchProvider.changedDevice(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousDevice,
      onNextPressed: workbenchProvider.nextDevice,
    );
  }

  IconData buildIcon(DeviceType type) {
    switch (type) {
      case DeviceType.watch:
        return Icons.watch;
      case DeviceType.mobile:
        return Icons.smartphone;
      case DeviceType.tablet:
        return Icons.tablet;
      case DeviceType.desktop:
        return Icons.desktop_windows;
      case DeviceType.unknown:
        return Icons.quiz;
    }
  }
}
