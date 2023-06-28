// /**
//  * Import function triggers from their respective submodules:
//  *
//  * import {onCall} from "firebase-functions/v2/https";
//  * import {onDocumentWritten} from "firebase-functions/v2/firestore";
//  *
//  * See a full list of supported triggers at https://firebase.google.com/docs/functions
//  */

// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript

// // export const helloWorld = onRequest((request, response) => {
// //   logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.scheduleNotification = functions.https.onCall(async (data, context) => {
  const {token, notificationTitle, notificationBody, timestamp} = data;

  const utcTimestamp = new admin.firestore.Timestamp(
    Math.floor(timestamp / 1000),
    (timestamp % 1000) * 1000000
  );

  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: notificationTitle,
      body: notificationBody,
    },
    data: {
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
  };

  const options: admin.messaging.MessagingOptions = {
    sendTime: utcTimestamp.toDate().toISOString(),
  };

  return admin.messaging().sendToDevice(token, payload, options);
});


