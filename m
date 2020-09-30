Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8527E92D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgI3NGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:06:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21551 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728043AbgI3NGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:06:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-66-qt8wVWg8P6SZfHGEXLLF8w-1; Wed, 30 Sep 2020 14:06:28 +0100
X-MC-Unique: qt8wVWg8P6SZfHGEXLLF8w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 30 Sep 2020 14:06:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 30 Sep 2020 14:06:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vasily Gorbik' <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Miroslav Benes" <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v2 2/2] objtool: fix x86 orc generation on big endian
 cross compiles
Thread-Topic: [RFC PATCH v2 2/2] objtool: fix x86 orc generation on big endian
 cross compiles
Thread-Index: AQHWlyS3U2hAeeyEgk6cZ7ZhqaNR+KmBJeHg
Date:   Wed, 30 Sep 2020 13:06:27 +0000
Message-ID: <e7316f1752a846d98735610d7b795223@AcuMS.aculab.com>
References: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
 <cover.thread-ca645c.your-ad-here.call-01601468251-ext-3723@work.hours>
 <patch-2.thread-ca645c.git-ca645c336a18.your-ad-here.call-01601468251-ext-3723@work.hours>
In-Reply-To: <patch-2.thread-ca645c.git-ca645c336a18.your-ad-here.call-01601468251-ext-3723@work.hours>
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

RnJvbTogVmFzaWx5IEdvcmJpaw0KPiBTZW50OiAzMCBTZXB0ZW1iZXIgMjAyMCAxMzoyNA0KPiAN
Cj4gQ29ycmVjdCBvYmp0b29sIG9yYyBnZW5lcmF0aW9uIGVuZGlhbm5lc3MgcHJvYmxlbXMgdG8g
ZW5hYmxlIGZ1bGx5DQo+IGZ1bmN0aW9uYWwgeDg2IGNyb3NzIGNvbXBpbGVzIG9uIGJpZyBlbmRp
YW4gaGFyZHdhcmUuDQo+IA0KLi4uDQo+ICsNCj4gKyNpZiBkZWZpbmVkKF9fQllURV9PUkRFUikg
PyBfX0JZVEVfT1JERVIgPT0gX19MSVRUTEVfRU5ESUFOIDogZGVmaW5lZChfX0xJVFRMRV9FTkRJ
QU4pDQo+ICsNCj4gIHN0cnVjdCBvcmNfZW50cnkgew0KPiAgCXMxNgkJc3Bfb2Zmc2V0Ow0KPiAg
CXMxNgkJYnBfb2Zmc2V0Ow0KPiBAQCAtNTcsNiArNjcsMjAgQEAgc3RydWN0IG9yY19lbnRyeSB7
DQo+ICAJdW5zaWduZWQJZW5kOjE7DQo+ICB9IF9fcGFja2VkOw0KPiANCj4gKyNlbHNlDQo+ICsN
Cj4gK3N0cnVjdCBvcmNfZW50cnkgew0KPiArCXMxNgkJc3Bfb2Zmc2V0Ow0KPiArCXMxNgkJYnBf
b2Zmc2V0Ow0KPiArCXVuc2lnbmVkCWJwX3JlZzo0Ow0KPiArCXVuc2lnbmVkCXNwX3JlZzo0Ow0K
PiArCXVuc2lnbmVkCXVudXNlZDo1Ow0KPiArCXVuc2lnbmVkCWVuZDoxOw0KPiArCXVuc2lnbmVk
CXR5cGU6MjsNCj4gK30gX19wYWNrZWQ7DQo+ICsNCj4gKyNlbmRpZg0KDQpTaG91bGRuJ3QgdGhh
dCBiZSBjaGVja2luZyBCSVRGSUVMRF9FTkRJQU4uDQoNCkkgYWxzbyB0aGluayB0aGF0IChpbiB0
aGUgb3RoZXIgcGF0Y2gpIHlvdSBjYW4gYXNzdW1lDQp0aGF0IHlvdSBkb24ndCBuZWVkIHRvIGJ5
dGVzd2FwIGlmIF9fS0VSTkVMX18gaXMgZGVmaW5lZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

