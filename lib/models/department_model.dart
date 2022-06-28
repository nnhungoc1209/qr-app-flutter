class Department {
  int? departmentsId;
  String? tenphongban;

  Department({this.departmentsId, this.tenphongban});

  Department.fromJson(Map<String, dynamic> json) {
    departmentsId = json['departments_id'];
    tenphongban = json['tenphongban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departments_id'] = this.departmentsId;
    data['tenphongban'] = this.tenphongban;
    return data;
  }
}