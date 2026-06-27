import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/diagnostic_mock_data.dart';
import 'widgets/diagnostic_scaffold.dart';
import 'widgets/diagnostic_widgets.dart';

class DiagnosticExamPage extends StatefulWidget {
  const DiagnosticExamPage({
    super.key,
    required this.careerName,
    required this.universityName,
  });

  final String careerName;
  final String universityName;

  @override
  State<DiagnosticExamPage> createState() => _DiagnosticExamPageState();
}

class _DiagnosticExamPageState extends State<DiagnosticExamPage> {
  int _selectedIndex = 1;
  final int _remainingSeconds = 59 * 60 + 32;
  final _question = DiagnosticMockData.demoQuestion;

  void _goToProcessing() {
    context.push(
      RoutePaths.diagnosticProcessingPath(
        careerName: widget.careerName,
        universityName: widget.universityName,
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.diagnosticCardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bubble,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatTime(_remainingSeconds),
                          style: AppTextStyles.selectionTitle.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppStrings.diagnosticQuestionProgress(1),
                    style: AppTextStyles.selectionSubtitle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.chipBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                _question.area,
                style: AppTextStyles.chipLabel,
              ),
            ),
            const SizedBox(height: 16),
            Text(_question.stem, style: AppTextStyles.diagnosticQuestion),
            const SizedBox(height: 20),
            ...List.generate(_question.options.length, (index) {
              final option = _question.options[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DiagnosticOptionTile(
                  label: option.label,
                  text: option.text,
                  isSelected: _selectedIndex == index,
                  onTap: () => setState(() => _selectedIndex = index),
                ),
              );
            }),
          ],
        ),
      ),
      bottomBar: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          12,
          AppSizes.padding,
          12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusButton),
                    ),
                  ),
                  child: Text(AppStrings.diagnosticPrevious),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border_rounded, size: 18),
                  label: Text(AppStrings.diagnosticMark),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusButton),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _goToProcessing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusButton),
                    ),
                  ),
                  child: Text(AppStrings.diagnosticNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
