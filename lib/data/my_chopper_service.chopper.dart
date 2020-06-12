// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_chopper_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MyChopperService extends MyChopperService {
  _$MyChopperService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MyChopperService;

  @override
  Future<Response<dynamic>> getData() {
    final $url = '/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
