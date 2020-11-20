Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F02BA7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKTKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:51:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54653 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgKTKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:51:27 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-k48j_AcUP4appSBg89PJ6g-1; Fri, 20 Nov 2020 10:51:24 +0000
X-MC-Unique: k48j_AcUP4appSBg89PJ6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Nov 2020 10:51:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Nov 2020 10:51:23 +0000
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
Thread-Index: Ada/IUdqcU2WLz13TDyBa91ssXd9zQABIUYAAAEibgA=
Date:   Fri, 20 Nov 2020 10:51:23 +0000
Message-ID: <c01d2d95f1e64be984cff71e7bdf1c84@AcuMS.aculab.com>
References: <2c474745ae884de3b4ecb8abe2152bfd@AcuMS.aculab.com>
 <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
In-Reply-To: <fa5c887e-82d8-5347-ff18-85e3628dadbe@suse.de>
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

RnJvbTogVGhvbWFzIFppbW1lcm1hbm4NCj4gU2VudDogMjAgTm92ZW1iZXIgMjAyMCAxMDoxNA0K
Li4uDQo+ID4gSXMgdGhlcmUgYW55IHdheSB0byBiaXNlY3QgdGhyb3VnaCB0aGUgcGFydHMgb2Yg
dGhlDQo+ID4gZHJtIG1lcmdlIHBhdGNoIGludG8gdjUuMTAtcmMxID8NCj4gPg0KPiA+IFRoYXQg
b3VnaHQgdG8gYmUgcXVpY2tlciAoYW5kIGxlc3MgZXJyb3IgcHJvbmUpIHRoYW4NCj4gPiB0aGUg
YmlzZWN0IGJ1aWxkcyBJIHdhcyBkb2luZy4NCj4gPg0KPiA+IE5vdGUgdGhhdCB0aGUgc3RhY2sg
J3NwbGF0JyBpcyBkdWUgdG8gYSBsYXRlciBjaGFuZ2UuDQo+ID4gSXQgaXMgc2VwYXJhdGUgZnJv
bSB0aGUgYnJva2VuIHBpeGVsIGFsaWdubWVudC4NCj4gPg0KPiA+IEkgYWN0dWFsbHkgc2F3IHRo
ZSB2Z2EgdGV4dCBnbyAnZnVubnknIHdoaWxlIHRoZSBib290DQo+ID4gd2FzIG91dHB1dHRpbmcg
YWxsIHRoZSBbT0tdIG1lc3NhZ2VzIChmcm9tIHN5c3RlbWQ/KQ0KPiA+IGJlZm9yZSB0aGUgZ3Jh
cGhpYyBsb2dpbiBzdG9sZSB0dHkxIChibG9vZHkgc3R1cGlkDQo+ID4gdG8gdXNlIHR0eTEpLg0K
PiA+DQo+ID4gSSBkb24ndCBuZWVkIHRvIHVzZSB0aGUgZmFpbGluZyBzeXN0ZW0gdG9kYXksIEkn
bGwNCj4gPiBoYXZlIGFub3RoZXIgZ28gYXQgaXNvbGF0aW5nIHRoZSBmYWlsdXJlLg0KPiANCj4g
WW91IGNhbiB1c2UgZHJtLXRpcCBmb3IgdGVzdGluZywgd2hlcmUgbWFueSBvZiB0aGUgRFJNIHBh
dGNoZXMgZ28gdGhyb3VnaC4NCj4gDQo+ICAgIGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcv
ZHJtL2RybS10aXAvDQo+IA0KPiBJdCdzIGZhaXJseSB1cC10by1kYXRlLg0KDQpBbnkgaWRlYSBv
ZiB0YWdzIGVpdGhlciBzaWRlIG9mIHRoZSA1LjEwIG1lcmdlPw0KDQo+IEkgaGF2ZSB0d28gc3lz
dGVtcyB3aXRoIEFTVCBjaGlwcyBhbmQgbmVpdGhlciBzaG93cyBhbnkgb2YgdGhlIHN5bXB0b21z
DQo+IHlvdSBkZXNjcmliZTsgbm9yIGRvIHdlIGhhdmUgc3VjaCByZXBvcnRzIGFib3V0IGRyaXZl
cnMgdGhhdCB1c2UgYQ0KPiBzaW1pbGFyIHN0YWNrIChoaWJtYywgYm9jaHMpLiBDb3VsZCB5b3Ug
cHJvdmlkZSB0aGUgb3V0cHV0IG9mDQo+IA0KPiAgICBkbWVzZyB8IGdyZXAgZHJtDQoNClsgICAg
Mi4xMTIzMDNdIGZiMDogc3dpdGNoaW5nIHRvIGFzdGRybWZiIGZyb20gRUZJIFZHQQ0KWyAgICAy
LjEyMDIyMl0gYXN0IDAwMDA6MDI6MDAuMDogW2RybV0gVXNpbmcgUDJBIGJyaWRnZSBmb3IgY29u
ZmlndXJhdGlvbg0KWyAgICAyLjEyMDIzM10gYXN0IDAwMDA6MDI6MDAuMDogW2RybV0gQVNUIDI0
MDAgZGV0ZWN0ZWQNClsgICAgMi4xMjAyNDddIGFzdCAwMDAwOjAyOjAwLjA6IFtkcm1dIEFuYWxv
ZyBWR0Egb25seQ0KWyAgICAyLjEyMDI1N10gYXN0IDAwMDA6MDI6MDAuMDogW2RybV0gZHJhbSBN
Q0xLPTQwOCBNaHogdHlwZT0xIGJ1c193aWR0aD0xNg0KWyAgICAyLjEyMTEyMV0gW2RybV0gSW5p
dGlhbGl6ZWQgYXN0IDAuMS4wIDIwMTIwMjI4IGZvciAwMDAwOjAyOjAwLjAgb24gbWlub3IgMA0K
WyAgICAyLjEyNTgzOF0gZmJjb246IGFzdGRybWZiIChmYjApIGlzIHByaW1hcnkgZGV2aWNlDQpb
ICAgIDIuMTUyMTc5XSBhc3QgMDAwMDowMjowMC4wOiBbZHJtXSBmYjA6IGFzdGRybWZiIGZyYW1l
IGJ1ZmZlciBkZXZpY2UNClsgICAgNi4wNjEwMzRdIHN5c3RlbWRbMV06IENvbmRpdGlvbiBjaGVj
ayByZXN1bHRlZCBpbiBMb2FkIEtlcm5lbCBNb2R1bGUgZHJtIGJlaW5nIHNraXBwZWQuDQoNClRo
ZSBvdXRwdXQgaXMgdGhlIHNhbWUgZm9yIGJvdGggZ29vZCBhbmQgYmFkIGtlcm5lbHMuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

