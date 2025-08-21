/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/password_generator.dart' as _i2;
import 'package:password_manager_server/src/generated/char_set.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'passwordGenerator': _i2.PasswordGeneratorEndpoint()
        ..initialize(
          server,
          'passwordGenerator',
          null,
        )
    };
    connectors['passwordGenerator'] = _i1.EndpointConnector(
      name: 'passwordGenerator',
      endpoint: endpoints['passwordGenerator']!,
      methodConnectors: {
        'generatePassword': _i1.MethodConnector(
          name: 'generatePassword',
          params: {
            'length': _i1.ParameterDescription(
              name: 'length',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'charSets': _i1.ParameterDescription(
              name: 'charSets',
              type: _i1.getType<Set<_i3.CharSet>>(),
              nullable: false,
            ),
            'excludeAmbiguous': _i1.ParameterDescription(
              name: 'excludeAmbiguous',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['passwordGenerator'] as _i2.PasswordGeneratorEndpoint)
                  .generatePassword(
            session,
            length: params['length'],
            charSets: params['charSets'],
            excludeAmbiguous: params['excludeAmbiguous'],
          ),
        )
      },
    );
  }
}
