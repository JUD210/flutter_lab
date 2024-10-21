import 'package:flutter/material.dart';

class Recipe with ChangeNotifier {
  final String foodName;
  final String description;
  final List<String> cookGuide;
  double? rating; // 별점은 private으로 선언

  Recipe({
    required this.foodName,
    required this.description,
    required this.cookGuide,
    this.rating,
  });
}

final List<Recipe> recipeSamples = [
  Recipe(
    foodName: '파스타',
    description: '맛있는 토마토 소스 파스타',
    cookGuide: ['파스타를 삶습니다.', '소스를 추가합니다.', '잘 섞어줍니다.'],
    rating: 4.5,
  ),
  Recipe(
    foodName: '피자',
    description: '다양한 토핑이 올라간 치즈 피자',
    cookGuide: ['도우를 준비합니다.', '토핑을 올립니다.', '구워줍니다.'],
  ),
  Recipe(
    foodName: '버거',
    description: '양상추와 토마토가 들어간 육즙 가득 버거',
    cookGuide: ['패티를 굽습니다.', '빵, 양상추, 토마토와 함께 조립합니다.'],
  ),
  Recipe(
    foodName: '샐러드',
    description: '신선한 비네그레트 드레싱 샐러드',
    cookGuide: ['야채를 섞습니다.', '비네그레트 드레싱을 추가합니다.'],
  ),
  Recipe(
    foodName: '수프',
    description: '채소와 고기가 들어간 따뜻한 수프',
    cookGuide: ['채소와 고기를 육수에 넣고 끓입니다.'],
  ),
];
