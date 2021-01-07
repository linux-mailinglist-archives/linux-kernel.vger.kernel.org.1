Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8D2ECD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbhAGKIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:08:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30486 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbhAGKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:08:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-Vj4IkFWbMb6gbZ89vwsbFw-1; Thu, 07 Jan 2021 10:06:44 +0000
X-MC-Unique: Vj4IkFWbMb6gbZ89vwsbFw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 Jan 2021 10:06:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 Jan 2021 10:06:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: RE: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Thread-Topic: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Thread-Index: AQHW2PwqxtfWuUwKYEWRf8eoCF4YMqocBqaw
Date:   Thu, 7 Jan 2021 10:06:43 +0000
Message-ID: <c2f2f302c7e24ceb976f71232de6bdbc@AcuMS.aculab.com>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <6823854f-019f-f9db-7fd8-da8e7a0016d1@infradead.org>
In-Reply-To: <6823854f-019f-f9db-7fd8-da8e7a0016d1@infradead.org>
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

RnJvbTogUmFuZHkgRHVubGFwDQo+IFNlbnQ6IDIzIERlY2VtYmVyIDIwMjAgMDc6MTkNCj4gDQo+
IE9uIDEyLzIyLzIwIDk6MDQgUE0sIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiA+IEdDQyA3IGhh
cyBhIGtub3duIGJ1ZyB3aGVyZSBVQlNBTiBpZ25vcmVzICctZndyYXB2JyBhbmQgZ2VuZXJhdGVz
IGZhbHNlDQo+ID4gc2lnbmVkLW92ZXJmbG93LVVCIHdhcm5pbmdzLiAgVGhlIHR5cGUgbWlzbWF0
Y2ggYmV0d2VlbiAnaScgYW5kDQo+ID4gJ25yX3NlZ3MnIGluIGNvcHlfY29tcGF0X2lvdmVjX2Zy
b21fdXNlcigpIGlzIGNhdXNpbmcgc3VjaCBhIHdhcm5pbmcsDQo+ID4gd2hpY2ggYWxzbyBoYXBw
ZW5zIHRvIHZpb2xhdGUgdWFjY2VzcyBydWxlczoNCj4gPg0KPiA+ICAgbGliL2lvdl9pdGVyLm86
IHdhcm5pbmc6IG9ianRvb2w6IGlvdmVjX2Zyb21fdXNlcigpKzB4MjJkOiBjYWxsIHRvIF9fdWJz
YW5faGFuZGxlX2FkZF9vdmVyZmxvdygpDQo+IHdpdGggVUFDQ0VTUyBlbmFibGVkDQo+ID4NCj4g
PiBGaXggaXQgYnkgbWFraW5nIHRoZSB2YXJpYWJsZSB0eXBlcyBtYXRjaC4NCj4gPg0KPiA+IFRo
aXMgaXMgc2ltaWxhciB0byBhIHByZXZpb3VzIGNvbW1pdDoNCj4gPg0KPiA+ICAgMjlkYTkzZmVh
M2VhICgibW0vdWFjY2VzczogVXNlICd1bnNpZ25lZCBsb25nJyB0byBwbGFjYXRlIFVCU0FOIHdh
cm5pbmdzIG9uIG9sZGVyIEdDQyB2ZXJzaW9ucyIpDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogUmFu
ZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQo+IA0KPiBBbGwgZ29vZC4gVGhhbmtz
Lg0KPiANCj4gQWNrZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPiAj
IGJ1aWxkLXRlc3RlZA0KDQpGV0lXIEkndmUgdGVzdGVkIHRoZSBlcXVpdmFsZW50IGNoYW5nZSBs
b2NhbGx5Lg0KSXQgZ2VuZXJhdGVzIHJhdGhlciBiZXR0ZXIgY29kZSBvbiBhbWQ2NC4NCihZb3Ug
ZG9uJ3Qgd2FudCB0byBpbmRleCBhcnJheXMgd2l0aCAnaW50JyB1bmxlc3MgeW91IHJlYWxseSBo
YXZlIHRvLikNClNvIHByb2JhYmx5Og0KDQpBY2tlZC1ieTogRGF2aWQgTGFpZ2h0IDxkYXZpZC5s
YWlnaHRAYWN1bGFiLmNvbT4NCg0KCURhdmlkDQoNCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBsaWIv
aW92X2l0ZXIuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvaW92X2l0ZXIuYyBiL2xp
Yi9pb3ZfaXRlci5jDQo+ID4gaW5kZXggMTYzNTExMWM1YmQyLi4yZTZhNDJmNWQxZGYgMTAwNjQ0
DQo+ID4gLS0tIGEvbGliL2lvdl9pdGVyLmMNCj4gPiArKysgYi9saWIvaW92X2l0ZXIuYw0KPiA+
IEBAIC0xNjU2LDcgKzE2NTYsOCBAQCBzdGF0aWMgaW50IGNvcHlfY29tcGF0X2lvdmVjX2Zyb21f
dXNlcihzdHJ1Y3QgaW92ZWMgKmlvdiwNCj4gPiAgew0KPiA+ICAJY29uc3Qgc3RydWN0IGNvbXBh
dF9pb3ZlYyBfX3VzZXIgKnVpb3YgPQ0KPiA+ICAJCShjb25zdCBzdHJ1Y3QgY29tcGF0X2lvdmVj
IF9fdXNlciAqKXV2ZWM7DQo+ID4gLQlpbnQgcmV0ID0gLUVGQVVMVCwgaTsNCj4gPiArCWludCBy
ZXQgPSAtRUZBVUxUOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBpOw0KPiA+DQo+ID4gIAlpZiAoIXVz
ZXJfYWNjZXNzX2JlZ2luKHV2ZWMsIG5yX3NlZ3MgKiBzaXplb2YoKnV2ZWMpKSkNCj4gPiAgCQly
ZXR1cm4gLUVGQVVMVDsNCj4gPg0KPiANCj4gDQo+IC0tDQo+IH5SYW5keQ0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

