Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6812B8444
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKRTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:00:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:50926 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgKRTA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:00:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-25-1cEBhn94MimnJjzlWXZTFw-1; Wed, 18 Nov 2020 19:00:22 +0000
X-MC-Unique: 1cEBhn94MimnJjzlWXZTFw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 18 Nov 2020 19:00:21 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Nov 2020 19:00:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: RE: Linux 5.10-rc4
Thread-Topic: Linux 5.10-rc4
Thread-Index: AQHWu7P6i7HOJgcGCEellKywj802qKnNzjYQgABmnYCAAAwRYA==
Date:   Wed, 18 Nov 2020 19:00:21 +0000
Message-ID: <c776ad37ae9f48aa8eff020e4499901c@AcuMS.aculab.com>
References: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
 <692820a49ded436591b5fe3a18c68a5e@AcuMS.aculab.com>
 <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
In-Reply-To: <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTggTm92ZW1iZXIgMjAyMCAxODoxMQ0KPiAN
Cj4gT24gV2VkLCBOb3YgMTgsIDIwMjAgYXQgNDoxMiBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEkndmUgZ290IHRoZSAnc3BsYXQnIGJl
bG93IGR1cmluZyBib290Lg0KPiA+IFRoaXMgaXMgYW4gOC1jb3JlIEMyNzU4IEF0b20gY3B1IHVz
aW5nIHRoZSBvbi1ib2FyZC9jcHUgZ3JhcGhpY3MuDQo+ID4gVXNlciBzcGFjZSBpcyBVYnVudHUg
MjAuMDQuDQo+ID4NCj4gPiBBZGRpdGlvbmFsbHkgdGhlIFggZGlzcGxheSBoYXMgYWxsIHRoZSBj
b2xvdXJzIGFuZCBhbGlnbm1lbnQgc2xpZ2h0bHkNCj4gPiBtZXNzZWQgdXAuDQo+ID4gNS45LjAg
d2FzIG9rLg0KPiA+IEknbSBqdXN0IGd1ZXNzaW5nIHRoZSB0d28gaXNzdWVzIGFyZSByZWxhdGVk
Lg0KPiANCj4gU291bmRzIGxpa2VseS4gIEJ1dCBpdCB3b3VsZCBiZSBsb3ZlbHkgaWYgeW91IGNv
dWxkIGJpc2VjdCB3aGVuDQo+IGV4YWN0bHkgdGhlIHByb2JsZW0ocykgc3RhcnRlZCB0byBib3Ro
IHZlcmlmeSB0aGF0LCBhbmQganVzdCB0bw0KPiBwaW5wb2ludCB0aGUgZXhhY3QgY2hhbmdlLi4N
Cg0KSSdtIHdvcmtpbmcgb24gaXQgLSBoYXZlIGJlZW4gYWxsIGFmdGVybm9vbi4NCihJJ20gb24g
aG9saWRheSBhbmQgaXQgaXMgcmFpbmluZy4uLikNCg0KNS4xMC1yYzEgZmFpbHMsIHNvIGl0IGlz
IHNvbWV0aGluZyBpbiB0aGUgbWVyZ2Ugd2luZG93Lg0KSSBzdXNwZWN0IEknbGwganVzdCBoaXQg
dGhlIHB1bGwgb2YgdGhlIGRybSBjaGFuZ2VzLg0KVGhlIGJpc2VjdCBzdWRkZW5seSBidWlsZCBh
IDUuOS1yYzUrIGtlcm5lbCENClNvIEknbSByZXRlc3RpbmcgYSBnb29kL2JhZCBwYWlyIHdpdGgg
bGlrZWx5IGRhdGVzIGFuZCB3aWxsIHJlc3RhcnQgaXQuDQoNCkFubm95aW5nbHkgdGhlIHRlc3Qg
c3lzdGVtIGRlZmF1bHRzIHRvIGJvb3RpbmcgdGhlIGhpZ2hlc3QgdmVyc2lvbg0Ka2VybmVsIC0g
bm90IHRoZSBvbmUgSSd2ZSBqdXN0IGJ1aWxkOyBJIG1heSBoYXZlIGdpdmVuIGl0IGEgd3Jvbmcg
YW5zd2VyLg0KVGhlIGJ1aWxkcyBhbHNvIGFsbCB0YWtlIDIwIG1pbnV0ZXM7IHNvIHRoZSBiaXNl
Y3QgaXMgc2xvdy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

