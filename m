Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B120C2869E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgJGVLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:11:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59516 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgJGVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:11:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-uIL7QyCPPFmHh7zg-MwAdA-1; Wed, 07 Oct 2020 22:11:36 +0100
X-MC-Unique: uIL7QyCPPFmHh7zg-MwAdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 7 Oct 2020 22:11:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Oct 2020 22:11:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Luck, Tony'" <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Topic: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Index: AQHWnCT7Akl0tQfunEO6b5w/PLxMVqmLzKMAgACfloCAADZ6cA==
Date:   Wed, 7 Oct 2020 21:11:35 +0000
Message-ID: <65c0345e142c4c46a5cfd8f8b51489aa@AcuMS.aculab.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
 <20201006210910.21062-5-tony.luck@intel.com>
 <c994091cdc9d42718769f584b7d4a134@AcuMS.aculab.com>
 <c0791688c58f434ca9e413630504d22d@intel.com>
In-Reply-To: <c0791688c58f434ca9e413630504d22d@intel.com>
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

RnJvbTogTHVjaywgVG9ueQ0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMjAgMTk6NTANCj4gPj4gTWFj
aGluZSBjaGVja3MgYXJlIG1vcmUgc2VyaW91cy4gSnVzdCBnaXZlIHVwIGF0IHRoZSBwb2ludCB3
aGVyZSB0aGUNCj4gPj4gbWFpbiBjb3B5IGxvb3AgdHJpZ2dlcmVkIHRoZSAjTUMgYW5kIHJldHVy
biBmcm9tIHRoZSBjb3B5IGNvZGUgYXMgaWYNCj4gPj4gdGhlIGNvcHkgc3VjY2VlZGVkLiBUaGUg
bWFjaGluZSBjaGVjayBoYW5kbGVyIHdpbGwgdXNlIHRhc2tfd29ya19hZGQoKSB0bw0KPiA+PiBt
YWtlIHN1cmUgdGhhdCB0aGUgdGFzayBpcyBzZW50IGEgU0lHQlVTLg0KPiA+DQo+ID4gSXNuJ3Qg
dGhhdCBqdXN0IHBsYWluIHdyb25nPw0KPiANCj4gSXQgaXNuJ3QgcHJldHR5LiBJJ20gbm90IHN1
cmUgaG93IHdyb25nIGl0IGlzLg0KPiANCj4gPiBJZiBjb3B5IGlzIHJlcG9ydGVkIGFzIHN1Y2Nl
ZWRpbmcgdGhlIGtlcm5lbCBjb2RlIHdpbGwgdXNlIHRoZSAnb2xkJw0KPiA+IGRhdGEgdGhhdCBp
cyBpbiB0aGUgYnVmZmVyIGFzIGlmIGl0IGhhZCBiZWVuIHJlYWQgZnJvbSB1c2Vyc3BhY2UuDQo+
ID4gVGhpcyBjb3VsZCBlbmQgdXAgd2l0aCBrZXJuZWwgc3RhY2sgZGF0YSBiZWluZyB3cml0dGVu
IHRvIGEgZmlsZS4NCj4gDQo+IEkgcmFuIGEgdGVzdCB3aXRoOg0KPiANCj4gCXdyaXRlKGZkLCBi
dWYsIDUxMikNCj4gDQo+IFdpdGggcG9pc29uIGluamVjdGVkIGludG8gYnVmWzI1Nl0gdG8gZm9y
Y2UgYSBtYWNoaW5lIGNoZWNrIG1pZC1jb3B5Lg0KPiANCj4gVGhlIHNpemUgb2YgdGhlIGZpbGUg
ZGlkIGdldCBpbmNyZW1lbnRlZCBieSA1MTIgcmF0aGVyIHRoYW4gMjU2LiBXaGljaCBpc24ndCBn
b29kLg0KPiANCj4gVGhlIGRhdGEgaW4gdGhlIGZpbGUgdXAgdG8gdGhlIDI1NiBieXRlIG1hcmsg
d2FzIHRoZSB1c2VyIGRhdGEgZnJvbSBidWZbMCAuLi4gMjU1XS4NCj4gDQo+IFRoZSBkYXRhIGlu
IHRoZSBmaWxlIHBhc3Qgb2Zmc2V0IDI1NiB3YXMgYWxsIHplcm9lcy4gSSBzdXNwZWN0IHRoYXQg
aXNuJ3QgYnkgY2hhbmNlLg0KPiBUaGUga2VybmVsIGhhcyB0byBkZWZlbmQgYWdhaW5zdCBhIHVz
ZXIgd3JpdGluZyBhIHBhcnRpYWwgcGFnZSBhbmQgdXNpbmcgbW1hcCgyKQ0KPiBvbiB0aGUgc2Ft
ZSBmaWxlIHRvIHBlZWsgYXQgZGF0YSBwYXN0IEVPRiBhbmQgdXAgdG8gdGhlIG5leHQgUEFHRV9T
SVpFIGJvdW5kYXJ5Lg0KPiBTbyBJIHRoaW5rIGl0IG11c3QgemVybyBuZXcgcGFnZXMgYWxsb2Nh
dGVkIGluIHBhZ2UgY2FjaGUgYXMgdGhleSBhcmUgYWxsb2NhdGVkIHRvDQo+IGEgZmlsZS4NCg0K
VGhpbmsgYWJvdXQgd2hhdCBoYXBwZW5zIHRvIGEgZGV2aWNlIHdyaXRlIG9yIGFuIGlvY3RsIHJl
cXVlc3QuDQpUaGVzZSB0eXBpY2FsbHkgZ2V0IGNvcGllZCBpbnRvIG9uLXN0YWNrIGJ1ZmZlcnMu
DQoNCj4gPiBJSVJDIHRoZSBjb2RlIHRvIHRyeSB0byBtYXhpbWlzZSB0aGUgY29weSBoYXMgYmVl
biByZW1vdmVkLg0KPiA+IFNvIHRoZSAnc2xvdycgcmV0cnkgd29udCBoYXBwZW4gYW55IG1vcmUu
DQo+IA0KPiBXaGljaCBjb2RlIGhhcyBiZWVuIHJlbW92ZWQgKGFuZCB3aGVuIC4uLiBUSVAsIGFu
ZCBteSB0ZXN0aW5nLCBpcyBiYXNlZCBvbiA1LjktcmMxKQ0KDQpUaGUgY29kZSB0aGF0IHJldHJp
ZXMgYnl0ZSBieSBieXRlIGFmdGVyIGFuIGluaXRpYWwgZmF1bHQuDQpNaWdodCBvbmx5IGJlIHJl
bW92ZWQgZnJvbSAnbmV4dCcgYW5kIGZvciBzb21lIGFyY2hpdGVjdHVyZXMuDQpCYXNpY2FsbHkg
YWxtb3N0IG5vdGhpbmcgZXZlciByZWxpZXMgb24gcGFydGlhbCBjb3BpZXMgKGV4Y2VwdCBtb3Vu
dCkuDQoNCklJUkMgdGhlcmUgaXMgJ21hZ2ljJyBpbiB0aGUgc3lzY2FsbCBleGl0IHBhdGggdG8g
Y29udmVydCBFRkFVTFQNCmludG8gU0lHU0VHVi4NCllvdSBwcm9iYWJseSB3YW50IHRvIGhpamFj
ayBpdCB0byBnZW5lcmF0ZSBTSUdCVVM/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

