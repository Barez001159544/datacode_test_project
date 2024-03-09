
class CurrencyModel{
  late List a;
  late List l;
  late List h;

  CurrencyModel(
      this.a,
      this.l,
      this.h,
      );

  CurrencyModel.fromJson(Map<String, dynamic> json){
    a= json['a'];
    l= json['l'];
    h= json['h'];
  }
}