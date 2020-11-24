Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763892C2CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbgKXQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:27:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21304 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390003AbgKXQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:27:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-53-PHWAJYOoN_y3X4F8JOFFrg-1; Tue, 24 Nov 2020 16:27:20 +0000
X-MC-Unique: PHWAJYOoN_y3X4F8JOFFrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 16:27:19 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 16:27:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Thomas Zimmermann' <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>, Dave Airlie <airlied@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Subject: RE: Linux 5.10-rc4; graphics alignment
Thread-Topic: Linux 5.10-rc4; graphics alignment
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQABIUYAAAEibgAAAW3SAAAAkehgAAGiZoAAAIjkIAAB97YAAANWzKAAy4YMoA==
Date:   Tue, 24 Nov 2020 16:27:19 +0000
Message-ID: <eb79a45bfb7f4deb8d8d22350578a9dd@AcuMS.aculab.com>
References: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
 <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
 <c01d2d95f1e64be984cff71e7bdf1c84@AcuMS.aculab.com>
 <c9bae016-413f-0db9-c9ee-d6f39d24a6ab@suse.de>
 <fa6346190d0b4936934d1f1359e5b71f@AcuMS.aculab.com>
 <fd66bfcc-072a-ddfb-0d12-af4a5207820d@suse.de>
 <ec3130c3d22a4d4dafe020d30fd224cd@AcuMS.aculab.com>
 <7d42ee6b-d72b-9f4d-21fe-4f5981eb425e@suse.de>
 <fd7e7817781a43eb857fceb971502511@AcuMS.aculab.com>
In-Reply-To: <fd7e7817781a43eb857fceb971502511@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDIwIE5vdmVtYmVyIDIwMjAgMTU6MzkNCj4gDQo+
IEZyb206IFRob21hcyBaaW1tZXJtYW5uDQo+ID4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMzo0
Mg0KPiAuLi4NCj4gPiBJIGRpZCBhIGRpZmYgZnJvbSB2NS4xMC1yYzQgdG8gZHJtLXRpcCB0byBs
b29rIGZvciBzdXNwaWNpb3VzIGNoYW5nZXMuDQo+ID4gU29tZSBjYW5kaWRhdGVzIGFyZQ0KPiA+
DQo+ID4gICAgOGUzNzg0ZGZlZjhhICgiZHJtL2FzdDogUmVsb2FkIGdhbW1hIExVVCBhZnRlciBj
aGFuZ2luZyBwcmltYXJ5DQo+ID4gcGxhbmUncyBjb2xvciBmb3JtYXQiKQ0KPiANCj4gT2ssIHRo
YXQgb25lIGZpeGVzIHRoZSBzY3JlZW4gY29sb3VycyAoZXRjKS4NCj4gU28gOGUzNzg0ZGZlZjhh
IHdhcyBnb29kIGFuZCB0aGVuIEhFQUReIHdhcyBiYWQuDQo+IA0KPiBJIG1pZ2h0IHRyeSB0byBi
aXNlY3QgdGhlIGJyZWFrYWdlLg0KPiANCj4gVGhlIHN0YWNrIHNwbGF0IGlzIGVudGlyZWx5IGRp
ZmZlcmVudC4NCj4gSSdsbCB0cnkgdG8gYmlzZWN0IHRoYXQgb24gTGludXMncyB0cmVlLg0KDQpU
aGUgZ29vZCBuZXdzIGlzIEknbSBub3QgZ2V0dGluZyB0aGUgc3RhY2sgc3BsYXQgb24gcmM1Lg0K
SSdtIG5vdCBzdXJlIEkgY2FuIGJlIGJvdGhlcmVkIHRvIGZpbmQgb3V0IHdoZW4gOi0pDQoNCkFw
cGx5aW5nIDhlMzc4NGRmZWY4YSB0byByYzUgYnkgaGFuZCBhbHNvIGZpeGVzIHRoZSBkaXNwbGF5
IGNvbG91cnMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

