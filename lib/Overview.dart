class Overview {
  int questionnaireNumber;
  String name;
  String description;
  String umfang;

  Overview(
      {String questionnaireName,
      String questionnaireDescription,
      String questionnaireUmfang}) {
    name = questionnaireName;
    description = questionnaireDescription;
    umfang = questionnaireUmfang;
  }
}
