Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56B2BAA97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKTMxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:53:22 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51302 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgKTMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:53:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-141-gW62sKHmNNyvbVQktKgy6Q-1; Fri, 20 Nov 2020 12:53:17 +0000
X-MC-Unique: gW62sKHmNNyvbVQktKgy6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 12:53:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 12:53:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Zimmermann' <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>, Dave Airlie <airlied@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: RE: Linux 5.10-rc4; graphics alignment
Thread-Topic: Linux 5.10-rc4; graphics alignment
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQABIUYAAAEibgAAAW3SAAAAkehgAAGiZoAAAIjkIA==
Date:   Fri, 20 Nov 2020 12:53:16 +0000
Message-ID: <ec3130c3d22a4d4dafe020d30fd224cd@AcuMS.aculab.com>
References: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
 <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
 <c01d2d95f1e64be984cff71e7bdf1c84@AcuMS.aculab.com>
 <c9bae016-413f-0db9-c9ee-d6f39d24a6ab@suse.de>
 <fa6346190d0b4936934d1f1359e5b71f@AcuMS.aculab.com>
 <fd66bfcc-072a-ddfb-0d12-af4a5207820d@suse.de>
In-Reply-To: <fd66bfcc-072a-ddfb-0d12-af4a5207820d@suse.de>
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

RnJvbTogVGhvbWFzIFppbW1lcm1hbm4NCj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMjozMA0K
PiANCj4gQW0gMjAuMTEuMjAgdW0gMTI6NDUgc2NocmllYiBEYXZpZCBMYWlnaHQ6DQo+ID4gRnJv
bTogVGhvbWFzIFppbW1lcm1hbm4NCj4gPj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMToyNw0K
PiA+IC4uLg0KPiA+Pj4+IFlvdSBjYW4gdXNlIGRybS10aXAgZm9yIHRlc3RpbmcsIHdoZXJlIG1h
bnkgb2YgdGhlIERSTSBwYXRjaGVzIGdvIHRocm91Z2guDQo+ID4+Pj4NCj4gPj4+PiAgICAgIGh0
dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybS10aXAvDQo+ID4+Pj4NCj4gPj4+PiBJ
dCdzIGZhaXJseSB1cC10by1kYXRlLg0KPiA+Pj4NCj4gPj4+IEFueSBpZGVhIG9mIHRhZ3MgZWl0
aGVyIHNpZGUgb2YgdGhlIDUuMTAgbWVyZ2U/DQo+ID4+DQo+ID4+IFRoZSBmaW5hbCBjb21taXQg
YmVmb3JlIHY1LjkgYXBwZWFycyB0byBiZQ0KPiA+Pg0KPiA+PiAgICAgRml4ZXM6IDMzYzgyNTZi
M2JjYyAoImRybS9hbWQvZGlzcGxheTogQ2hhbmdlIEFCTSBjb25maWcgaW5pdCBpbnRlcmZhY2Ui
KQ0KPiA+Pg0KPiA+PiBJJ2QgdHJ5IHRoaXMgYXMgYSBnb29kIGNvbW1pdC4gRm9yIHRoZSBiYWQg
Y29tbWl0LCBqdXN0IHRyeSBIRUFELg0KPiA+DQo+ID4gSEVBRCBvZmYgdGhhdCB0cmVlIHdvcmtz
Lg0KPiA+IENvbG91cnMgb2sgYW5kIG5vIHN0YWNrIGJhY2t0cmFjZS4NCj4gPg0KPiA+IElkZWFz
Pz8NCj4gDQo+IFRoZSBnb29kIG5ld3MgaXMgdGhhdCBpdCdzIGJlZW4gZml4ZWQuIEFsbCB5b3Ug
aGF2ZSB0byBkbyBpcyB3YWl0IGZvcg0KPiB0aGUgZml4IHRvIGhpdCB1cHN0cmVhbS4NCj4gDQo+
IERpZCB5b3UgdHJ5IHRoZSBwYXRjaCB0aGF0IERhdmUgbGlua2VkPyANCg0KVGhhdCBwYXRjaCBt
YWtlcyBubyBkaWZmZXJlbmNlIHRvIG15IHN5c3RlbS4NClRoZSBjb25kaXRpb24gaXMgZmFsc2Ug
c28gaXQgZG9lc24ndCBjb3JydXB0IHRoZSBmbGFncy4NCihJIHByaW50ZWQgdGhlIHZhbHVlcyB0
byBzZWUuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

