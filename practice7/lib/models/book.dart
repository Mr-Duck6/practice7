class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;
  bool isReserved;
  DateTime? returnDate;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    this.isReserved = false,
    this.returnDate,
  });
}

class LibraryData {
  static final List<Book> books = [
    Book(
      id: '1',
      title: 'Чистий код',
      author: 'Роберт Мартін',
      genre: 'Програмування',
      description: 'Основи написання якісного та читабельного коду.',
    ),
    Book(
      id: '2',
      title: 'Програміст-практик',
      author: 'Ендрю Гант',
      genre: 'Програмування',
      description: 'Шлях від підмайстра до майстра.',
    ),
    Book(
      id: '3',
      title: 'Алгоритми. Посібник',
      author: 'Томас Кормен',
      genre: 'Програмування',
      description: 'Класичний підручник з алгоритмів.',
    ),
    Book(
      id: '4',
      title: 'Гаррі Поттер і філософський камінь',
      author: 'Джоан Роулінг',
      genre: 'Фентезі',
      description: 'Початок магічної історії про хлопчика, який вижив.',
    ),
    Book(
      id: '5',
      title: 'Володар Перснів: Братство Персня',
      author: 'Джон Р. Р. Толкін',
      genre: 'Фентезі',
      description: 'Епічна сага про Середзем’я.',
    ),
    Book(
      id: '6',
      title: 'Дюна',
      author: 'Френк Герберт',
      genre: 'Фантастика',
      description:
          'Політичні та екологічні інтриги на пустельній планеті Аракіс.',
    ),
    Book(
      id: '7',
      title: 'Фундація',
      author: 'Айзек Азімов',
      genre: 'Фантастика',
      description: 'Падіння і відродження галактичної імперії.',
    ),
    Book(
      id: '8',
      title: '1984',
      author: 'Джордж Орвелл',
      genre: 'Антиутопія',
      description: 'Роман-попередження про тоталітарне суспільство.',
    ),
    Book(
      id: '9',
      title: 'Прекрасний новий світ',
      author: 'Олдос Гакслі',
      genre: 'Антиутопія',
      description: 'Суспільство споживання та генної інженерії.',
    ),
    Book(
      id: '10',
      title: 'Шерлок Холмс',
      author: 'Артур Конан Дойл',
      genre: 'Детектив',
      description: 'Збірка найкращих детективних розслідувань.',
    ),
    Book(
      id: '11',
      title: 'Вбивство у Східному експресі',
      author: 'Агата Крісті',
      genre: 'Детектив',
      description: 'Класичне розслідування Еркюля Пуаро.',
    ),
    Book(
      id: '12',
      title: 'Коротка історія часу',
      author: 'Стівен Гокінг',
      genre: 'Наука',
      description: 'Про чорні діри, час та всесвіт.',
    ),
    Book(
      id: '13',
      title: 'Мартін Іден',
      author: 'Джек Лондон',
      genre: 'Роман',
      description: 'Історія про силу волі, успіх та розчарування.',
    ),
    Book(
      id: '14',
      title: 'Кобзар',
      author: 'Тарас Шевченко',
      genre: 'Поезія',
      description: 'Класична українська поезія.',
    ),
    Book(
      id: '15',
      title: 'Тигролови',
      author: 'Іван Багряний',
      genre: 'Пригоди',
      description: 'Пригодницький роман про боротьбу та виживання в тайзі.',
    ),
  ];

  static List<String> get genres {
    return ['Всі', ...books.map((b) => b.genre).toSet().toList()];
  }

  static Book? findById(String id) {
    try {
      return books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
