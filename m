Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFE2FDD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbhATWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:38:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49356 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733236AbhATW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:27:40 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-48-DiN8dlsEO2SkM7vhnYMaMA-1; Wed, 20 Jan 2021 22:25:58 +0000
X-MC-Unique: DiN8dlsEO2SkM7vhnYMaMA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Jan 2021 22:25:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Jan 2021 22:25:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: Splicing to/from a tty
Thread-Topic: Splicing to/from a tty
Thread-Index: AQHW72ODm/V94rBWlE2o2nAONgRsB6oxFjPA
Date:   Wed, 20 Jan 2021 22:25:56 +0000
Message-ID: <29625ab9f4f94b84aacf96ad9b5da828@AcuMS.aculab.com>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <20210118193457.GA736435@zeniv-ca>
 <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjAgSmFudWFyeSAyMDIxIDE5OjI3DQo+IE9u
IFdlZCwgSmFuIDIwLCAyMDIxIGF0IDExOjExIEFNIEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgu
b3JnLnVrPiB3cm90ZToNCj4gPg0KPiA+IFdoeSBkbyB3ZSBjYXJlIGFib3V0IE9fQVBQRU5EIG9u
IGFueXRoaW5nIHdpdGhvdXQgRk1PREVfUFdSSVRFIChpbmNsdWRpbmcNCj4gPiBwaXBlcyksIGFu
eXdheT8gIEFsbCB3cml0ZXMgdGhlcmUgaWdub3JlIHBvc2l0aW9uLCBhZnRlciBhbGwuLi4NCj4g
DQo+IFdlIHNob3VsZG4ndCBjYXJlLg0KPiANCj4gQWxzbywgSSB0aGluayB3ZSBzaG91bGQgdHJ5
IHRvIG1vdmUgYXdheSBmcm9tIEZNT0RFX1BXUklURS9QUkVBRA0KPiBlbnRpcmVseSwgYW5kIHVz
ZSBGTU9ERV9TVFJFQU0gYXMgdGhlIHByaW1hcnkgInRoaXMgdGhpbmcgZG9lc24ndCBoYXZlDQo+
IGEgcG9zaXRpb24gYXQgYWxsIi4NCj4gDQo+IFRoYXQncyB3aGF0IGdldHMgcmlkIG9mIGFsbCB0
aGUgZl9wb3MgbG9ja2luZyBldGMgYWZ0ZXIgYWxsLiBUaGUNCj4gRk1PREVfUFdSSVRFL1BSRUFE
IGZsYWdzIGFyZSBJIHRoaW5rIGxlZ2FjeSAoYWx0aG91Z2ggd2UgZG8gc2VlbSB0bw0KPiBoYXZl
IHRoZSBzZXFfZmlsZSBjYXNlIHRoYXQgbm9ybWFsbHkgYWxsb3dzIHBvc2l0aW9uIG9uIHJlYWRz
LCBidXQgbm90DQo+IG9uIHdyaXRlcywgc28gd2UgbWF5IG5lZWQgdG8ga2VlcCBhbGwgdGhyZWUg
Yml0cykuDQo+IA0KPiBBbnl3YXksIEkgdGhpbmsgdGhhdCB3aXRoIEZNT0RFX1NUUkVBTSwgT19B
UFBFTkQgZGVmaW5pdGVseSBzaG91bGQgYmUgYSBuby1vcC4NCg0KSSBhbHNvIHdvbmRlciBpZiBw
cmVhZC9wd3JpdGUgd2l0aCBvZmZzZXQgPT0gMCBzaG91bGQgYmUgdmFsaWQNCm9uIHRoaW5ncyB3
aGVyZSB0aGUgb2Zmc2V0IG1ha2VzIG5vIHNlbnNlLg0KDQpJJ20gcmF0aGVyIHN1cnByaXNlZCB0
aGUgb2Zmc2V0IGlzbid0IGp1c3Qgc2lsZW50bHkgaWdub3JlZA0KZm9yIGRldmljZXMgd2hlcmUg
c2Vla2luZyBpcyBub24tc2Vuc2ljYWwuDQpZb3UgbWlnaHQgd2FudCB0byBlcnJvciBpdCBmb3Ig
bWFnIHRhcGVzLCBidXQgbm90IHBpcGVzLA0KdHR5cywgc29ja2V0cyBldGMuDQoNCkkgcmVhbGx5
IGNhbid0IHJlbWVtYmVyIHdoYXQgU1lTViwgU29sYXJpcyBvciBOZXRCU0QgZG8uDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

