Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78A42D2F77
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgLHQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:25:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57399 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729035AbgLHQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:25:30 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-155-cj57Z_jXNN6MUS3aCidSWg-1; Tue, 08 Dec 2020 16:23:51 +0000
X-MC-Unique: cj57Z_jXNN6MUS3aCidSWg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Dec 2020 16:23:50 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Dec 2020 16:23:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Waiman Long' <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Christopher Yeoh" <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Sargun Dhillon" <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: RE: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Topic: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Index: AQHWzK7TgKb+NsLWq0OuVEyoMuW4SKnr2Z6AgAAkBICAAOuiYIAAbJiAgAAJxfA=
Date:   Tue, 8 Dec 2020 16:23:50 +0000
Message-ID: <1be90b66dfe84a4c8a1e65bd40692c57@AcuMS.aculab.com>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
 <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
 <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
 <edfd0eb8-192e-60be-f0ca-2a72a26caa07@redhat.com>
In-Reply-To: <edfd0eb8-192e-60be-f0ca-2a72a26caa07@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDggRGVjZW1iZXIgMjAyMCAxNTozNA0KPiANCj4g
T24gMTIvOC8yMCA0OjEyIEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogV2FpbWFu
IExvbmcNCj4gPj4gU2VudDogMDcgRGVjZW1iZXIgMjAyMCAxOTowMg0KPiA+IC4uLg0KPiA+Pj4g
SG93IG11Y2ggbW9yZSBkaWZmaWN1bHQgd291bGQgaXQgYmUgdG8gYWxzbyBhZGQgYSB0aW1lb3V0
IG9wdGlvbj8NCj4gPj4+IEkgbG9va2VkIGF0IGFkZGluZyBvbmUgdG8gdGhlIG11dGV4IGNvZGUg
LSBhbmQgZmVsbCBpbnRvIGEgYmlnIHBpbGUNCj4gPj4+IG9mIHJlcGxpY2F0ZWQgY29kZS4NCj4g
Pj4+DQo+ID4+PiBJU1RNIHRoYXQgb25lIHRoZSBpbml0aWFsIGxvY2tlZCBleGNoYW5nZSAoYW5k
IHNwaW4pIGZhaWxzIGEgZmV3DQo+ID4+PiBleHRyYSBpbnN0cnVjdGlvbnMgd2hlbiBoZWFkaW5n
IGZvciB0aGUgc2xlZXAgZG9uJ3QgcmVhbGx5IG1hdHRlcg0KPiA+Pj4NCj4gPj4gQWN0dWFsbHks
IEkgaGFkIHRyaWVkIHRoYXQgYmVmb3JlLiBTZWUNCj4gPj4NCj4gPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDE5MDkxMTE1MDUzNy4xOTUyNy0xLWxvbmdtYW5AcmVkaGF0LmNvbS8N
Cj4gPj4NCj4gPj4gVGhhdCBpcyBmb3IgcndzZW0sIGJ1dCB0aGUgc2FtZSBjYW4gYmUgZG9uZSBm
b3IgbXV0ZXguIEhvd2V2ZXIsIFBldGVyDQo+ID4+IGRpZG4ndCBzZWVtIHRvIGxpa2UgdGhlIGlk
ZWEgb2YgYSB0aW1lb3V0IHBhcmFtZXRlci4gQW55d2F5LCBpdCBpcw0KPiA+PiBjZXJ0YWlubHkg
ZG9hYmxlIGlmIHRoZXJlIGlzIGEgZ29vZCB1c2UgY2FzZSBmb3IgaXQuDQo+ID4gJ1VuZm9ydHVu
YXRlbHknIG15IHVzZS1jYXNlIGlmIGZvciBhbiBvdXQtb2YtdHJlZSBkcml2ZXIuDQo+ID4NCj4g
PiBUaGUgcHJvYmxlbSBJIHdhcyBzb2x2aW5nIGlzIGEgc3RhdHVzIGNhbGwgYmxvY2tpbmcgYmVj
YXVzZQ0KPiA+IHNvbWUgb3RoZXIgY29kZSBpcyAnc3R1Y2snIChwcm9iYWJseSBhbiBvb3BzKSB3
aXRoIGEgbXV0ZXggaGVsZC4NCj4gPg0KPiA+IFRoZSBjb2RlIHVzZWQgdG8gdXNlIGRvd25fdGlt
ZW91dCgpIChpdCB3YXMgd3JpdHRlbiBmb3IgMi40KS4NCj4gPiBXaGVuIEkgY2hhbmdlZCB0byBt
dXRleF8odG8gZ2V0IG9wdGltaXN0aWMgc3Bpbm5pbmcpIEkgbG9zdA0KPiA+IHRoZSBhYmlsaXR5
IHRvIGRvIHRoZSB0aW1lb3V0cy4NCj4gDQo+IFRoZSBwcmltYXJ5IHJlYXNvbiBmb3Igc2VuZGlu
ZyBvdXQgdGhhdCBwYXRjaHNldCB3YXMgdG8gd29yayBhcm91bmQgc29tZQ0KPiBjaXJjdWxhciBs
b2NraW5nIHByb2JsZW0gaW4gZXhpc3RpbmcgY29kZSBldmVuIHRob3VnaCB0aGVzZSBjaXJjdWxh
cg0KPiBsb2NraW5nIHNjZW5hcmlvcyBhcmUgbm90IGxpa2VseSB0byBoYXBwZW4uIFlvdXIgY2Fz
ZSBpcyBjZXJ0YWlubHkNCj4gYW5vdGhlciBwb3RlbnRpYWwgY2lyY3VsYXIgbG9ja2luZyBwcm9i
bGVtIGFzIHdlbGwuDQoNCklmIHlvdSd2ZSBnb3QgbG9jay1vcmRlcmluZyBwcm9ibGVtcyB0aGV5
IG5lZWQgZml4aW5nLg0KTmVpdGhlciBzaWduYWxzIG5vciB0aW1lb3V0cyBhcmUgcmVhbCBzb2x1
dGlvbnMuDQpFaXRoZXIgbWF5IGhlbHAgZGlhZ25vc2UgdGhlIHByb2JsZW0sIGJ1dCB0aGV5IGFy
ZW4ndCBmaXhlcy4NCg0KT1RPSCBpZiBpdCByZWFzb25hYmxlIHRvIGhhdmUgYSByZXF1ZXN0IGlu
dGVycnVwdGVkIGJ5IGEgc2lnbmFsDQppdCBtdXN0IGFsc28gYmUgcmVhc29uYWJsZSB0byBpbXBs
ZW1lbnQgYSB0aW1lb3V0Lg0KT2YgY291cnNlLCBvbmUgbWlnaHQgd29uZGVyIHdoZXRoZXIgJ2Nv
cnJlY3QnIGNvZGUgc2hvdWxkIGV2ZXINCmJlIHdhaXRpbmcgb24gYSBtdXRleCBmb3IgYW55IGxl
bmd0aCBvZiB0aW1lLg0KU28gaXMgdGhlcmUgZXZlbiBhIGp1c3RpZmljYXRpb24gZm9yIGludGVy
cnVwdGlibGUgd2FpdHMgZm9yIG11dGV4Lg0KDQpGV0lXIEkgY291bGQgaW1wbGVtZW50IG15IHRp
bWVvdXRzIHVzaW5nIFNJR0FMQVJNIC0gYnV0IGl0IGlzIGEgbG90DQpvZiB3b3JrIDotKQ0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

