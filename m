Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633FE2D1707
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgLGRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:00:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54034 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgLGRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:00:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-55-PBlTjpb8PJSb9wLrXKeb-g-1; Mon, 07 Dec 2020 16:58:35 +0000
X-MC-Unique: PBlTjpb8PJSb9wLrXKeb-g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Dec 2020 16:58:34 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Dec 2020 16:58:34 +0000
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
Thread-Index: AQHWzK7TgKb+NsLWq0OuVEyoMuW4SKnr2Z6A
Date:   Mon, 7 Dec 2020 16:58:34 +0000
Message-ID: <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
In-Reply-To: <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcgDQo+IFNlbnQ6IDA3IERlY2VtYmVyIDIwMjAgMTU6MzQNCj4gDQo+
IE9uIDEyLzcvMjAgNDowMiBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gT24gVGh1LCBE
ZWMgMDMsIDIwMjAgYXQgMDg6NTk6MTNQTSAtMDUwMCwgV2FpbWFuIExvbmcgd3JvdGU6DQo+ID4+
IE9uIDEyLzMvMjAgMzoxMSBQTSwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6DQo+ID4+PiArc3Rh
dGljIGlubGluZSBpbnQgX19kb3duX3JlYWRfaW50ZXJydXB0aWJsZShzdHJ1Y3Qgcndfc2VtYXBo
b3JlICpzZW0pDQo+ID4+PiArew0KPiA+Pj4gKwlpZiAoIXJ3c2VtX3JlYWRfdHJ5bG9jayhzZW0p
KSB7DQo+ID4+PiArCQlpZiAoSVNfRVJSKHJ3c2VtX2Rvd25fcmVhZF9zbG93cGF0aChzZW0sIFRB
U0tfSU5URVJSVVBUSUJMRSkpKQ0KPiA+Pj4gKwkJCXJldHVybiAtRUlOVFI7DQo+ID4+PiArCQlE
RUJVR19SV1NFTVNfV0FSTl9PTighaXNfcndzZW1fcmVhZGVyX293bmVkKHNlbSksIHNlbSk7DQo+
ID4+PiArCX0gZWxzZSB7DQo+ID4+PiArCQlyd3NlbV9zZXRfcmVhZGVyX293bmVkKHNlbSk7DQo+
ID4+PiArCX0NCj4gPj4+ICsJcmV0dXJuIDA7DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gICAg
c3RhdGljIGlubGluZSBpbnQgX19kb3duX3JlYWRfa2lsbGFibGUoc3RydWN0IHJ3X3NlbWFwaG9y
ZSAqc2VtKQ0KPiA+Pj4gICAgew0KPiA+Pj4gICAgCWlmICghcndzZW1fcmVhZF90cnlsb2NrKHNl
bSkpIHsNCj4gPj4+IEBAIC0xNDk1LDYgKzE1MDcsMjAgQEAgdm9pZCBfX3NjaGVkIGRvd25fcmVh
ZChzdHJ1Y3Qgcndfc2VtYXBob3JlICpzZW0pDQo+ID4+PiAgICB9DQo+ID4+PiAgICBFWFBPUlRf
U1lNQk9MKGRvd25fcmVhZCk7DQo+ID4+PiAraW50IF9fc2NoZWQgZG93bl9yZWFkX2ludGVycnVw
dGlibGUoc3RydWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQ0KPiA+Pj4gK3sNCj4gPj4+ICsJbWlnaHRf
c2xlZXAoKTsNCj4gPj4+ICsJcndzZW1fYWNxdWlyZV9yZWFkKCZzZW0tPmRlcF9tYXAsIDAsIDAs
IF9SRVRfSVBfKTsNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKExPQ0tfQ09OVEVOREVEX1JFVFVSTihz
ZW0sIF9fZG93bl9yZWFkX3RyeWxvY2ssIF9fZG93bl9yZWFkX2ludGVycnVwdGlibGUpKSB7DQo+
ID4+PiArCQlyd3NlbV9yZWxlYXNlKCZzZW0tPmRlcF9tYXAsIF9SRVRfSVBfKTsNCj4gPj4+ICsJ
CXJldHVybiAtRUlOVFI7DQo+ID4+PiArCX0NCj4gPj4+ICsNCj4gPj4+ICsJcmV0dXJuIDA7DQo+
ID4+PiArfQ0KPiA+Pj4gK0VYUE9SVF9TWU1CT0woZG93bl9yZWFkX2ludGVycnVwdGlibGUpOw0K
PiA+Pj4gKw0KPiA+Pj4gICAgaW50IF9fc2NoZWQgZG93bl9yZWFkX2tpbGxhYmxlKHN0cnVjdCBy
d19zZW1hcGhvcmUgKnNlbSkNCj4gPj4+ICAgIHsNCj4gPj4+ICAgIAltaWdodF9zbGVlcCgpOw0K
PiA+PiBBY2tlZC1ieTogV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4NCj4gPiBZZWFo
LCB0aGF0IHNlZW1zIGNvcnJlY3QuLiBUaGVyZSdzIGFuIHVuZm9ydHVuYXRlIGFtb3VudCBvZiBj
b3B5LXBhc3RlDQo+ID4gdGhlcmUgdGhvdWdoLg0KPiA+DQo+ID4gRG8gd2Ugd2FudCB0byBmb2xs
b3cgdGhhdCB1cCB3aXRoIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+IA0KPiBJIGFtIGFjdHVhbGx5
IHRoaW5raW5nIGFib3V0IHNpbWlsYXIgc3RyZWFtbGluaW5nIG9uY2UgdGhlIHBhdGNoIGxhbmRz
Lg0KPiANCj4gWW91ciBzdWdnZXN0ZWQgY2hhbmdlcyBsb29rIGZpbmUgdG8gbWUuDQoNCkhvdyBt
dWNoIG1vcmUgZGlmZmljdWx0IHdvdWxkIGl0IGJlIHRvIGFsc28gYWRkIGEgdGltZW91dCBvcHRp
b24/DQpJIGxvb2tlZCBhdCBhZGRpbmcgb25lIHRvIHRoZSBtdXRleCBjb2RlIC0gYW5kIGZlbGwg
aW50byBhIGJpZyBwaWxlDQpvZiByZXBsaWNhdGVkIGNvZGUuDQoNCklTVE0gdGhhdCBvbmUgdGhl
IGluaXRpYWwgbG9ja2VkIGV4Y2hhbmdlIChhbmQgc3BpbikgZmFpbHMgYSBmZXcNCmV4dHJhIGlu
c3RydWN0aW9ucyB3aGVuIGhlYWRpbmcgZm9yIHRoZSBzbGVlcCBkb24ndCByZWFsbHkgbWF0dGVy
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

