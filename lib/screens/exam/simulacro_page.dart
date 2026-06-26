import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/providers/providers.dart';
import '../../core/router/route_paths.dart';
import '../../core/services/api_exception.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/api/interceptors/error_interceptor.dart';
import '../../data/dto/exam_dto.dart';
import '../../data/models/exam_model.dart';

enum _SimulacroPageStatus { loading, loaded, error, starting }

class SimulacroPage extends ConsumerStatefulWidget {
  const SimulacroPage({super.key});

  @override
  ConsumerState<SimulacroPage> createState() => _SimulacroPageState();
}

class _SimulacroPageState extends ConsumerState<SimulacroPage> {
  _SimulacroPageStatus _status = _SimulacroPageStatus.loading;
  ExamTemplate? _template;
  String? _userName;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadTemplate());
  }

  Future<void> _loadTemplate() async {
    setState(() {
      _status = _SimulacroPageStatus.loading;
      _errorMessage = null;
    });

    try {
      final session = ref.read(sessionManagerProvider);
      _userName = await session.getUserFullName();

      final template = await ref.read(examProvider).getExamTemplate(
            AppConfig.examTemplateId,
          );

      if (!mounted) return;
      setState(() {
        _template = template;
        _status = _SimulacroPageStatus.loaded;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _status = _SimulacroPageStatus.error;
        _errorMessage = _resolveErrorMessage(error);
      });
    }
  }

  Future<void> _startExam() async {
    if (_template == null || _status == _SimulacroPageStatus.starting) return;

    final studentId = await ref.read(sessionManagerProvider).getStudentId();
    if (studentId == null) {
      setState(() => _errorMessage = AppStrings.simulacroNoStudent);
      return;
    }

    setState(() {
      _status = _SimulacroPageStatus.starting;
      _errorMessage = null;
    });

    try {
      final studentExam = await ref.read(examProvider).startStudentExam(
            StartStudentExamRequestDto(
              studentId: studentId,
              examTemplateId: _template!.id,
            ),
          );

      await ref.read(sessionManagerProvider).saveStudentExamId(studentExam.id);

      if (!mounted) return;
      context.go(RoutePaths.examSession(studentExam.id));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _status = _SimulacroPageStatus.loaded;
        _errorMessage = _resolveErrorMessage(error);
      });
    }
  }

  String _resolveErrorMessage(Object error) {
    final apiException = readApiException(error);
    if (apiException != null) return apiException.message;
    if (error is ApiException) return error.message;
    return AppStrings.simulacroLoadError;
  }

  Future<void> _logout(BuildContext context) async {
    await ref.read(authProvider).logout();
    if (context.mounted) {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStarting = _status == _SimulacroPageStatus.starting;

    return Scaffold(
      backgroundColor: AppColors.backgroundBottom,
      appBar: AppBar(
        title: const Text(AppStrings.simulacroTitle),
        actions: [
          TextButton(
            onPressed: isStarting ? null : () => _logout(context),
            child: Text(
              AppStrings.logout,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: _buildBody(isStarting),
        ),
      ),
    );
  }

  Widget _buildBody(bool isStarting) {
    if (_status == _SimulacroPageStatus.loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (_status == _SimulacroPageStatus.error && _template == null) {
      return _ErrorView(
        message: _errorMessage ?? AppStrings.simulacroLoadError,
        onRetry: _loadTemplate,
      );
    }

    final template = _template!;
    final greetingName = _userName?.trim();
    final greeting = greetingName != null && greetingName.isNotEmpty
        ? '${AppStrings.simulacroGreeting}, $greetingName'
        : AppStrings.simulacroGreeting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(greeting, style: AppTextStyles.greeting),
        const SizedBox(height: 8),
        Text(AppStrings.simulacroSubtitle, style: AppTextStyles.welcome),
        const SizedBox(height: 24),
        Expanded(
          child: _SimulacroCard(
            name: template.name,
            durationMinutes: template.durationMinutes,
            questionCount: template.questionCount,
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            _errorMessage!,
            style: AppTextStyles.cardSubtitle.copyWith(
              color: const Color(0xFFDC2626),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          height: AppSizes.buttonHeight,
          child: ElevatedButton(
            onPressed: isStarting ? null : _startExam,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusButton),
              ),
            ),
            child: isStarting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    isStarting ? AppStrings.startingSimulacro : AppStrings.startSimulacro,
                    style: AppTextStyles.buttonLight,
                  ),
          ),
        ),
      ],
    );
  }
}

class _SimulacroCard extends StatelessWidget {
  const _SimulacroCard({
    required this.name,
    required this.durationMinutes,
    required this.questionCount,
  });

  final String name;
  final int durationMinutes;
  final int questionCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x142F6BEE),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppTextStyles.cardTitle),
          const SizedBox(height: 20),
          _InfoChip(
            icon: Icons.schedule_outlined,
            label:
                '${AppStrings.simulacroDuration}: $durationMinutes ${AppStrings.simulacroMinutes}',
          ),
          const SizedBox(height: 12),
          _InfoChip(
            icon: Icons.quiz_outlined,
            label: '${AppStrings.simulacroQuestions}: $questionCount',
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: AppTextStyles.cardSubtitle),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.welcome,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
