import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/diagnostic_mock_data.dart';
import 'widgets/diagnostic_scaffold.dart';

class DiagnosticProcessingPage extends StatefulWidget {
  const DiagnosticProcessingPage({
    super.key,
    required this.careerName,
    required this.universityName,
  });

  final String careerName;
  final String universityName;

  @override
  State<DiagnosticProcessingPage> createState() =>
      _DiagnosticProcessingPageState();
}

class _DiagnosticProcessingPageState extends State<DiagnosticProcessingPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go(
        RoutePaths.diagnosticResultPath(
          careerName: widget.careerName,
          universityName: widget.universityName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DiagnosticScaffold(
      showBottomNav: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          8,
          AppSizes.padding,
          AppSizes.padding,
        ),
        child: Column(
          children: [
            Image.asset(
              AppAssets.mascotIdea,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.diagnosticProcessingTitle,
              style: AppTextStyles.diagnosticHeroTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.diagnosticProcessingSubtitle,
              style: AppTextStyles.onboardingSubtitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ...DiagnosticMockData.processingAreas.map(
              (area) => DiagnosticAreaProgressRow(
                name: area.name,
                iconAsset: area.iconAsset,
                percent: area.percent,
                isProcessing: area.isProcessing,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.diagnosticProcessingNote,
              style: AppTextStyles.selectionSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
