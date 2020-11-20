Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5D2BA966
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKTLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 06:45:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27084 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgKTLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:45:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-TYIQpMyWPTaKnipbdKEtCQ-1; Fri, 20 Nov 2020 11:45:22 +0000
X-MC-Unique: TYIQpMyWPTaKnipbdKEtCQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 11:45:22 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 11:45:22 +0000
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
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQABIUYAAAEibgAAAW3SAAAAkehg
Date:   Fri, 20 Nov 2020 11:45:22 +0000
Message-ID: <fa6346190d0b4936934d1f1359e5b71f@AcuMS.aculab.com>
References: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
 <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
 <c01d2d95f1e64be984cff71e7bdf1c84@AcuMS.aculab.com>
 <c9bae016-413f-0db9-c9ee-d6f39d24a6ab@suse.de>
In-Reply-To: <c9bae016-413f-0db9-c9ee-d6f39d24a6ab@suse.de>
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

RnJvbTogVGhvbWFzIFppbW1lcm1hbm4NCj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMToyNw0K
Li4uDQo+ID4+IFlvdSBjYW4gdXNlIGRybS10aXAgZm9yIHRlc3RpbmcsIHdoZXJlIG1hbnkgb2Yg
dGhlIERSTSBwYXRjaGVzIGdvIHRocm91Z2guDQo+ID4+DQo+ID4+ICAgICBodHRwczovL2NnaXQu
ZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tdGlwLw0KPiA+Pg0KPiA+PiBJdCdzIGZhaXJseSB1cC10
by1kYXRlLg0KPiA+DQo+ID4gQW55IGlkZWEgb2YgdGFncyBlaXRoZXIgc2lkZSBvZiB0aGUgNS4x
MCBtZXJnZT8NCj4gDQo+IFRoZSBmaW5hbCBjb21taXQgYmVmb3JlIHY1LjkgYXBwZWFycyB0byBi
ZQ0KPiANCj4gICAgRml4ZXM6IDMzYzgyNTZiM2JjYyAoImRybS9hbWQvZGlzcGxheTogQ2hhbmdl
IEFCTSBjb25maWcgaW5pdCBpbnRlcmZhY2UiKQ0KPiANCj4gSSdkIHRyeSB0aGlzIGFzIGEgZ29v
ZCBjb21taXQuIEZvciB0aGUgYmFkIGNvbW1pdCwganVzdCB0cnkgSEVBRC4NCg0KSEVBRCBvZmYg
dGhhdCB0cmVlIHdvcmtzLg0KQ29sb3VycyBvayBhbmQgbm8gc3RhY2sgYmFja3RyYWNlLg0KDQpJ
ZGVhcz8/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

