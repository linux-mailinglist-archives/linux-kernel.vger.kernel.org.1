Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669342697AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:24:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39996 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgINVYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:24:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-8-UaEi5kBnO_e_VhHpOiWrkQ-1;
 Mon, 14 Sep 2020 22:24:00 +0100
X-MC-Unique: UaEi5kBnO_e_VhHpOiWrkQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 14 Sep 2020 22:23:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 14 Sep 2020 22:23:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Waiman Long" <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: RE: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWisBV61WRef5OMEyULIupnNS1CKloouig
Date:   Mon, 14 Sep 2020 21:23:59 +0000
Message-ID: <2e6a4d75b38248f1b8b3b874d36065f1@AcuMS.aculab.com>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
In-Reply-To: <20200914175604.GF680@zn.tnic>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDE0IFNlcHRlbWJlciAyMDIwIDE4OjU2DQo+
IA0KPiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAxMjoyMjo1M1BNIC0wNTAwLCBKb3NoIFBvaW1i
b2V1ZiB3cm90ZToNCj4gPiArLyoNCj4gPiArICogU2FuaXRpemUgYSB1c2VyIHBvaW50ZXIgc3Vj
aCB0aGF0IGl0IGJlY29tZXMgTlVMTCBpZiBpdCdzIG5vdCBhIHZhbGlkIHVzZXINCj4gPiArICog
cG9pbnRlci4gIFRoaXMgcHJldmVudHMgc3BlY3VsYXRpdmUgZGVyZWZlcmVuY2VzIG9mIHVzZXIt
Y29udHJvbGxlZCBwb2ludGVycw0KPiA+ICsgKiB0byBrZXJuZWwgc3BhY2Ugd2hlbiBhY2Nlc3Nf
b2soKSBzcGVjdWxhdGl2ZWx5IHJldHVybnMgdHJ1ZS4gIFRoaXMgc2hvdWxkIGJlDQo+ID4gKyAq
IGRvbmUgKmFmdGVyKiBhY2Nlc3Nfb2soKSwgdG8gYXZvaWQgYWZmZWN0aW5nIGVycm9yIGhhbmRs
aW5nIGJlaGF2aW9yLg0KPiANCj4gRXJyLCBzdHVwaWQgcXVlc3Rpb246IGNhbiB0aGlzIG1hY3Jv
IHRoZW4gYmUgZm9sZGVkIGludG8gYWNjZXNzX29rKCkgc28NCj4gdGhhdCB5b3UgZG9uJ3QgaGF2
ZSB0byB0b3VjaCBzbyBtYW55IHBsYWNlcyBhbmQgdGhlIGNoZWNrIGNhbiBoYXBwZW4NCj4gYXV0
b21hdGljYWxseT8NCg0KTXkgdGhvdWdodHMgYXJlIHRoYXQgYWNjZXNzX29rKCkgY291bGQgcmV0
dXJuIDAgZm9yIGZhaWwgYW5kIH4wdQ0KZm9yIHN1Y2Nlc3MuDQpZb3UgY291bGQgdGhlbiBkbyAo
d2l0aCBhIGZldyBjYXN0cyk6DQoJbWFzayA9IGFjY2Vzc19vayhwdHIsIHNpemUpOw0KCS8qIFN0
b3AgZ2NjIHRyYWNraW5nIHRoZSB2YWx1ZSBvZiBtYXNrLiAqLw0KCWFzbSB2b2xhdGlsZSggIiIg
OiAiK3IiIChtYXNrKSk7DQoJYWRkciA9IHB0ciAmIG1hc2s7DQoJaWYgKCFhZGRyICYmIHB0cikg
IC8vIExldCBOVUxMIHRocm91Z2g/Pw0KCQlyZXR1cm4gLUVGQVVMVDsNCg0KSSB0aGluayB0aGVy
ZSBhcmUgb3RoZXIgY2hhbmdlcyBpbiB0aGUgcGlwZWxpbmUgdG8gcmVtb3ZlDQptb3N0IG9mIHRo
ZSBhY2Nlc3Nfb2soKSBhcGFydCBmcm9tIHRob3NlIGluc2lkZSBwdXQvZ2V0X3VzZXIoKQ0KYW5k
IGNvcHlfdG8vZnJvbV91c2VyKCkuDQpTbyB0aGUgY2hhbmdlcyBzaG91bGQgYmUgbW9yZSBsaW1p
dGVkIHRoYW4geW91IG1pZ2h0IHRoaW5rLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

