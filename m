Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03FE2EBBC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbhAFJoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:44:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42587 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbhAFJoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:44:13 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-134-GOWJFpBUNTOJhoaGXAnJhw-1; Wed, 06 Jan 2021 09:42:34 +0000
X-MC-Unique: GOWJFpBUNTOJhoaGXAnJhw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 6 Jan 2021 09:42:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 6 Jan 2021 09:42:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: RE: in_compat_syscall() on x86
Thread-Topic: in_compat_syscall() on x86
Thread-Index: AQHW4tnp52+Fp/HYSH2MXxqk00t/OqoYCInQgAANioCAALOoMIAAgtuAgABZLEA=
Date:   Wed, 6 Jan 2021 09:42:33 +0000
Message-ID: <113ae3678beb4d33882506a85b398362@AcuMS.aculab.com>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
 <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
 <9108ae60809f4fab846e610fe84f607f@AcuMS.aculab.com>
 <CALCETrV_Ng4xjd1fanXZJ5=EFN4w2RYMK0EqsnKmMkSYbQhN0w@mail.gmail.com>
In-Reply-To: <CALCETrV_Ng4xjd1fanXZJ5=EFN4w2RYMK0EqsnKmMkSYbQhN0w@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDA1IEphbnVhcnkgMjAyMSAxNzozNQ0KPiAN
Cj4gT24gVHVlLCBKYW4gNSwgMjAyMSBhdCAxOjUzIEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+IC4uLg0KLi4uDQo+ID4gPiA+IEkgYWxzbyB3b25k
ZXJlZCBhYm91dCByZXNldHRpbmcgaXQgdG8gemVybyB3aGVuIGFuIHgzMiBzeXN0ZW0gY2FsbA0K
PiA+ID4gPiBleGl0cyAocmF0aGVyIHRoYW4gZW50cnkgdG8gYSA2NGJpdCBvbmUpLg0KPiA+ID4g
Pg0KPiA+ID4gPiBGb3IgaWEzMiB0aGUgZmxhZyBpcyBzZXQgKHdpdGggfD0pIG9uIGV2ZXJ5IHN5
c2NhbGwgZW50cnkuDQo+ID4gPiA+IEV2ZW4gdGhvdWdoIEknbSBwcmV0dHkgc3VyZSBpdCBjYW4g
b25seSBjaGFuZ2UgZHVyaW5nIGV4ZWMuDQo+ID4gPg0KPiA+ID4gSXQgY2FuIGNoYW5nZSBmb3Ig
ZXZlcnkgc3lzY2FsbC4gSSBoYXZlIHRlc3RzIHRoYXQgZG8gdGhpcy4NCj4gPg0KPiA+IERvIHRo
ZXkgc3RpbGwgd29yaz8NCj4gDQo+IFRoZXkgc2VlbSB0by4NCj4gDQo+ID4gSSBkb24ndCB0aGlu
ayB0aGUgaWEzMiBmbGFnIGlzIGNsZWFyZWQgYW55d2hlcmUuDQo+IA0KPiBJdCdzIGhpZGluZyBp
biBhcmNoX2V4aXRfdG9fdXNlcl9tb2RlX3ByZXBhcmUoKS4NCg0KTm8gd29uZGVyIEkgZG9uJ3Qg
bm90aWNlLg0KVGhlcmUgaXMgYSBSTVcgdG8gY2xlYXIgVFNfQ09NUEFUIHwgVFNfSTM4Nl9SRUdT
X1BPS0VEIGFzIChhYm91dCkNCnRoZSB2ZXJ5IGxhc3QgdGhpbmcgZG9uZSBiZWZvcmUgcmV0dXJu
aW5nIHRvIHVzZXIuDQoNClNob3J0IG9yIHJlbmFtaW5nIHRoZSAnc3RhdHVzJyBmaWVsZCBhbmQg
Zml4aW5nIHRoZSBjb21waWxhdGlvbiBlcnJvcnMNCkkgY2FuJ3Qgc2VlIGFuIG9idmlvdXMgd2F5
IG9mIGRldGVjdGluZyBhbnkgb3RoZXIgc3RhdHVzIGZsYWcgYml0cy4NCg0KSWYgbm9uZSBhcmUg
dXNlZCAob3IgYSBkaWZmZXJlbnQgZmllbGQgaXMgdXNlZCkgdGhlbiBhbiB1bmNvbmRpdGlvbmFs
DQp3cml0ZSBvZiB0aGUgc3lzY2FsbCB0eXBlIGluIHRoZSBlbnRyeSBwYXRocyB3b3VsZCByZW1v
dmUgdGhlIG5lZWQgZm9yDQp0aGUgY2xlYXIgaW4gdGhlIHN5c2NhbGwgZXhpdCBwYXRoLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

