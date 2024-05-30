import 'networking.dart';

class SongData{
  Future<dynamic> getData(String categoryId) async {
    var url =
        'http://soundscape.boostproductivity.online/api/meditate/v1/media/getSoundList?category_id=$categoryId'; 
    NetworkHelper networkHelper = NetworkHelper(url);
    var songsData = await networkHelper.getData();
    return songsData;
  }
}