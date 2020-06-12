import 'package:chopper/chopper.dart';

part 'my_chopper_service.chopper.dart';

@ChopperApi(baseUrl: '/v3')
abstract class MyChopperService extends ChopperService {

  @Get(path: '/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34')
  Future<Response> getData();

  static MyChopperService create() {
    var client = ChopperClient(
      baseUrl: 'https://run.mocky.io',
      converter: JsonConverter(),
      services: [
        _$MyChopperService(),
      ]
    );
    return _$MyChopperService(client);
  }
}