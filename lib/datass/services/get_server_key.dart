import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerToken() async {
    final scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "push-notifications-46d17",
        "private_key_id": "d202e8ecda516a8738f05fb4c6d8aebf29c4c1a1",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC3FDZty/Czo0Vq\nDmXSjQwZmq7tUooSZJ1PT91YASD3C8bhD5MxAIJdZM2uI6mUszfJsWhZEoffwWxZ\ndMY12kSSOh3CdTF+6TsVwSylpqZ5edbyLUxdFWDAdp2xQio4YBnxE6msrhJh3g+T\nGS+lLTFWLQlRZruo6I5wOO4Wv4EmSaxgoBAR8R9NEAQAPeZFScGcpqGnvmLZWGcy\nVk9PjDOZxcXAJDRr99NZUTTYvkokQiAumYPn6dZslKsVslHBdkzuSSDc7GWHb4G5\n408/UIGsWsHkkpHQoLcuQzbWbBt7F16Xe/SNeKxLVnMNnfN+T6gPxcBmJPRHlfsx\n6Myp5yezAgMBAAECggEAGRJkjc7DDObMJ8UG/rmgMZV0ZT3LeM9cl7L5PgcRi6OK\nPeITJz/Jmp6maDWsEJgmiLGJ98DI6MSlYO7UAiX9BAV/c9T2zUmFdOo6ggj7fWFJ\nJWs8rPazhEf6On80JvpKMzCdKO/BxrNRcLSfSMCSpBmQ0BwAkRYgA5BYUrcxKZvr\n890SFP+/ro0WCD2c42icjd1ttLUEiXlnRDBFKr+cI7Yf5mnzpJdN8aqYDx3PNUYe\nOe+gp+193gW0ugAt41MQ0ySjjTiDOEBT470EMH+/DMUXu80Gu0yrYAnwbmJra6LO\nNhECU4wMen9+moXo4kenqEE+yXE9L/zHmd//Olf5aQKBgQDfEop4o6AFm/z46mSf\n1EyseU2zsbvhbKcpRtmeEw3FEqJXz2vVMfhK9sK5QZycaRGfDn14PD5odxeOZsE0\n4y8J09DJWu/RNjgDIrIYXgtxrAijmcRUU+kqOd9PEKbCjw3SSLpcEsXSTR1Og27G\nw/SWteCpgOKO0vuUvwII5glT5QKBgQDSGmYWPsXMwTm0a8z6T6FSrbda6uS4SkQW\n01c7CJ2cf7b3Ccv3U+19k0nG7f1qcQTDabRuQtdGuWbJANYEuQ5pAWJxwOh1JcnC\niDhRntcH8V7MCHAYy+Mk4UyH88ipYr8TveDRXj/1Gn2upqLiN/y2l2ULoznvclJ5\np7XQrTaDtwKBgCA7z6KLEk59MdrOE+g8hy/M/3tdzWZPiwAd6sg6vJyjiq3hnRVb\neSNr8MtQPc8kJ5WyRFMhcWsq+k5rbrOzuFJVNzBBYbH7gbCCTPXUcRbl4wGw8Hu2\n/FRLtIb6Qv6OKVMfiz5OwCMZXYjA2TsDic5VTbdwlkxJFG10BFlA1Ew5AoGAdF0M\nl1ty36FQ3V0rLKM3vPvbZi5cOLlhFqc8U8TEzi1p3058ueGw0fDmVpfu16n6smPz\n+3Fnm5MJm1+sKPd5RKzwogHufRtNsEETuBjaDVsgXq55rzIU/pMNeOqLA01eeIec\nYTjrAUwHudgutE2/2DznSNfBOZ2+kgRRzV5xp+cCgYA/dujriY5UxEXcdeSPk1K+\ntEuypaMrUc0ckT0EHC+1tEHdwUzAgmVtPH9NEGfPPZBRxkfPnI2QfBv/evd71CH6\nQcDFWmezw/PNrGlgDOLyZaYV+ZtHa67uS88jpBSJXS6QlOkLgNab2iGV0KqbVUXt\nqKzxNzAAdzn1jOnuojNLqQ==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-fbsvc@push-notifications-46d17.iam.gserviceaccount.com",
        "client_id": "104227036826933350984",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40push-notifications-46d17.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      scopes,
    );
    final serverKey = client.credentials.accessToken.data;
    return serverKey;
  }
}
