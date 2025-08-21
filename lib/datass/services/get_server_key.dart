import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    // Load credentials from environment variables
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": dotenv.env['FIREBASE_PROJECT_ID'],
      "private_key_id": dotenv.env['FIREBASE_PRIVATE_KEY_ID'],
      "private_key": dotenv.env['FIREBASE_PRIVATE_KEY']?.replaceAll(
        '\\n',
        '\n',
      ),
      "client_email": dotenv.env['FIREBASE_CLIENT_EMAIL'],
      "client_id": dotenv.env['FIREBASE_CLIENT_ID'],
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40push-notifications-46d17.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({serviceAccountJson}),
      scopes,
    );
    final serverKey = client.credentials.accessToken.data;
    return serverKey;
  }
}
