class AppStrings {
  AppStrings._();

  static const String appName = 'PITÁGORAS';
  static const String appNameAccent = 'IA';
  static const String slogan = 'Aprende. Practica. Avanza.';

  static const String loginGreeting = '¡Hola! 👋';
  static const String loginWelcome =
      'Bienvenido a tu compañero\ninteligente de estudio.';

  static const String loginTitle = 'Inicia sesión para continuar';
  static const String loginSubtitle =
      'Accede a tu cuenta y sigue aprendiendo';

  static const String emailLabel = 'Correo electrónico';
  static const String emailHint = 'tu@correo.com';
  static const String passwordLabel = 'Contraseña';
  static const String passwordHint = 'Tu contraseña';
  static const String loginButton = 'Iniciar sesión';
  static const String loginSubmitting = 'Iniciando…';
  static const String loginLinkRegister = '¿No tienes cuenta? Regístrate';
  static const String logout = 'Cerrar sesión';

  static const String emailRequired = 'Ingresa tu correo electrónico';
  static const String emailInvalid = 'Ingresa un correo válido';
  static const String passwordRequired = 'Ingresa tu contraseña';
  static const String loginErrorInvalidCredentials =
      'Correo o contraseña incorrectos';
  static const String loginErrorInactive = 'Cuenta inactiva';

  static const String registerGreeting = '¡Únete! 🚀';
  static const String registerWelcome =
      'Crea tu cuenta y comienza\na practicar con IA.';
  static const String registerTitle = 'Crea tu cuenta';
  static const String registerSubtitle =
      'Regístrate para acceder a los simulacros';
  static const String fullNameLabel = 'Nombre completo';
  static const String fullNameHint = 'Tu nombre';
  static const String registerPasswordHint = 'Mínimo 8 caracteres';
  static const String confirmPasswordLabel = 'Confirmar contraseña';
  static const String confirmPasswordHint = 'Repite tu contraseña';
  static const String registerButton = 'Crear cuenta';
  static const String registerSubmitting = 'Creando cuenta…';
  static const String registerLinkLogin = '¿Ya tienes cuenta? Inicia sesión';

  static const String fullNameRequired = 'Ingresa tu nombre completo';
  static const String fullNameTooShort = 'El nombre debe tener al menos 2 caracteres';
  static const String passwordMinLength = 'La contraseña debe tener al menos 8 caracteres';
  static const String confirmPasswordRequired = 'Confirma tu contraseña';
  static const String passwordsDoNotMatch = 'Las contraseñas no coinciden';
  static const String registerErrorEmailTaken = 'Este correo ya está registrado';

  static const String simulacroTitle = 'Elegir simulacro';
  static const String simulacroGreeting = 'Hola';
  static const String simulacroSubtitle = 'Estás a un paso de practicar';
  static const String simulacroDuration = 'Duración';
  static const String simulacroQuestions = 'Preguntas';
  static const String simulacroMinutes = 'min';
  static const String startSimulacro = 'Comenzar simulacro';
  static const String startingSimulacro = 'Preparando…';
  static const String simulacroLoadError = 'No se pudo cargar el simulacro';
  static const String simulacroNoStudent = 'Sesión inválida. Inicia sesión de nuevo.';
  static const String retry = 'Reintentar';

  static const String examTitle = 'Examen';
  static const String examLoadError = 'No se pudo cargar el examen';
  static const String examNoQuestions = 'No hay preguntas en este examen';
  static const String examPrevious = 'Anterior';
  static const String examNext = 'Siguiente';
  static const String examTimeExpired = 'El tiempo del examen ha finalizado';
  static const String examFinish = 'Finalizar examen';
  static const String examFinishTitle = '¿Finalizar simulacro?';
  static const String examFinishBody =
      'Una vez finalizado no podrás cambiar tus respuestas.';
  static const String examFinishConfirm = 'Finalizar y ver resultados';
  static const String examFinishCancel = 'Seguir examen';
  static const String examFinishing = 'Calificando tu simulacro…';
  static const String examFinishError = 'No se pudo finalizar el examen';
  static const String examAnswerCorrect = '¡Correcto! Buen trabajo.';
  static const String examAnswerWrong =
      'Incorrecto. Puedes pedir ayuda al tutor.';
  static const String examAnswerSaved = 'Respuesta registrada.';
  static const String examAskTutor = 'Pregúntale al tutor';

  static const String tutorTitle = 'Tutor IA';
  static const String tutorLoading = 'El tutor está analizando tu pregunta…';
  static const String tutorError = 'El tutor no está disponible. Intenta de nuevo.';
  static const String tutorClose = 'Cerrar';
  static const String tutorOptionalHint = '¿Qué parte no entiendes? (opcional)';

  static const String resultsTitle = 'Tus resultados';
  static const String resultsLoadError = 'No se pudieron cargar los resultados';
  static const String resultsScoreSection = 'Puntaje';
  static const String resultsCorrectLabel = 'Correctas';
  static const String resultsAreasSection = 'Desglose por área';
  static const String resultsDiagnosticSection = 'Diagnóstico académico';
  static const String resultsStrengths = 'Fortalezas';
  static const String resultsWeaknesses = 'Debilidades';
  static const String resultsStudyPlanSection = 'Plan de estudio';
  static const String resultsEstimatedDays = 'Días estimados';
  static const String resultsFocusSubtopics = 'Subtemas a reforzar';
  static const String resultsAiSection = 'Análisis con IA';
  static const String resultsAgentDiagnostic = 'Análisis diagnóstico';
  static const String resultsAgentMotivator = 'Mensaje motivador';
  static const String resultsAgentParents = 'Informe para padres';
  static const String resultsAgentGenerate = 'Generar';
  static const String resultsAgentLoading = 'Generando…';
  static const String resultsBackToSimulacro = 'Nuevo simulacro';
  static const String resultsNoData = 'Sin datos disponibles';

  static const String onboardingUniversityTitle =
      'Escoge la universidad o instituto para la que te prepararás.';

  static String onboardingAreaTitle(String universityName) =>
      '¿A qué área aplicarás en la $universityName?';

  static const String onboardingAreaSubtitle =
      'Personalizaremos tu experiencia y contenidos según tu objetivo.';

  static const String onboardingNotSureYet = 'No estoy seguro aún';

  static const String onboardingCareerTitle = 'Selecciona tu carrera';

  static const String onboardingCareerMascotDefault =
      'Perfecto. Ajustaré todo para tu perfil. ¡Vamos a ello!';

  static String onboardingCareerMascot(String careerName) =>
      'Perfecto. Ajustaré todo para el perfil de $careerName. ¡Vamos a ello!';

  static const String diagnosticTitle = 'Examen de Diagnóstico';
  static const String diagnosticDescription =
      'Este examen evaluará tus conocimientos en las áreas clave para tu carrera elegida.';
  static const String diagnosticQuestionsSubtitle =
      'Preguntas de opción múltiple';
  static const String diagnosticTimeSubtitle = 'Tiempo máximo';
  static const String diagnosticAreasSubtitle = 'Ver detalle de áreas';
  static const String diagnosticAreasLink = 'Ver detalle';
  static const String diagnosticStartButton = 'Comenzar examen';
  static const String diagnosticTimerNote =
      'El temporizador iniciará al comenzar';

  static String diagnosticQuestionProgress(int current) =>
      'Pregunta $current de 60';

  static const String diagnosticPrevious = 'Anterior';
  static const String diagnosticMark = 'Marcar';
  static const String diagnosticNext = 'Siguiente';

  static const String diagnosticProcessingTitle =
      'Analizando tus respuestas...';
  static const String diagnosticProcessingSubtitle =
      'Estamos evaluando tu desempeño en cada área.';
  static const String diagnosticProcessingNote =
      'Esto tomará solo unos segundos 🙂';

  static const String diagnosticResultTitle = 'Resultado del Diagnóstico';
  static const String diagnosticYourScore = 'Tu puntaje obtenido';
  static const String diagnosticInZone = 'En zona de ingreso';
  static const String diagnosticPerformanceByArea = 'Desempeño por áreas';
  static const String diagnosticViewRecommendations = 'Ver recomendaciones IA';

  static const String diagnosticAiHighlight =
      'Tu mayor oportunidad de mejora está en Ciencia y Tecnología. ';
  static const String diagnosticAiBody =
      'Recomendamos dedicarle 3 sesiones por semana.';
  static const String diagnosticStrengths = 'Fortalezas';
  static const String diagnosticWeaknesses = 'Debilidades';
  static const String diagnosticCreatePlan = 'Crear mi plan personalizado';
}
