Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7452D7A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394523AbgLKQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:09:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20286 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728560AbgLKQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:09:20 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-etU-TdEENmeoZ7YiwHeG8Q-1; Fri, 11 Dec 2020 16:07:38 +0000
X-MC-Unique: etU-TdEENmeoZ7YiwHeG8Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 11 Dec 2020 16:07:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 11 Dec 2020 16:07:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Xu Wang <vulab@iscas.ac.cn>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: fs-enet: remove casting dma_alloc_coherent
Thread-Topic: [PATCH] net: ethernet: fs-enet: remove casting
 dma_alloc_coherent
Thread-Index: AQHWz9GpgD7sF0Ef20abEun/SaRAM6nyD2uw
Date:   Fri, 11 Dec 2020 16:07:37 +0000
Message-ID: <6fc4b62ee7754d78b8f7b9c2275bc47e@AcuMS.aculab.com>
References: <20201211085212.85457-1-vulab@iscas.ac.cn>
 <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
In-Reply-To: <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDIwIDE1OjIyDQo+
IA0KPiBMZSAxMS8xMi8yMDIwIMOgIDA5OjUyLCBYdSBXYW5nIGEgw6ljcml0wqA6DQo+ID4gUmVt
b3ZlIGNhc3RpbmcgdGhlIHZhbHVlcyByZXR1cm5lZCBieSBkbWFfYWxsb2NfY29oZXJlbnQuDQo+
IA0KPiBDYW4geW91IGV4cGxhaW4gbW9yZSBpbiB0aGUgY29tbWl0IGxvZyA/DQo+IA0KPiBBcyBm
YXIgYXMgSSBjYW4gc2VlLCBkbWFfYWxsb2NfY29oZXJlbnQoKSBkb2Vzbid0IHJldHVybiBfX2lv
bWVtLCBhbmQgcmluZ19iYXNlIG1lbWJlciBpcyBfX2lvbWVtDQoNCldoaWNoIGlzIHByb2JhYmx5
IHdyb25nIC0gdGhhdCBpcyB0aGUga2VybmVsIGFkZHJlc3Mgb2Yga2VybmVsIG1lbW9yeS4NClNv
IGl0IHNob3VsZG4ndCBoYXZlIHRoZSBfX2lvbWVtIG1hcmtlci4NCg0KSSB3b25kZXIgd2hhdCBl
bHNlIGlzIHdyb25nLi4uLg0KDQoJRGF2aWQNCg0KPiANCj4gQ2hyaXN0b3BoZQ0KPiANCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1IFdhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZzX2VuZXQvbWFjLWZlYy5jIHwg
MiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Zz
X2VuZXQvbWFjLWZlYy5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZzX2Vu
ZXQvbWFjLWZlYy5jDQo+ID4gaW5kZXggOTlmZTJjMjEwZDBmLi4zYWUzNDU2NzZlNTAgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZzX2VuZXQvbWFjLWZl
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZzX2VuZXQvbWFj
LWZlYy5jDQo+ID4gQEAgLTEzMSw3ICsxMzEsNyBAQCBzdGF0aWMgaW50IGFsbG9jYXRlX2JkKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ID4gICAJc3RydWN0IGZzX2VuZXRfcHJpdmF0ZSAqZmVw
ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gPiAgIAljb25zdCBzdHJ1Y3QgZnNfcGxhdGZvcm1faW5m
byAqZnBpID0gZmVwLT5mcGk7DQo+ID4NCj4gPiAtCWZlcC0+cmluZ19iYXNlID0gKHZvaWQgX19m
b3JjZSBfX2lvbWVtICopZG1hX2FsbG9jX2NvaGVyZW50KGZlcC0+ZGV2LA0KPiA+ICsJZmVwLT5y
aW5nX2Jhc2UgPSBkbWFfYWxsb2NfY29oZXJlbnQoZmVwLT5kZXYsDQo+ID4gICAJCQkJCSAgICAo
ZnBpLT50eF9yaW5nICsgZnBpLT5yeF9yaW5nKSAqDQo+ID4gICAJCQkJCSAgICBzaXplb2YoY2Jk
X3QpLCAmZmVwLT5yaW5nX21lbV9hZGRyLA0KPiA+ICAgCQkJCQkgICAgR0ZQX0tFUk5FTCk7DQo+
ID4NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

