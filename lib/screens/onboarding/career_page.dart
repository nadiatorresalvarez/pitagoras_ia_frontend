import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/providers/providers.dart';
import '../../core/router/route_paths.dart';
import '../../core/services/api_exception.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/api/interceptors/error_interceptor.dart';
import '../../data/models/catalog_model.dart';
import 'models/onboarding_mock_data.dart';
import 'widgets/onboarding_scaffold.dart';
import 'widgets/onboarding_selection_card.dart';

class CareerPage extends ConsumerStatefulWidget {
  const CareerPage({
    super.key,
    required this.universityId,
    required this.universityName,
    required this.areaId,
    required this.areaName,
  });

  final String universityId;
  final String universityName;
  final String areaId;
  final String areaName;

  @override
  ConsumerState<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends ConsumerState<CareerPage> {
  bool _loading = true;
  String? _errorMessage;
  List<Career> _careers = const [];
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCareers());
  }

  Future<void> _loadCareers() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final parsedId = int.tryParse(widget.universityId);
    if (parsedId == null) {
      setState(() {
        _loading = false;
        _careers = const [];
      });
      return;
    }

    try {
      final items = await ref.read(catalogProvider).listCareers(parsedId);
      if (!mounted) return;
      setState(() {
        _careers = items;
        _selectedId = items.isNotEmpty ? items.first.id : null;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = _resolveError(error);
      });
    }
  }

  String _resolveError(Object error) {
    final apiException = readApiException(error);
    if (apiException != null) return apiException.message;
    if (error is ApiException) return error.message;
    return AppStrings.simulacroLoadError;
  }

  List<CareerOption> get _displayCareers {
    if (_careers.isNotEmpty) {
      return _careers
          .map(
            (c) => CareerOption(
              id: c.id.toString(),
              name: c.name,
              areaName: widget.areaName,
              iconAsset: AppAssets.iconSistemas,
              minScore: 0,
              maxScore: 100,
            ),
          )
          .toList();
    }
    return OnboardingMockData.careersForArea(widget.areaId);
  }

  String get _mascotMessage {
    final careers = _displayCareers;
    final selected = careers.where((c) => c.id == _selectedId?.toString()).firstOrNull;
    if (selected == null) return AppStrings.onboardingCareerMascotDefault;
    return AppStrings.onboardingCareerMascot(selected.name);
  }

  void _selectCareer(CareerOption career) {
    setState(() => _selectedId = int.tryParse(career.id));

    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.push(
        RoutePaths.diagnosticPath(
          careerName: career.name,
          universityName: widget.universityName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final careers = _displayCareers;

    return OnboardingScaffold(
      bottomWidget: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          0,
          AppSizes.padding,
          12,
        ),
        child: MascotConfirmationBubble(
          message: _mascotMessage,
          mascotAsset: AppAssets.mascotPose3,
        ),
      ),
      body: _buildBody(careers),
    );
  }

  Widget _buildBody(List<CareerOption> careers) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.padding,
        8,
        AppSizes.padding,
        AppSizes.padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageTitle(title: AppStrings.onboardingCareerTitle),
          const SizedBox(height: 14),
          SelectedAreaChip(areaName: widget.areaName),
          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              style: AppTextStyles.cardSubtitle.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 20),
          ...careers.map((career) {
            final isSelected = _selectedId?.toString() == career.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: OnboardingSelectionCard(
                title: career.name,
                subtitle: career.areaName,
                scoreRange: _careers.isEmpty ? career.scoreRange : null,
                isSelected: isSelected,
                onTap: () => _selectCareer(career),
                leading: CareerIconAvatar(asset: career.iconAsset),
              ),
            );
          }),
        ],
      ),
    );
  }
}
