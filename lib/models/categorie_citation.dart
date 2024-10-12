
class CategorieCitation {
  int id;
  String name;
  String? addDate;
  String? addedBy;
  String? editDate;
  String? editedBy;
  String? deleteDate;
  String? deletedBy;
  String isDeleted;

  CategorieCitation({
    required this.id,
    required this.name,
    this.addDate,
    this.addedBy,
    this.editDate,
    this.editedBy,
    this.deleteDate,
    this.deletedBy,
    required this.isDeleted,
  });

  factory CategorieCitation.fromJson(Map<String, dynamic> json) {
    return CategorieCitation(
      id: json['id'] as int,
      name: json['name'] as String,
      addDate: json['add_date'] as String,
      addedBy: json['added_by'] as String,
      editDate: json['edit_date'] as String?,
      editedBy: json['edited_by'] as String?,
      deleteDate: json['delete_date'] as String?,
      deletedBy: json['deleted_by'] as String?,
      isDeleted: json['is_deleted'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['add_date'] = addDate;
    data['added_by'] = addedBy;
    data['edit_date'] = editDate;
    data['edited_by'] = editedBy;
    data['delete_date'] = deleteDate;
    data['deleted_by'] = deletedBy;
    data['is_deleted'] = isDeleted;

    return data;
  }
}
