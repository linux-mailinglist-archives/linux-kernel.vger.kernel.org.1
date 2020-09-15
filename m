Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D526A0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIOIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:23:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32355 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgIOIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:22:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-71-5leh59vyMUmzAnr2F172FA-1; Tue, 15 Sep 2020 09:22:50 +0100
X-MC-Unique: 5leh59vyMUmzAnr2F172FA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Sep 2020 09:22:49 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Sep 2020 09:22:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     'Borislav Petkov' <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
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
Thread-Index: AQHWisBV61WRef5OMEyULIupnNS1CKloouig///5HACAAMAeUA==
Date:   Tue, 15 Sep 2020 08:22:49 +0000
Message-ID: <18cc6ae97e1f4bf5a81167e0c1313935@AcuMS.aculab.com>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
 <2e6a4d75b38248f1b8b3b874d36065f1@AcuMS.aculab.com>
 <20200914215104.cjvycgie2wd3omtn@treble>
In-Reply-To: <20200914215104.cjvycgie2wd3omtn@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMTQgU2VwdGVtYmVyIDIwMjAgMjI6NTENCj4g
DQo+IE9uIE1vbiwgU2VwIDE0LCAyMDIwIGF0IDA5OjIzOjU5UE0gKzAwMDAsIERhdmlkIExhaWdo
dCB3cm90ZToNCj4gPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YNCj4gPiA+IFNlbnQ6IDE0IFNlcHRl
bWJlciAyMDIwIDE4OjU2DQo+ID4gPg0KPiA+ID4gT24gVGh1LCBTZXAgMTAsIDIwMjAgYXQgMTI6
MjI6NTNQTSAtMDUwMCwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+ID4gPiA+ICsvKg0KPiA+ID4g
PiArICogU2FuaXRpemUgYSB1c2VyIHBvaW50ZXIgc3VjaCB0aGF0IGl0IGJlY29tZXMgTlVMTCBp
ZiBpdCdzIG5vdCBhIHZhbGlkIHVzZXINCj4gPiA+ID4gKyAqIHBvaW50ZXIuICBUaGlzIHByZXZl
bnRzIHNwZWN1bGF0aXZlIGRlcmVmZXJlbmNlcyBvZiB1c2VyLWNvbnRyb2xsZWQgcG9pbnRlcnMN
Cj4gPiA+ID4gKyAqIHRvIGtlcm5lbCBzcGFjZSB3aGVuIGFjY2Vzc19vaygpIHNwZWN1bGF0aXZl
bHkgcmV0dXJucyB0cnVlLiAgVGhpcyBzaG91bGQgYmUNCj4gPiA+ID4gKyAqIGRvbmUgKmFmdGVy
KiBhY2Nlc3Nfb2soKSwgdG8gYXZvaWQgYWZmZWN0aW5nIGVycm9yIGhhbmRsaW5nIGJlaGF2aW9y
Lg0KPiA+ID4NCj4gPiA+IEVyciwgc3R1cGlkIHF1ZXN0aW9uOiBjYW4gdGhpcyBtYWNybyB0aGVu
IGJlIGZvbGRlZCBpbnRvIGFjY2Vzc19vaygpIHNvDQo+ID4gPiB0aGF0IHlvdSBkb24ndCBoYXZl
IHRvIHRvdWNoIHNvIG1hbnkgcGxhY2VzIGFuZCB0aGUgY2hlY2sgY2FuIGhhcHBlbg0KPiA+ID4g
YXV0b21hdGljYWxseT8NCj4gPg0KPiA+IE15IHRob3VnaHRzIGFyZSB0aGF0IGFjY2Vzc19vaygp
IGNvdWxkIHJldHVybiAwIGZvciBmYWlsIGFuZCB+MHUNCj4gPiBmb3Igc3VjY2Vzcy4NCj4gPiBZ
b3UgY291bGQgdGhlbiBkbyAod2l0aCBhIGZldyBjYXN0cyk6DQo+ID4gCW1hc2sgPSBhY2Nlc3Nf
b2socHRyLCBzaXplKTsNCj4gPiAJLyogU3RvcCBnY2MgdHJhY2tpbmcgdGhlIHZhbHVlIG9mIG1h
c2suICovDQo+ID4gCWFzbSB2b2xhdGlsZSggIiIgOiAiK3IiIChtYXNrKSk7DQo+ID4gCWFkZHIg
PSBwdHIgJiBtYXNrOw0KPiA+IAlpZiAoIWFkZHIgJiYgcHRyKSAgLy8gTGV0IE5VTEwgdGhyb3Vn
aD8/DQo+ID4gCQlyZXR1cm4gLUVGQVVMVDsNCj4gPg0KPiA+IEkgdGhpbmsgdGhlcmUgYXJlIG90
aGVyIGNoYW5nZXMgaW4gdGhlIHBpcGVsaW5lIHRvIHJlbW92ZQ0KPiA+IG1vc3Qgb2YgdGhlIGFj
Y2Vzc19vaygpIGFwYXJ0IGZyb20gdGhvc2UgaW5zaWRlIHB1dC9nZXRfdXNlcigpDQo+ID4gYW5k
IGNvcHlfdG8vZnJvbV91c2VyKCkuDQo+ID4gU28gdGhlIGNoYW5nZXMgc2hvdWxkIGJlIG1vcmUg
bGltaXRlZCB0aGFuIHlvdSBtaWdodCB0aGluay4NCj4gDQo+IE1heWJlLCBidXQgSSBiZWxpZXZl
IHRoYXQncyBzdGlsbCBnb2luZyB0byBlbmQgdXAgYSB0cmVld2lkZSBjaGFuZ2UuDQo+IA0KPiBB
bmQsIGlmIHdlJ3JlIGdvaW5nIHRvIHRoZSB0cm91YmxlIG9mIGNoYW5naW5nIHRoZSBhY2Nlc3Nf
b2soKQ0KPiBpbnRlcmZhY2UsIHdlIHNob3VsZCBjaGFuZ2UgaXQgZW5vdWdoIHRvIG1ha2Ugc3Vy
ZSB0aGF0IGFjY2lkZW50YWwgdXNlcw0KPiBvZiB0aGUgb2xkIGludGVyZmFjZSAoYWZ0ZXIgeWVh
cnMgb2YgbXVzY2xlIG1lbW9yeSkgd2lsbCBmYWlsIHRvIGJ1aWxkLg0KPiANCj4gV2UgY291bGQg
ZWl0aGVyIGFkZCBhIDNyZCBhcmd1bWVudCwgb3IgcmVuYW1lIGl0IHRvIGFjY2Vzc19va19tYXNr
KCkgb3INCj4gc29tZXRoaW5nLg0KDQpJdCB3b3VsZCB0YWtlIHNvbWUgdGhvdWdodCB0byBnZXQg
cmlnaHQgKGFuZCBmb29sIHByb29mKSBzbyB3b3VsZCBuZWVkDQpuZXcgbmFtZXMgc28gaXQgY291
bGQgY28tZXhpc3Qgd2l0aCB0aGUgZXhpc3RpbmcgY29kZSBzbyB0aGF0IHRoZQ0KY2hhbmdlcyBj
b3VsZCAncmlwcGxlIHRocm91Z2gnIHRoZSBzb3VyY2UgdHJlZSBpbnN0ZWFkIG9mIGFsbCBoYXZp
bmcgdG8NCmJlIG1hZGUgYXQgb25jZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

