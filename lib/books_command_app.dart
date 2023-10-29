import 'dart:io';
import 'package:books_command_app/book.dart';

int calculate() {
  return 6 * 7;
}

List<Book> database = [];

void run() {
  Book book1 = Book("Tom Sawyer", "Mark Twain", "Kinderbuch", 1876);
  Book book2 = Book("Faust", "Johann Wolfgang von Goethe", "Moral", 1806);

  database.add(book1);
  database.add(book2);

  while (true) {
    print("Medien-Verwaltung");
    print("1. Buch hinzufügen");
    print("2. Liste aller Bücher anzeigen");
    print("3. Nach Büchern suchen");
    print("4. Buch löschen");
    print("5. Beenden");

    stdout.write("Wähle eine Option: ");
    String choice = stdin.readLineSync()!;

    switch (choice) {
      case "1":
        addBook();
        break;
      case "2":
        listBooks();
        break;
      case "3":
        searchBooks();
        break;
      case "4":
        deleteBook();
        break;
      case "5":
        exit(0);
      default:
        print("Ungültige Option. Bitte wähle erneut.");
    }
  }
}

void addBook() {
  stdout.write("Titel: ");
  String title = stdin.readLineSync()!;
  stdout.write("Autor: ");
  String author = stdin.readLineSync()!;
  stdout.write("Genre: ");
  String genre = stdin.readLineSync()!;
  stdout.write("Veröffentlichungsjahr: ");
  int releaseYear = int.parse(stdin.readLineSync()!);

  Book book = Book(title, author, genre, releaseYear);
  database.add(book);
  print("Buch wurde hinzugefügt.");
}

void listBooks() {
  if (database.isEmpty) {
    print("Die Datenbank ist leer.");
  } else {
    for (var book in database) {
      print(
          "Titel: ${book.title}, Autor: ${book.author}, Genre: ${book.genre}, Veröffentlichungsjahr: ${book.releaseYear}");
    }
  }
}

void searchBooks() {
  print("Suche nach Büchern:");
  print("1. Nach Autor");
  print("2. Nach Genre");
  print("3. Nach Veröffentlichungsjahr");
  print("4. Zurück zum Hauptmenü");

  stdout.write("Wähle eine Suchkategorie: ");
  String searchCategory = stdin.readLineSync()!;

  switch (searchCategory) {
    case "1":
      stdout.write("Gib den Autor ein: ");
      String author = stdin.readLineSync()!;
      final matchingBooks =
          database.where((book) => book.author == author).toList();
      if (matchingBooks.isEmpty) {
        print("Keine Bücher von $author gefunden.");
      } else {
        print("Bücher von $author:");
        for (var book in matchingBooks) {
          print(
              "Titel: ${book.title}, Genre: ${book.genre}, Veröffentlichungsjahr: ${book.releaseYear}");
        }
      }
      break;
    case "2":
      stdout.write("Gib das Genre ein: ");
      String genre = stdin.readLineSync()!;
      final matchingBooks =
          database.where((book) => book.genre == genre).toList();
      if (matchingBooks.isEmpty) {
        print("Keine Bücher im Genre $genre gefunden.");
      } else {
        print("Bücher im Genre $genre:");
        for (var book in matchingBooks) {
          print(
              "Titel: ${book.title}, Autor: ${book.author}, Veröffentlichungsjahr: ${book.releaseYear}");
        }
      }
      break;
    case "3":
      stdout.write("Gib das Veröffentlichungsjahr ein: ");
      int releaseYear = int.parse(stdin.readLineSync()!);
      final matchingBooks =
          database.where((book) => book.releaseYear == releaseYear).toList();
      if (matchingBooks.isEmpty) {
        print("Keine Bücher aus dem Jahr $releaseYear gefunden.");
      } else {
        print("Bücher aus dem Jahr $releaseYear:");
        for (var book in matchingBooks) {
          print(
              "Titel: ${book.title}, Autor: ${book.author}, Genre: ${book.genre}");
        }
      }
      break;
    case "4":
      // Zurück zum Hauptmenü
      break;
    default:
      print("Ungültige Option. Bitte wähle erneut.");
  }
}

void deleteBook() {
  stdout.write("Gib den Titel des zu löschenden Buchs ein: ");
  String titleToDelete = stdin.readLineSync()!;

  bool removed = false;
  database.removeWhere((book) {
    if (book.title == titleToDelete) {
      removed = true;
      return true;
    }
    return false;
  });

  if (removed) {
    print("$titleToDelete wurde aus der Datenbank gelöscht.");
  } else {
    print("Buch mit dem Titel $titleToDelete nicht gefunden.");
  }
}
