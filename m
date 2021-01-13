Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217DA2F5501
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbhAMWsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:48:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58028 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729381AbhAMWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:41:41 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-245-o5ZQSi_3OTOs2qtHxtjrAw-1; Wed, 13 Jan 2021 22:39:54 +0000
X-MC-Unique: o5ZQSi_3OTOs2qtHxtjrAw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 Jan 2021 22:39:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Jan 2021 22:39:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        "vanessa.hack@fau.de" <vanessa.hack@fau.de>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: objtool/ORC generation for noreturn functions
Thread-Topic: objtool/ORC generation for noreturn functions
Thread-Index: AQHW6dvx3EeZ32LrMkWW5+fWAxN3w6omI14A
Date:   Wed, 13 Jan 2021 22:39:53 +0000
Message-ID: <8bfda75985c4429297afce9340303e34@AcuMS.aculab.com>
References: <daf04159-a458-4f0d-9f29-d8ef5a63fae6@email.android.com>
 <20210113184131.yh4zh4olfkdpydv7@treble>
In-Reply-To: <20210113184131.yh4zh4olfkdpydv7@treble>
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

PiBPbiBXZWQsIEphbiAxMywgMjAyMSBhdCAxMTo0NDoyMkFNICswMTAwLCB2YW5lc3NhLmhhY2tA
ZmF1LmRlIHdyb3RlOg0KPiA+ICAgIEhpLA0KPiA+ICAgIEkgYW0gY3VycmVudGx5IHdyaXRpbmcg
bXkgZmluYWwgdGhlc2lzIGF0IHVuaXZlcnNpdHkgb24gdGhlIHRvcGljIG9mIHN0YWNrDQo+ID4g
ICAgdW53aW5kaW5nLiBNeSBnb2FsIGlzIHRvIGltcGxlbWVudCBhbmQgZXZhbHVhdGUgc3RhY2sg
dW53aW5kZXJzIGZvcg0KPiA+ICAgIHJlc2VhcmNoIG9wZXJhdGluZyBzeXN0ZW0gcG9ydHMgdG8g
eDg2IDMyIGFuZCA2NCBiaXQgYXJjaGl0ZWN0dXJlcyBhbmQNCj4gPiAgICBTUEFSQyBWOC4NCj4g
PiAgICBGb3IgdGhlIHg4NiBwb3J0cyBJIGNob3NlIE9SQyBhcyB1bndpbmRpbmcgZm9ybWF0IGR1
ZSB0byBpdHMgc2ltcGxpY2l0eQ0KPiA+ICAgIGFuZCByZWxpYWJpbGl0eS4gU28gZmFyLCBpdCB3
b3JrcyBxdWl0ZSB3ZWxsIChhbHRob3VnaCBJJ3ZlIHJhbiBpbnRvIHNvbWUNCj4gPiAgICBtaW5v
ciBpc3N1ZXMgd2l0aCBvYmp0b29sIGFzIHRoZSByZXNlYXJjaCBPUyBpcyB3cml0dGVuIGluIEMr
KykuDQo+ID4gICAgQnV0IG5vdyBJIGhhdmUgc29tZSBwcm9ibGVtcyB3aXRoIGZ1bmN0aW9ucyB0
aGF0IGFyZSBleHBsaWNpdGx5IG1hcmtlZCBhcw0KPiA+ICAgIG5vcmV0dXJuIHdpdGggdGhlIFtb
bm9yZXR1cm5dXSBhdHRyaWJ1dGUsIGFsbCBmb2xsb3dpbmcgdW53aW5kaW5nIHN0ZXBzDQo+ID4g
ICAgYXJlIHVucmVsaWFibGUuIEkgaGF2ZSByZWFkIGluIHRoZSBvYmp0b29sIGRvY3VtZW50YXRp
b24gdGhhdCBzdWNoDQo+ID4gICAgZnVuY3Rpb25zIGhhdmUgdG8gYmUgYWRkZWQgdG8gdGhlIG9i
anRvb2wgZ2xvYmFsX25vcmV0dXJuIGFycmF5Lg0KPiA+ICAgIFVuZm9ydHVuYXRlbHksIEkgZG8g
bm90IHVuZGVyc3RhbmQgdGhlIHB1cnBvc2Ugb2YgdGhhdCBhcnJheSBhbmQgdGhlDQo+ID4gICAg
aW50ZW5kZWQgT1JDIGJlaGF2aW91ciBmb3Igbm9yZXR1cm4gZnVuY3Rpb25zLiBBcmUgdGhlIHVu
d2luZGluZyBzdGVwcw0KPiA+ICAgIHRoYXQgZm9sbG93IGEgbm9yZXR1cm4gaW50ZW5kZWQgdG8g
YmUgdW5yZWxpYWJsZT8NCg0KVGhlcmUgd2FzIGFuICdpbnRlcmVzdGluZycgdW53aW5kZXIgSSBz
YXcgYSBmZXcgeWVhcnMgYWdvLg0KKFdoaWNoIGNvdWxkbid0IGhhbmRsZSAnbm9yZXR1cm4nIGZ1
bmN0aW9ucy4pDQoNClRoZSBpZGVhIGlzIHRvIGZvbGxvdyBmb3J3YXJkcyB0aHJvdWdoIHRoZSBj
b2RlIHdoaWxlIGtlZXBpbmcNCnRyYWNrIG9mICVzcCBhbmQgJWZwIHVudGlsIGEgcmV0dXJuIGlu
c3RydWN0aW9uIGlzIGZvdW5kLg0KWW91IG5lZWQgdG8gYmUgYWJsZSB0byBkZXRlY3QgbG9vcHMs
IGFuZCB0aGVuIGNvbnRpbnVlIGZyb20NCnRoZSBvdGhlciB0YXJnZXQgb2YgYW4gZWFybGllciBj
b25kaXRpb25hbCBicmFuY2guDQpQcm92aWRlZCBmdW5jdGlvbiBjYWxscyBkb24ndCBjaGFuZ2Ug
JXNwIHRoZXkgY2FuIGJlIGlnbm9yZWQuDQpJZiB0aGUgJWZwIGlzbid0IHVzZWQgYXMgYSBmcmFt
ZSBwb2ludGVyIGl0IHdvbid0IGdldCByZWxvYWRlZA0KaW50byAlc3Agc28gaXQgZG9lc24ndCBt
YXR0ZXINCg0KVGhpcyB3b3JrcyAobW9zdCBvZiB0aGUgdGltZSkgd2l0aCBubyBkZWJ1ZyBpbmZv
IGFuZCBubyBzeW1ib2wNCnRhYmxlLg0KDQpBZGRpbmcgYSBjb2RlIG1hcmtlciBhZnRlciBhIGNh
bGwgdG8gYSAnbm90cmV0dXJuJyBmdW5jdGlvbiAoZWcgJ2ptcCAuJykNCm1pZ2h0IGJlIHRoZSBz
aW1wbGVzdCB3YXkgb2Ygc3RvcHBpbmcgdGhlbSBiZWluZyBhbiBpc3N1ZS4NClRoZSBleHRyYSBp
bnN0cnVjdGlvbiBpcyB1bmxpa2VseSB0byBiZSBhbiBpc3N1ZS4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

