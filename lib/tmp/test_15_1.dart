import 'dart:convert';
import 'package:collection/collection.dart';

class Book {
  String title;
  List<String> authors;
  String publisher;
  List<String> genres;
  List<Map<String, dynamic>> reviews;
  String isbn;
  double price;
  int pageCount;
  String publishDate;

  Book({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.genres,
    // 리뷰는 없을 수 있으므로 빈 리스트로 초기화
    this.reviews = const [],
    required this.isbn,
    required this.price,
    required this.pageCount,
    required this.publishDate,
  });

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        authors = List<String>.from(json['authors']),
        publisher = json['publisher'],
        genres = List<String>.from(json['genres']),
        reviews = List<Map<String, dynamic>>.from(json['reviews']),
        isbn = json['isbn'],
        price = json['price'].toDouble(),
        pageCount = json['pageCount'],
        publishDate = json['publishDate'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'authors': authors,
      'publisher': publisher,
      'genres': genres,
      'reviews': reviews,
      'isbn': isbn,
      'price': price,
      'pageCount': pageCount,
      'publishDate': publishDate,
    };
  }
}

void main() {
  String jsonString = '''
  {
    "books": [
      {
        "title": "To Kill a Mockingbird",
        "authors": ["Harper Lee"],
        "publisher": "J. B. Lippincott & Co.",
        "genres": ["Southern Gothic", "Bildungsroman"],
        "isbn": "9780446310789",
        "price": 12.99,
        "pageCount": 281,
        "publishDate": "1960-07-11T00:00:00Z",
        "reviews": [
          {
            "reviewerName": "Alice Johnson",
            "rating": 5,
            "comment": "A timeless classic that tackles important social issues."
          },
          {
            "reviewerName": "Bob Smith",
            "rating": 4,
            "comment": "Powerful narrative, though some parts feel slow-paced."
          }
        ]
      },
      {
        "title": "1984",
        "authors": ["George Orwell"],
        "publisher": "Secker & Warburg",
        "genres": ["Dystopian", "Political fiction", "Social science fiction"],
        "isbn": "9780451524935",
        "price": 8.99,
        "pageCount": 328,
        "publishDate": "1949-06-08T00:00:00Z",
        "reviews": [
          {
            "reviewerName": "Carol White",
            "rating": 5,
            "comment": "A chilling prophecy of a world gone wrong. More relevant than ever."
          },
          {
            "reviewerName": "David Brown",
            "rating": 5,
            "comment": "Orwell's masterpiece. A must-read for everyone."
          }
        ]
      }
    ]
  }
  ''';

  // JSON 문자열을 Dart 객체로 변환
  Map<String, dynamic> booksMap = jsonDecode(jsonString);
  print('booksMap: $booksMap');
  // booksMap: {books: [{title: To Kill a Mockingbird, authors: [Harper Lee], publisher: J. B. Lippincott & Co., genres: [Southern Gothic, Bildungsroman], isbn: 9780446310789, price: 12.99, pageCount: 281, publishDate: 1960-07-11T00:00:00Z, reviews: [{reviewerName: Alice Johnson, rating: 5, comment: A timeless classic that tackles important social issues.}, {reviewerName: Bob Smith, rating: 4, comment: Powerful narrative, though some parts feel slow-paced.}]}, {title: 1984, authors: [George Orwell], publisher: Secker & Warburg, genres: [Dystopian, Political fiction, Social science fiction], isbn: 9780451524935, price: 8.99, pageCount: 328, publishDate: 1949-06-08T00:00:00Z, reviews: [{reviewerName: Carol White, rating: 5, comment: A chilling prophecy of a world gone wrong. More relevant than ever.}, {reviewerName: David Brown, rating: 5, comment: Orwell's masterpiece. A must-read for everyone.}]}]}
  print('JsonEncoder.withIndent('
      ').convert(booksMap): ${JsonEncoder.withIndent('  ').convert(booksMap)}');
  /*
  JsonEncoder.withIndent().convert(booksMap): {
    "books": [
      {
        "title": "To Kill a Mockingbird",
        "authors": [
          "Harper Lee"
        ],
        "publisher": "J. B. Lippincott & Co.",
        "genres": [
          "Southern Gothic",
          "Bildungsroman"
        ],
        "isbn": "9780446310789",
        "price": 12.99,
        "pageCount": 281,
        "publishDate": "1960-07-11T00:00:00Z",
        "reviews": [
          {
            "reviewerName": "Alice Johnson",
            "rating": 5,
            "comment": "A timeless classic that tackles important social issues."
          },
          {
            "reviewerName": "Bob Smith",
            "rating": 4,
            "comment": "Powerful narrative, though some parts feel slow-paced."
          }
        ]
      },
      {
        "title": "1984",
        "authors": [
          "George Orwell"
        ],
        "publisher": "Secker & Warburg",
        "genres": [
          "Dystopian",
          "Political fiction",
          "Social science fiction"
        ],
        "isbn": "9780451524935",
        "price": 8.99,
        "pageCount": 328,
        "publishDate": "1949-06-08T00:00:00Z",
        "reviews": [
          {
            "reviewerName": "Carol White",
            "rating": 5,
            "comment": "A chilling prophecy of a world gone wrong. More relevant than ever."
          },
          {
            "reviewerName": "David Brown",
            "rating": 5,
            "comment": "Orwell's masterpiece. A must-read for everyone."
          }
        ]
      }
    ]
  }
  */
  List<Book> books =
      (booksMap['books'] as List).map((e) => Book.fromJson(e)).toList();
  // booksMap['books'] as List: JSON 객체에서 'books' 키에 해당하는 데이터를 리스트 형태로 가져옴.
  // .map((e) => Book.fromJson(e)): 리스트의 각 요소를 Book.fromJson(e)를 통해 Book 객체로 변환.
  // .toList(): Iterable을 List<Book>로 변환해서 최종적으로 List<Book>를 만들게 됨.

  // Dart 객체를 JSON 문자열로 변환
  String encodedJson =
      jsonEncode({'books': books.map((e) => e.toJson()).toList()});

  Map<String, dynamic> booksMap2 = jsonDecode(encodedJson);

  // booksMap과 booksMap2 비교하여 결과 출력
  //
  // DeepCollectionEquality를 사용하여 두 객체의 내부 내용을 모두 비교합니다.
  // 일반적으로 Map이나 List 같은 복잡한 데이터는 단순 ==로 비교하면 실패할 수 있어서,
  // DeepCollectionEquality로 모든 데이터가 같은지 자세히 확인이 필요하다고 함. (GPT)
  final deepEq = DeepCollectionEquality().equals;
  print('booksMap == booksMap2 : ${booksMap == booksMap2}');
  // booksMap == booksMap2 : false

  print('deepEq(booksMap, booksMap2) : ${deepEq(booksMap, booksMap2)}');
  // deepEq(booksMap, booksMap2) : true
}
