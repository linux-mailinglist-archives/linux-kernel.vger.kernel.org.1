Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09803282DC8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgJDVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:36:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58944 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDVgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:36:24 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-22-miBv3_8TPze0sLNho43zTg-1; Sun, 04 Oct 2020 22:36:21 +0100
X-MC-Unique: miBv3_8TPze0sLNho43zTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 4 Oct 2020 22:36:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 4 Oct 2020 22:36:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bert Vermeulen' <bert@biot.com>, Pratyush Yadav <p.yadav@ti.com>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Topic: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Index: AQHWmEFme608aECbAkSNwPF3PIHq6KmD73IwgAP1ZgCAABS1AA==
Date:   Sun, 4 Oct 2020 21:36:20 +0000
Message-ID: <e41bb2d9ad144736b858b186acf2a47b@AcuMS.aculab.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
 <1c4ee46115854ce28b17935504f2fc78@AcuMS.aculab.com>
 <2c7b03eb-58fa-73af-93d7-669bad2e57ef@biot.com>
In-Reply-To: <2c7b03eb-58fa-73af-93d7-669bad2e57ef@biot.com>
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

RnJvbTogQmVydCBWZXJtZXVsZW4NCj4gU2VudDogMDQgT2N0b2JlciAyMDIwIDIyOjEyDQo+IA0K
PiBPbiAxMC8yLzIwIDk6NTAgQU0sIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBCZXJ0
IFZlcm1ldWxlbg0KPiA+PiBUaGUgU29DcyBJJ20gZGVhbGluZyB3aXRoIGhhdmUgYW4gU1BJX0FE
RFJfU0VMIHBpbiwgaW5kaWNhdGluZyB3aGV0aGVyIGl0DQo+ID4+IHNob3VsZCBiZSBpbiAzIG9y
IDQtYnl0ZSBtb2RlLiBUaGUgdmVuZG9yJ3MgaGFja2VkLXVwIFUtQm9vdCBzZXRzIHRoZSBtb2Rl
DQo+ID4+IGFjY29yZGluZ2x5LCBhcyBkb2VzIHRoZWlyIEJTUC4gSXQgc2VlbXMgdG8gbWUgbGlr
ZSBhIG1pc2ZlYXR1cmUsIGFuZCBJIHdhbnQNCj4gPj4gdG8ganVzdCBpZ25vcmUgaXQgYW5kIGRv
IHJlYXNvbmFibGUgSkVERUMgdGhpbmdzLCBidXQgSSBoYXZlIHRoZSBwcm9ibGVtDQo+ID4+IHRo
YXQgdGhlIGZsYXNoIGNoaXAgY2FuIGJlIGluIDQtYnl0ZSBtb2RlIGJ5IHRoZSB0aW1lIGl0IGdl
dHMgdG8gbXkgc3BpLW5vcg0KPiA+PiBkcml2ZXIuDQo+ID4NCj4gPiBJZiB0aGVzZSBhcmUgdGhl
IGRldmljZXMgSSB0aGluayB0aGV5IGFyZSwgY2FuJ3QgeW91IHJlYWQgdGhlDQo+ID4gbm9uLXZv
bGF0aWxlIGNvbmZpZyB3b3JkIChiaXQgMCkgdG8gZmluZCBvdXQgd2hldGhlciB0aGUgZGV2aWNl
DQo+ID4gZXhwZWN0cyBhIDMgb3IgNCBieXRlIGFkZHJlc3MgYW5kIGhvdyBtYW55ICdpZGxlJyBj
bG9ja3MgdGhlcmUNCj4gPiBhcmUgYmVmb3JlIHRoZSByZWFkIGRhdGE/DQo+IA0KPiBJJ20gd29y
a2luZyB3aXRoIFJlYWx0ZWsgUlRMODM4eC9SVEw4Mzl4IFNvQ3MuIFJlYWRpbmcgaXQgb3V0IGlz
IGENCj4gcHJldHR5IGNvbnZvbHV0ZWQgcHJvY2VkdXJlIGludm9sdmluZyBkaWZmZXJlbnQgSS9P
IHJlZ2lzdGVycyBkZXBlbmRpbmcNCj4gb24gdGhlIFNvQyBtb2RlbC4NCg0KSG93IGRvIHRoZXkg
bWFuYWdlIHRvIGxldCB5b3UgZG8gcmVhZC93cml0ZSB3aXRob3V0ICdyZWFkIGNvbnRyb2wnLg0K
QWN0dWFsbHkgSSBjYW4gaW1hZ2luZS4uLg0KDQpUaGUgcHJvYmxlbSB3ZSBoYWQgd2FzIGdldHRp
bmcgdGhlIElPIHBpbnMgdG8gbGluayB1cCB0byB1c2VyDQpsb2dpYyBvbiBhbiBBbHRlcmEgQ3lj
bG9uZS1WIGZwZ2EuDQpUaGVuIGl0IHdhcyBqdXN0IGEgJ1NNT1AnIHRvIGdldCByZWFkcyBhbmQg
d3JpdGUgY29udmVydGVkIHRvDQpuaWJibGUgJ2JpdC1iYW5nJyB3aXRoIHRoZSBjaGlwc2VsZWN0
IGFuZCBvdXRwdXQgZW5hYmxlIChJSVJDKQ0KY29udHJvbGxlZCBieSB0aGUgcmVnaXN0ZXIgYWRk
cmVzcy4NCkkgZG91YnQgYW55ICdzdGFuZGFyZCcgaW50ZXJmYWNlIGlzIGFzIGVmZmljaWVudC4N
Cg0KSSB0aGluayBJIGZvdW5kIGEgaGFyZHdhcmUgYnVnIGluIHRoZSBjaGlwcyB3ZSBhcmUgdXNp
bmcuDQpUaGVyZSBzZWVtZWQgdG8gYmUgYSB0aW1pbmcgd2luZG93IGluIHdoaWNoIHRoZSAncmVh
ZCBzdGF0dXMnDQpjb21tYW5kIChhZnRlciBhIHdyaXRlL2VyYXNlKSB3YXMgY29tcGxldGVseSBp
Z25vcmVkIGJ5DQp0aGUgZGV2aWNlLg0KRXZlcnl0aGluZyBsb29rZWQgd3JpdGUgb24gYSBzY29w
ZSAtIGJ1dCB0aGUgZGF0YSBsaW5lDQp3YXNuJ3QgZHJpdmVuLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

