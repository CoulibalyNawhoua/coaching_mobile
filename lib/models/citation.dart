class CitationModel {
  final String contenu;
  // String? urlMedias;
 

  CitationModel({
    required this.contenu,
    // required this.urlMedias,
    
  });

  factory CitationModel.fromJson(Map<String, dynamic> json) {
    return CitationModel(
      contenu: json['contenu'],
      // urlMedias: json["url_medias"],
     
    );
  }

    Map<String, dynamic> toJson() => {
        "contenu": contenu,
        // "url_medias": urlMedias,
    };
}
