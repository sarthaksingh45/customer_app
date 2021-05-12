class Customers {
  final int id;
  final String name;
  final int phoneNo;
  final String address;
  final List<String> serviceList;

  Customers({this.id, this.name, this.phoneNo, this.address, this.serviceList});
}

List<Customers> customersListReal = [
  Customers(
      id: 1,
      name: 'Kuch Bhi',
      phoneNo: 909090909,
      address: 'fashafalaklsjfajs,a flkjafkjas',
      serviceList: []),
];
