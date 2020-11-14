Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367A32B315C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 00:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKNXRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 18:17:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52540 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgKNXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 18:17:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-168-vn_8duDvOqGzuoybeICcjQ-1; Sat, 14 Nov 2020 23:17:17 +0000
X-MC-Unique: vn_8duDvOqGzuoybeICcjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 14 Nov 2020 23:17:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 14 Nov 2020 23:17:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: load_unaligned_zeropad() on x86-64
Thread-Topic: load_unaligned_zeropad() on x86-64
Thread-Index: Ada6nf2DRg6HGFCJQFesnPIHNvM81wAEkgoAAAryiGA=
Date:   Sat, 14 Nov 2020 23:17:16 +0000
Message-ID: <fd867440203949b1bd927bd51d2d9d49@AcuMS.aculab.com>
References: <46823b75d3c54a89a7192d8e1011e212@AcuMS.aculab.com>
 <CAHk-=wiZbMaEFFftonkjDGMtFDzOEzUyhbkSzE9Th21zNGaRtA@mail.gmail.com>
In-Reply-To: <CAHk-=wiZbMaEFFftonkjDGMtFDzOEzUyhbkSzE9Th21zNGaRtA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTQgTm92ZW1iZXIgMjAyMCAxODowMg0KPiAN
Cj4gT24gU2F0LCBOb3YgMTQsIDIwMjAgYXQgNzo1MyBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBjaGFuZ2UgZTQxOWI0Y2M1ODU2
ODA5NDBiYzQyZjhjYThhMDcxZDYwMjNmYjFiYiBhZGRlZA0KPiA+IGFzbSBjb2RlIGZvciBsb2Fk
X3VuYWxpZ25lZF96ZXJvcGFkKCkuDQo+ID4NCj4gPiBIb3dldmVyIGl0IGRvZXNuJ3QgbG9vayBy
aWdodCBmb3IgNjRiaXQuDQo+ID4gSXQgbWFza3MgdGhlIGFkZHJlc3Mgd2l0aCB+MyBub3Qgfjcg
c28gdGhlIHNlY29uZA0KPiA+IGFjY2VzcyBjb3VsZCBzdGlsbCBjcm9zcyBhIHBhZ2UgYm91bmRh
cnkgYW5kIGZhdWx0Lg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIG1vcmUgd2hhdCB5b3UgdGhpbmsg
aXMgd3Jvbmc/DQo+IA0KPiBJdCB1c2VzDQo+IA0KPiAgICAgICAgICAgICAgICAgImFuZCAlMywl
MVxuXHQiDQo+IA0KPiBmb3IgdGhlIG1hc2tpbmcsIGJ1dCBub3RlIGhvdyB0aGF0J3MgYSAiJTMi
LCBub3QgYSAiJDMiLg0KDQpNYXliZSBJIG5lZWQgdG8gZ2V0IGJldHRlciBnbGFzc2VzLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

