Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF03F2D273D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLHJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:14:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43686 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgLHJOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:14:46 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-cgochZeYPTqPLG2NldFvFA-1; Tue, 08 Dec 2020 09:12:37 +0000
X-MC-Unique: cgochZeYPTqPLG2NldFvFA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Dec 2020 09:12:36 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Dec 2020 09:12:36 +0000
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
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: RE: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Topic: [PATCH 2/3] rwsem: Implement down_read_interruptible
Thread-Index: AQHWzK7TgKb+NsLWq0OuVEyoMuW4SKnr2Z6AgAAkBICAAOuiYA==
Date:   Tue, 8 Dec 2020 09:12:36 +0000
Message-ID: <71db845efc7d44b5a7d23b0e55b3a496@AcuMS.aculab.com>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87k0tybqfy.fsf@x220.int.ebiederm.org>
 <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
 <20201207090243.GE3040@hirez.programming.kicks-ass.net>
 <7be81903-14e3-7485-83e7-02e65e80e8c3@redhat.com>
 <c781c59872e742c2b64f1aa70c30d7e2@AcuMS.aculab.com>
 <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
In-Reply-To: <aef54faf-cead-403c-6088-ff52ce1a5dde@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDcgRGVjZW1iZXIgMjAyMCAxOTowMg0KLi4uDQo+
ID4gSG93IG11Y2ggbW9yZSBkaWZmaWN1bHQgd291bGQgaXQgYmUgdG8gYWxzbyBhZGQgYSB0aW1l
b3V0IG9wdGlvbj8NCj4gPiBJIGxvb2tlZCBhdCBhZGRpbmcgb25lIHRvIHRoZSBtdXRleCBjb2Rl
IC0gYW5kIGZlbGwgaW50byBhIGJpZyBwaWxlDQo+ID4gb2YgcmVwbGljYXRlZCBjb2RlLg0KPiA+
DQo+ID4gSVNUTSB0aGF0IG9uZSB0aGUgaW5pdGlhbCBsb2NrZWQgZXhjaGFuZ2UgKGFuZCBzcGlu
KSBmYWlscyBhIGZldw0KPiA+IGV4dHJhIGluc3RydWN0aW9ucyB3aGVuIGhlYWRpbmcgZm9yIHRo
ZSBzbGVlcCBkb24ndCByZWFsbHkgbWF0dGVyDQo+ID4NCj4gQWN0dWFsbHksIEkgaGFkIHRyaWVk
IHRoYXQgYmVmb3JlLiBTZWUNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAx
OTA5MTExNTA1MzcuMTk1MjctMS1sb25nbWFuQHJlZGhhdC5jb20vDQo+IA0KPiBUaGF0IGlzIGZv
ciByd3NlbSwgYnV0IHRoZSBzYW1lIGNhbiBiZSBkb25lIGZvciBtdXRleC4gSG93ZXZlciwgUGV0
ZXINCj4gZGlkbid0IHNlZW0gdG8gbGlrZSB0aGUgaWRlYSBvZiBhIHRpbWVvdXQgcGFyYW1ldGVy
LiBBbnl3YXksIGl0IGlzDQo+IGNlcnRhaW5seSBkb2FibGUgaWYgdGhlcmUgaXMgYSBnb29kIHVz
ZSBjYXNlIGZvciBpdC4NCg0KJ1VuZm9ydHVuYXRlbHknIG15IHVzZS1jYXNlIGlmIGZvciBhbiBv
dXQtb2YtdHJlZSBkcml2ZXIuDQoNClRoZSBwcm9ibGVtIEkgd2FzIHNvbHZpbmcgaXMgYSBzdGF0
dXMgY2FsbCBibG9ja2luZyBiZWNhdXNlDQpzb21lIG90aGVyIGNvZGUgaXMgJ3N0dWNrJyAocHJv
YmFibHkgYW4gb29wcykgd2l0aCBhIG11dGV4IGhlbGQuDQoNClRoZSBjb2RlIHVzZWQgdG8gdXNl
IGRvd25fdGltZW91dCgpIChpdCB3YXMgd3JpdHRlbiBmb3IgMi40KS4NCldoZW4gSSBjaGFuZ2Vk
IHRvIG11dGV4Xyh0byBnZXQgb3B0aW1pc3RpYyBzcGlubmluZykgSSBsb3N0DQp0aGUgYWJpbGl0
eSB0byBkbyB0aGUgdGltZW91dHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

