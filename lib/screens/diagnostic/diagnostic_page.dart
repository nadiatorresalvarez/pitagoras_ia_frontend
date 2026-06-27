import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/diagnostic_mock_data.dart';
import 'widgets/diagnostic_scaffold.dart';

class DiagnosticPage extends StatelessWidget {
  const DiagnosticPage({
    super.key,
    required this.careerName,
    required this.universityName,
  });

  final String careerName;
  final String universityName;

  @override
  Widget build(BuildContext context) {
    return DiagnosticScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          8,
          AppSizes.padding,
          AppSizes.padding,
        ),
        child: Column(
          children: [
            Text(
              AppStrings.diagnosticTitle,
              style: AppTextStyles.diagnosticHeroTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(careerName, style: AppTextStyles.diagnosticHeroSubtitle),
            Text(universityName, style: AppTextStyles.diagnosticHeroSubtitle),
            const SizedBox(height: 20),
            Image.asset(
              AppAssets.mascotExam,
              height: 160,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.diagnosticDescription,
              style: AppTextStyles.onboardingSubtitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DiagnosticInfoRow(
              icon: Image.asset(
                AppAssets.iconEvaluations,
                width: 28,
                height: 28,
              ),
              title: '${DiagnosticMockData.totalQuestions} preguntas',
              subtitle: AppStrings.diagnosticQuestionsSubtitle,
            ),
            const SizedBox(height: 10),
            DiagnosticInfoRow(
              icon: Image.asset(
                AppAssets.iconCalendar,
                width: 28,
                height: 28,
              ),
              title: '${DiagnosticMockData.durationMinutes} minutos',
              subtitle: AppStrings.diagnosticTimeSubtitle,
            ),
            const SizedBox(height: 10),
            DiagnosticInfoRow(
              icon: Image.asset(AppAssets.iconTopics, width: 28, height: 28),
              title: '${DiagnosticMockData.evaluatedAreas} áreas a evaluar',
              subtitle: AppStrings.diagnosticAreasSubtitle,
              trailing: Text(
                AppStrings.diagnosticAreasLink,
                style: AppTextStyles.linkAction.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  context.push(
                    RoutePaths.diagnosticExamPath(
                      careerName: careerName,
                      universityName: universityName,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusButton),
                  ),
                ),
                child: Text(
                  AppStrings.diagnosticStartButton,
                  style: AppTextStyles.buttonLight,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppStrings.diagnosticTimerNote,
              style: AppTextStyles.selectionSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
