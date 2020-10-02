Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C92280E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJBHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:50:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53856 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgJBHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:50:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-196-pOL8PmeXMMqWU5oHvROPRw-1; Fri, 02 Oct 2020 08:50:39 +0100
X-MC-Unique: pOL8PmeXMMqWU5oHvROPRw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 2 Oct 2020 08:50:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 2 Oct 2020 08:50:39 +0100
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
Thread-Index: AQHWmEFme608aECbAkSNwPF3PIHq6KmD73Iw
Date:   Fri, 2 Oct 2020 07:50:38 +0000
Message-ID: <1c4ee46115854ce28b17935504f2fc78@AcuMS.aculab.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
In-Reply-To: <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
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

RnJvbTogQmVydCBWZXJtZXVsZW4NCj4gU2VudDogMDEgT2N0b2JlciAyMDIwIDIzOjIzDQo+IA0K
PiBPbiAxMC8xLzIwIDg6MzQgQU0sIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiA+IFNvIHVzaW5n
IGFuIGFkZHJlc3Mgd2lkdGggb2YgNCBoZXJlIGlzIG5vdCBuZWNlc3NhcmlseSB0aGUgcmlnaHQg
dGhpbmcNCj4gPiB0byBkby4gVGhpcyBjaGFuZ2Ugd291bGQgYnJlYWsgU01QVCBwYXJzaW5nIGZv
ciBhbGwgZmxhc2hlcyB0aGF0IHVzZQ0KPiA+IDMtYnl0ZSBhZGRyZXNzaW5nIGJ5IGRlZmF1bHQg
YmVjYXVzZSBTTVBUIHBhcnNpbmcgY2FuIGludm9sdmUgcmVnaXN0ZXINCj4gPiByZWFkcy93cml0
ZXMuIE9uZSBzdWNoIGRldmljZSBpcyB0aGUgQ3lwcmVzcyBTMjhIUyBmbGFzaC4gSW4gZmFjdCwg
dGhpcw0KPiA+IHdhcyB3aGF0IHByb21wdGVkIG1lIHRvIHdyaXRlIHRoZSBwYXRjaCBbMF0uDQo+
ID4NCj4gPiBCZWZvcmUgdGhhdCBwYXRjaCwgaG93IGRpZCBNWDI1TDI1NjM1RiBkZWNpZGUgdG8g
dXNlIDQtYnl0ZSBhZGRyZXNzaW5nPw0KPiANCj4gVGhlIFNvQ3MgSSdtIGRlYWxpbmcgd2l0aCBo
YXZlIGFuIFNQSV9BRERSX1NFTCBwaW4sIGluZGljYXRpbmcgd2hldGhlciBpdA0KPiBzaG91bGQg
YmUgaW4gMyBvciA0LWJ5dGUgbW9kZS4gVGhlIHZlbmRvcidzIGhhY2tlZC11cCBVLUJvb3Qgc2V0
cyB0aGUgbW9kZQ0KPiBhY2NvcmRpbmdseSwgYXMgZG9lcyB0aGVpciBCU1AuIEl0IHNlZW1zIHRv
IG1lIGxpa2UgYSBtaXNmZWF0dXJlLCBhbmQgSSB3YW50DQo+IHRvIGp1c3QgaWdub3JlIGl0IGFu
ZCBkbyByZWFzb25hYmxlIEpFREVDIHRoaW5ncywgYnV0IEkgaGF2ZSB0aGUgcHJvYmxlbQ0KPiB0
aGF0IHRoZSBmbGFzaCBjaGlwIGNhbiBiZSBpbiA0LWJ5dGUgbW9kZSBieSB0aGUgdGltZSBpdCBn
ZXRzIHRvIG15IHNwaS1ub3INCj4gZHJpdmVyLg0KDQpJZiB0aGVzZSBhcmUgdGhlIGRldmljZXMg
SSB0aGluayB0aGV5IGFyZSwgY2FuJ3QgeW91IHJlYWQgdGhlDQpub24tdm9sYXRpbGUgY29uZmln
IHdvcmQgKGJpdCAwKSB0byBmaW5kIG91dCB3aGV0aGVyIHRoZSBkZXZpY2UNCmV4cGVjdHMgYSAz
IG9yIDQgYnl0ZSBhZGRyZXNzIGFuZCBob3cgbWFueSAnaWRsZScgY2xvY2tzIHRoZXJlDQphcmUg
YmVmb3JlIHRoZSByZWFkIGRhdGE/DQoNCkEgZGV2aWNlIHRoYXQgcmVxdWlyZXMgMyBieXRlcyBv
ZiBhZGRyZXNzIGNhbiBiZSBzZXQgdG8gYSByZWFkDQpkZWxheSBvZiAxMiBjeWNsZXMgKHJhdGhl
ciB0aGFuIHRoZSB1c3VhbCAxMCkgc28gdGhhdCAnaGFyZHdhcmUnDQpyZWFkcyAodHlwaWNhbGx5
IGZyb20gYWRkcmVzcyAwKSBjYW4gdHJhbnNwYXJlbnRseSBzdXBwb3J0DQpkZXZpY2VzIHRoYXQg
cmVxdWlyZSAzIG9yIDQgYnl0ZXMgYWRkcmVzc2VzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

