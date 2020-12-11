Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A82D7487
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgLKLQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:16:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33877 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390718AbgLKLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:16:22 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-LoSaEKzrOx2bK29PQ33dAQ-1; Fri, 11 Dec 2020 11:14:43 +0000
X-MC-Unique: LoSaEKzrOx2bK29PQ33dAQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 11:14:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 11:14:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lee Jones' <lee.jones@linaro.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Thread-Topic: bikeshed: [PATCH -next] mfd: rave-sp: convert comma to semicolon
Thread-Index: AdbPrprvUTsF4VOLTpOnxS9AV5J8lA==
Date:   Fri, 11 Dec 2020 11:14:43 +0000
Message-ID: <7416de308a9b41d3ac881210ab114159@AcuMS.aculab.com>
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

RnJvbTogTGVlIEpvbmVzDQo+IFNlbnQ6IDExIERlY2VtYmVyIDIwMjAgMTA6MDYNCj4gDQo+IE9u
IEZyaSwgMTEgRGVjIDIwMjAsIFpoZW5nIFlvbmdqdW4gd3JvdGU6DQo+IA0KPiA+IFJlcGxhY2Ug
YSBjb21tYSBiZXR3ZWVuIGV4cHJlc3Npb24gc3RhdGVtZW50cyBieSBhIHNlbWljb2xvbi4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoZW5nIFlvbmdqdW4gPHpoZW5neW9uZ2p1bjNAaHVhd2Vp
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZmQvcmF2ZS1zcC5jIHwgMiArLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21mZC9yYXZlLXNwLmMgYi9kcml2ZXJzL21mZC9yYXZlLXNwLmMN
Cj4gPiBpbmRleCA1NDUxOTZjODViNWMuLmFiYjljYmRhYmFhOSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL21mZC9yYXZlLXNwLmMNCj4gPiArKysgYi9kcml2ZXJzL21mZC9yYXZlLXNwLmMNCj4g
PiBAQCAtMzU4LDcgKzM1OCw3IEBAIGludCByYXZlX3NwX2V4ZWMoc3RydWN0IHJhdmVfc3AgKnNw
LA0KPiA+DQo+ID4gIAlhY2tpZCAgICAgICA9IGF0b21pY19pbmNfcmV0dXJuKCZzcC0+YWNraWQp
Ow0KPiA+ICAJcmVwbHkuYWNraWQgPSBhY2tpZDsNCj4gPiAtCXJlcGx5LmNvZGUgID0gcmF2ZV9z
cF9yZXBseV9jb2RlKCh1OCljb21tYW5kKSwNCj4gPiArCXJlcGx5LmNvZGUgID0gcmF2ZV9zcF9y
ZXBseV9jb2RlKCh1OCljb21tYW5kKTsNCj4gDQo+IEhvdyBkaWQgdGhlIG9yaWdpbmFsIGNvZGUg
bm90IGNyZWF0ZSBhIGJ1aWxkIGVycm9yPw0KDQpOb3d0IHdyb25nIHdpdGggY29tbWFzLg0KDQpX
aHkgbm90IGdvIHRoZSBvdGhlciB3YXkuDQpDb252ZXJ0IGFsbW9zdCBhbGwgdGhlIDsgdG8gLCBh
bmQgZGVsZXRlIG1vc3Qgb2YgdGhlIHsgfSBpbg0KaWYgYW5kIGZvciBzdGF0ZW1lbnRzIChldGMp
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

