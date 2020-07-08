import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/presentation/landing.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  // Declaring Auth Variables
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthLink authLink;

  HttpLink httpLink;

  ValueNotifier<GraphQLClient> client;

  @override
  void initState() {
    super.initState();
    // Setting up network with GraphQL Server
    authLink = AuthLink(
        getToken: () async =>
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik0wTTNOVVV3UmpVNU0wSkZRalpDUkRsQ05URTNOVFk1T0RnME5EaEJNVGRDTUVORU1EQkNOZyJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6Imdvb2dsZS1vYXV0aDJ8MTA4NTUxMzA2MDg0MzUxMDIzNDAyIn0sImdpdmVuX25hbWUiOiJTcGFyc2giLCJmYW1pbHlfbmFtZSI6Ikd1cHRhIiwibmlja25hbWUiOiJndXB0YXNwYXJzaDAxOTgiLCJuYW1lIjoiU3BhcnNoIEd1cHRhIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdpTm54UTVuYU9hSlpRd3JYLXNfMUVyeHJUU0E0S200dTlnQmswd2Z3IiwibG9jYWxlIjoiZW4tR0IiLCJ1cGRhdGVkX2F0IjoiMjAyMC0wNy0wMVQwNjoxNzoyOS40MTNaIiwiaXNzIjoiaHR0cHM6Ly9nZW5lc2lzcG9ydGFsLmF1dGgwLmNvbS8iLCJzdWIiOiJnb29nbGUtb2F1dGgyfDEwODU1MTMwNjA4NDM1MTAyMzQwMiIsImF1ZCI6IkFLbDA2dzVESk95a2lnV2ZJVmdSS3RONDVnNzQyMzFDIiwiaWF0IjoxNTkzNTg0MjQ5LCJleHAiOjExMTkzNTg0MjQ3LCJhdF9oYXNoIjoiRzRwMDAtRDNLYzVJNFZ0SG9fN3BPZyIsIm5vbmNlIjoiMHROZEUzdlIuZlBQWU5xdTVnNjZUSFF6OVBZUWRha18ifQ.g7Wha2e_mIizvteO85UK96aOWstuQMuxmhqEXgLiDYf6Gy_SXZlGjMxog-uKZxKouY64OX8_mvk7-ZWOEeSP-mWTHov032D_J0SMdrBddL_8MX1AAdokVcW3cl9DTDTzVOlZS7Cd_em1GVE7gRpscBgsopDwe3srYSRheOagurIbxEICcD-i9OqbjvxMBB0MhyeM0xSZzmQY6el4vQ94rwdjeHyeBVdd9Bro65DOpbXUt-miKr95qLbCPrkcyWJLzQQsuNVB4wcM8-RY4eL5h4K6o92Fqoi3N3jb3qYAxjkcsvnN1zInNggSpXNiFohVG9tBN2tU_yZWAaClS8RRTA');
    httpLink =
        HttpLink(uri: 'https://definite-rabbit-51.hasura.app/v1/graphql');
    Link link = authLink.concat(httpLink);
    client = ValueNotifier(GraphQLClient(link: link, cache: InMemoryCache()));
  }

  @override
  Widget build(BuildContext context) {
    // GraphQLProvider provides access to client instance down the widget tree
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter & GraphQL Demo App',
          theme: ThemeData(
            fontFamily: "Montserrat",
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SafeArea(child: Landing()),
        ),
      ),
    );
  }
}
