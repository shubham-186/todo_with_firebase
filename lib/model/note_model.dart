class NoteModel{
  String? id;
  String title;
  String desc;
  String createdAt;
  NoteModel({
    this.id,
    required this.title,
    required this.desc,
    required this.createdAt
  });

  factory NoteModel.fromNote(Map<String,dynamic>map){
    return NoteModel(
         id: map['id'],
        title: map['title'],
        desc: map['desc'],
        createdAt:map['createdAt'],
    );
  }
  Map<String,dynamic>toNotes(){
    return {
      "title":"$title",
      "desc":"$desc",
      "createdAt":"$createdAt",
    };
  }
}