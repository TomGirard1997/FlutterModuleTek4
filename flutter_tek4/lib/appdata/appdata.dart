import 'package:flutter_tek4/models/image_content.dart';
import 'package:flutter_tek4/models/profile.dart';

class AppData {
  static List<Profile> profiles = [
    Profile(
      imageUrl: 'images/tom.girard.jpg',
      title: 'Tom Girard',
      subtitle:
          "C'est le subtitle, y'a juste a mettre ce qu'on veut dedans en fait, genre banane",
      totalAlbums: '312',
      totalPictures: '12.4m',
      totalFestivals: '13.2m',
    ),
    Profile(
      imageUrl: 'images/enki.corbin.jpg',
      title: 'Enki Corbin',
      subtitle:
          'Senior UI/UX Designer at Guaranty Trust Bank Plc & Creative Director at PxDsgn Co. Creating simple  Let’s talk designs via\n email: sgnco@gmail.com',
      totalAlbums: '2',
      totalPictures: '15.4m',
      totalFestivals: '1.2m',
    ),
    Profile(
      imageUrl: 'images/gurvan.menguy.jpg',
      title: 'Gurvan Menguy',
      subtitle:
          'Senior UI/UX Designer at Guaranty Trust Bank Plc & Creative Director at PxDsgn Co. Creating simple  Let’s talk designs via\n email: sgnco@gmail.com',
      totalAlbums: '2',
      totalPictures: '15.4m',
      totalFestivals: '1.2m',
    ),
    Profile(
      imageUrl: 'images/charles.grandjean.jpg',
      title: 'Charles Grandjean',
      subtitle:
          'Senior UI/UX Designer at Guaranty Trust Bank Plc & Creative Director at PxDsgn Co. Creating simple  Let’s talk designs via\n email: sgnco@gmail.com',
      totalAlbums: '2',
      totalPictures: '15.4m',
      totalFestivals: '1.2m',
    ),
  ];
  static List<ImageContent> imageContents = [
    ImageContent(
        imageUrl: 'images/content/ben-ostrower-_N0MLYRVbfA-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/david-clode-CW44ZN1c3j4-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/devin-justesen-49YPssjmBMM-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/johan-mouchet-VyZTJ_FRqJc-unsplash (1).jpg'),
    ImageContent(
        imageUrl: 'images/content/matt-cramblett-NZHU5vfPo3M-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/pau-casals-9ZrZU-GrIiw-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/s-b-vonlanthen-D75_5tWZDQ4-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/tyler-delgado-8XHeZTnMIfc-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/wojtek-kwiatkowski-HVReRz9E0-I-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/jason-wolf-gLb1K2OXQ00-unsplash.jpg'),
    ImageContent(imageUrl: 'images/content/hu-chen-60XLoOgwkfA-unsplash.jpg'),
    ImageContent(
        imageUrl: 'images/content/timon-studler-4qmXhKJhSo4-unsplash.jpg'),
  ];
}
