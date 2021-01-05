Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F82EA80E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAEJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:54:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45686 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbhAEJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:54:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-16-zJTXlFpDMN-KCXMpc2E7rQ-1; Tue, 05 Jan 2021 09:53:07 +0000
X-MC-Unique: zJTXlFpDMN-KCXMpc2E7rQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 5 Jan 2021 09:53:06 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 5 Jan 2021 09:53:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@amacapital.net>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: RE: in_compat_syscall() on x86
Thread-Topic: in_compat_syscall() on x86
Thread-Index: AQHW4tnp52+Fp/HYSH2MXxqk00t/OqoYCInQgAANioCAALOoMA==
Date:   Tue, 5 Jan 2021 09:53:06 +0000
Message-ID: <9108ae60809f4fab846e610fe84f607f@AcuMS.aculab.com>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
 <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
In-Reply-To: <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDA0IEphbnVhcnkgMjAyMSAyMzowNA0KLi4u
DQo+ID4+IFRoZSB4MzIgc3lzdGVtIGNhbGxzIGhhdmUgdGhlaXIgb3duIHN5c3RlbSBjYWxsIHRh
YmxlIGFuZCBpdCB3b3VsZCBiZQ0KPiA+PiB0cml2aWFsIHRvIHNldCBhIGZsYWcgbGlrZSBUU19D
T01QQVQgd2hlbiBsb29raW5nIHVwIGEgc3lzdGVtIGNhbGwgZnJvbQ0KPiA+PiB0aGF0IHRhYmxl
LiAgSSBleHBlY3Qgc3VjaCBhIGNoYW5nZSB3b3VsZCBiZSBwdXJlbHkgaW4gdGhlIG5vaXNlLg0K
PiA+DQo+ID4gQ2VydGFpbmx5IGEgd3JpdGUgb2YgMC8xLzIgaW50byBhIGRpcnRpZWQgY2FjaGUg
bGluZSBvZiAnY3VycmVudCcNCj4gPiBjb3VsZCBlYXNpbHkgY29zdCBhYnNvbHV0ZWx5IG5vdGhp
bmcuDQo+ID4gRXNwZWNpYWxseSBpZiBjdXJyZW50IGhhcyBhbHJlYWR5IGJlZW4gcmVhZC4NCj4g
Pg0KPiA+IEkgYWxzbyB3b25kZXJlZCBhYm91dCByZXNldHRpbmcgaXQgdG8gemVybyB3aGVuIGFu
IHgzMiBzeXN0ZW0gY2FsbA0KPiA+IGV4aXRzIChyYXRoZXIgdGhhbiBlbnRyeSB0byBhIDY0Yml0
IG9uZSkuDQo+ID4NCj4gPiBGb3IgaWEzMiB0aGUgZmxhZyBpcyBzZXQgKHdpdGggfD0pIG9uIGV2
ZXJ5IHN5c2NhbGwgZW50cnkuDQo+ID4gRXZlbiB0aG91Z2ggSSdtIHByZXR0eSBzdXJlIGl0IGNh
biBvbmx5IGNoYW5nZSBkdXJpbmcgZXhlYy4NCj4gDQo+IEl0IGNhbiBjaGFuZ2UgZm9yIGV2ZXJ5
IHN5c2NhbGwuIEkgaGF2ZSB0ZXN0cyB0aGF0IGRvIHRoaXMuDQoNCkRvIHRoZXkgc3RpbGwgd29y
az8NCkkgZG9uJ3QgdGhpbmsgdGhlIGlhMzIgZmxhZyBpcyBjbGVhcmVkIGFueXdoZXJlLg0KDQpT
byBhIDY0Yml0IHdyaXRldigpIG1pZ2h0IHRvIGJhZGx5IHdyb25nIGFmdGVyIGFuIGlhMzIgc3lz
Y2FsbC4NCg0KVGhlIHgzMiBmbGFnIGlzIGRpZmZlcmVudCwgdGhlIHN5c2NhbGxzIGp1c3QgaGF2
ZSBkaWZmZXJlbnQgbnVtYmVycy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

