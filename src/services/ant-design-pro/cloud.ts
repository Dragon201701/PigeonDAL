// @ts-ignore
/* eslint-disable */

import { request } from 'umi';
import firebase from 'firebase';
import 'firebase/auth';
import 'firebase/firestore';

const firebaseConfig = {
  apiKey: 'AIzaSyD98mwcUT5W3oUO5fmtDFcoiGBhC_t0Xd8',
  authDomain: 'pigeondal.firebaseapp.com',
  projectId: 'pigeondal',
  storageBucket: 'pigeondal.appspot.com',
  messagingSenderId: '753821998474',
  appId: '1:753821998474:web:ae9758645224a122a5bc73',
  measurementId: 'G-LZR3N7CEG6',
};

console.log('Initializing firebase.');
firebase.initializeApp(firebaseConfig);
let firestore = firebase.firestore();
//const auth = getAuth(app);
// const firestore = getFirestore(app);

export async function firebase_login(body: API.LoginParams, options?: { [key: string]: any }) {
  console.log('Username: ', body.username, ' password: ', body.password);
  console.log('Options: ', options);
  let status = 'ok'; // or error
  let type = 'account'; // account for username+password, mobile for phone
  let currentAuthority = 'admin'; // or user, guest
  var loginstatus = false;
  let loginpromise = firebase
    .auth()
    .signInWithEmailAndPassword(body.username, body.password)
    .catch(function (error) {
      // Handle Errors here.
      var errorCode = error.code;
      var errorMessage = error.message;
      status = 'error';
      console.log('Firebase login failed. error code: ', error.code, ' message: ', error.message);
    });
  const ret = await loginpromise;
  /*return request<API.LoginResult>('/api/login/account', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    data: body,
    ...(options || {}),
  });*/
  return { status: status, type: type, currentAuthority: currentAuthority };
}

export async function firebase_currentUser(options?: { [key: string]: any }) {
  console.log('Firebase get current user.');
  var user = firebase.auth().currentUser;
  var name, email, photoUrl, uid, emailVerified, type, actcodes, mytrees;

  if (user != null) {
    name = user.displayName;
    email = user.email;
    photoUrl = user.photoURL;
    emailVerified = user.emailVerified;
    uid = user.uid;
  }
  /*return request<{
    data: API.CloudUser;
  }>('/api/currentUser', {
    method: 'GET',
    ...(options || {}),
  });*/
  return { data: { uid, email } };
}
