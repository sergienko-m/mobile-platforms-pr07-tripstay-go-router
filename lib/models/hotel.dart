class Hotel {
  const Hotel({required this.id, required this.name, required this.city, required this.rating, required this.price, required this.description});
  final String id;
  final String name;
  final String city;
  final double rating;
  final int price;
  final String description;
}

const hotels = <Hotel>[
  Hotel(id: 'kyiv-center', name: 'Dnipro Riverside', city: 'Київ', rating: 4.8, price: 1850, description: 'Світлі номери біля набережної Дніпра, сніданок включено.'),
  Hotel(id: 'lviv-old-town', name: 'Old Town Residence', city: 'Львів', rating: 4.7, price: 2100, description: 'Затишний готель у центрі Львова поруч із площею Ринок.'),
  Hotel(id: 'odesa-sea', name: 'Black Sea Resort', city: 'Одеса', rating: 4.6, price: 2400, description: 'Апартаменти з видом на море та швидким доступом до пляжу.'),
  Hotel(id: 'bukovel-pines', name: 'Pine Valley Lodge', city: 'Буковель', rating: 4.9, price: 3200, description: 'Гірський будиночок для відпочинку всією сім’єю.'),
  Hotel(id: 'kharkiv-smart', name: 'Smart Stay Kharkiv', city: 'Харків', rating: 4.4, price: 1250, description: 'Сучасні номери для коротких ділових поїздок.'),
];
