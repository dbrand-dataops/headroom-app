import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/item.dart';
import '../../../core/widgets/error_banner.dart';
import '../domain/selectable_item.dart';
import '../state/onboarding_controller.dart';
import '../state/onboarding_state.dart';
import 'add_custom_item_dialog.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingState state = ref.watch(onboardingControllerProvider);
    final OnboardingController controller = ref.read(
      onboardingControllerProvider.notifier,
    );

    final bool showSubmitBar = !state.isLoadingStarters && state.loadError == null;

    return Scaffold(
      appBar: AppBar(title: const Text('Set up your bucket')),
      body: SafeArea(child: _buildBody(context, state, controller)),
      bottomNavigationBar: showSubmitBar
          ? SafeArea(
              minimum: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: controller.canSubmit
                    ? () async {
                        await controller.submit();
                        // On success the auth state's `onboarded` flag
                        // flips and the router redirects to /home; on
                        // failure the error is shown inline above.
                      }
                    : null,
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Continue'),
              ),
            )
          : null,
    );
  }

  Widget _buildBody(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
  ) {
    if (state.isLoadingStarters) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ErrorBanner(
                message: state.loadError!,
                onRetry: controller.retryLoadStarters,
              ),
            ],
          ),
        ),
      );
    }

    final List<SelectableItem> fillers = <SelectableItem>[];
    final List<SelectableItem> emptiers = <SelectableItem>[];
    final List<int> fillerIndices = <int>[];
    final List<int> emptierIndices = <int>[];
    for (int i = 0; i < state.items.length; i++) {
      final SelectableItem item = state.items[i];
      if (item.type == ItemType.filler) {
        fillers.add(item);
        fillerIndices.add(i);
      } else {
        emptiers.add(item);
        emptierIndices.add(i);
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: <Widget>[
        Text(
          'Pick what applies to you',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'These become your starting items. You can add, edit or remove '
          'them later. Choose at least one thing that adds stress and one '
          'that relieves it.',
        ),
        const SizedBox(height: 24),
        _SectionHeader(
          title: 'Adds stress (Load)',
          onAdd: () => _addCustom(context, controller, ItemType.filler),
        ),
        const SizedBox(height: 8),
        _ItemChipList(
          items: fillers,
          indices: fillerIndices,
          controller: controller,
        ),
        const SizedBox(height: 24),
        _SectionHeader(
          title: 'Relieves stress (Relief)',
          onAdd: () => _addCustom(context, controller, ItemType.emptier),
        ),
        const SizedBox(height: 8),
        _ItemChipList(
          items: emptiers,
          indices: emptierIndices,
          controller: controller,
        ),
        if (state.submitError != null) ...<Widget>[
          const SizedBox(height: 24),
          ErrorBanner(message: state.submitError!),
        ],
      ],
    );
  }

  Future<void> _addCustom(
    BuildContext context,
    OnboardingController controller,
    ItemType type,
  ) async {
    final CustomItemResult? result = await showAddCustomItemDialog(context);
    if (result != null) {
      controller.addCustomItem(
        label: result.label,
        type: result.type,
        value: result.value,
      );
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onAdd});

  final String title;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Add custom'),
        ),
      ],
    );
  }
}

class _ItemChipList extends StatelessWidget {
  const _ItemChipList({
    required this.items,
    required this.indices,
    required this.controller,
  });

  final List<SelectableItem> items;
  final List<int> indices;
  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text('No suggestions - add a custom item above.');
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (int i = 0; i < items.length; i++)
          InputChip(
            label: Text('${items[i].label} (${items[i].defaultValue})'),
            selected: items[i].selected,
            onSelected: (_) => controller.toggleSelected(indices[i]),
            avatar: items[i].selected
                ? const Icon(Icons.check, size: 18)
                : null,
            onDeleted: items[i].isCustom
                ? () => controller.removeCustomItem(indices[i])
                : null,
          ),
      ],
    );
  }
}
