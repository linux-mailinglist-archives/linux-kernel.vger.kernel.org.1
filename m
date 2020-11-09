Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C62AB4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgKIKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:20:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:38782 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKIKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:20:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-10-XZAXvoEFPDKb1gXlYxr8Tw-1; Mon, 09 Nov 2020 10:20:42 +0000
X-MC-Unique: XZAXvoEFPDKb1gXlYxr8Tw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Nov 2020 10:20:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Nov 2020 10:20:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Thread-Topic: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Thread-Index: AQHWtEop3jxJkxOklE2QZhVf8THkOKm7O4LggARczO6AAAEKwA==
Date:   Mon, 9 Nov 2020 10:20:42 +0000
Message-ID: <88282a0514984e2b943628f1476c3bbd@AcuMS.aculab.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
 <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
In-Reply-To: <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
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

RnJvbTogQW5keSBTaGV2Y2hlbmtvIA0KPiBTZW50OiAwOSBOb3ZlbWJlciAyMDIwIDEwOjEwDQo+
IA0KPiBPbiBNb24sIE5vdiA5LCAyMDIwIGF0IDExOjU3IEFNIEppcmkgU2xhYnkgPGppcmlzbGFi
eUBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiBPbiAwNi4gMTEuIDIwLCAxNzowNiwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBOb3YgNiwgMjAyMCBhdCA1OjM1IFBNIERhdmlk
IExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4+IEZyb206IEFu
ZHkgU2hldmNoZW5rbw0KPiA+ID4+PiBTZW50OiAwNiBOb3ZlbWJlciAyMDIwIDE0OjM2DQo+ID4g
Pj4+DQo+ID4gPj4+IFRoZXJlIGFyZSBmZXcgcGxhY2VzIHdoZW4gR0VOTUFTSygpIG9yIEJJVCgp
IG1hY3JvIGlzIHN1aXRhYmxlIGFuZCBtYWtlcyBjb2RlDQo+ID4gPj4+IGVhc2llciB0byB1bmRl
cnN0YW5kLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBteSBhbnN3ZXJzIGJlbG93Lg0K
PiANCj4gPiA+PiAuLi4NCj4gPiA+Pj4gLSAgICAgaWYgKChkICYgfjB4ZmYpID09IEJSTF9VQ19S
T1cpIHsNCj4gPiA+Pj4gLSAgICAgICAgICAgICBpZiAoKGNoICYgfjB4ZmYpID09IEJSTF9VQ19S
T1cpDQo+ID4gPj4+ICsgICAgIGlmICgoZCAmIH5HRU5NQVNLKDcsIDApKSA9PSBCUkxfVUNfUk9X
KSB7DQo+ID4gPj4+ICsgICAgICAgICAgICAgaWYgKChjaCAmIH5HRU5NQVNLKDcsIDApKSA9PSBC
UkxfVUNfUk9XKQ0KPiA+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBkIHwgY2g7
DQo+ID4gPj4NCj4gPiA+PiBEbyB5b3UgcmVhbGx5IHRoaW5rIHRoYXQgbWFrZXMgaXQgbW9yZSBy
ZWFkYWJsZT8NCj4gPiA+DQo+ID4gPiBZZXMuIEJlY2F1c2UgdGhpcyB0ZWxscyBleHBsaWNpdGx5
IGhvdyBtYW55IGJpdHMgYXJlIHVzZWQgZm9yIG1ldGFkYXRhDQo+ID4gPiB2cy4gZGF0YS4NCj4g
Pg0KPiA+IE5vLCBiZWNhdXNlIH4weGZmIGlzIGNsZWFybHkgd2hhdCBpdCBpcy4gR0VOTUFTSyg3
LCAwKSBpczoNCj4gPiAxKSBsb25nZXIgdG8gcmVhZCAmIHBhcnNlIGJ5IGJyYWluIHdpdGggcmVz
dWx0OiAiR0VOTUFTSyB1bmRlZmluZWQiDQo+ID4gMikgdGVycmlibGUgaW4gdGhpcyBwYXJ0aWN1
bGFyIHVzZSBjYXNlDQo+IA0KPiBNYXliZSAjZGVmaW5lIHdpdGggYSBwcm9wZXIgbmFtZSBjYW4g
YnJpbmcgc29tZSBzaGVkIG9mIGxpZ2h0IGhlcmU/DQoNClBvc3NpYmx5Lg0KDQo+ID4gQW5vdGhl
ciBpbnN0YW5jZSBvZiBhbiBldmVuIHdvcnNlIHN3aXRjaDoNCj4gPiAtICAgICAgICAgICAgICAg
aWYgKGFyZyAmIH4weDc3KQ0KPiA+ICsgICAgICAgICAgICAgICBpZiAoYXJnICYgfihHRU5NQVNL
KDYsIDQpIHwgR0VOTUFTSygyLCAwKSkpDQo+IA0KPiBJdCBleGFjdGx5IHNob3dzIHdoYXQgYml0
cyB3ZSBhcmUgYWNjZXB0aW5nIGFuZCB3aGF0IGFyZSBub3QuIDB4NzcgeW91DQo+IG5lZWQgdG8g
dHJhbnNsYXRlIHRvIHRoZSBiaXRtYXAgYW5kIHRoZW4gZmlndXJlIG91dCB0aGUgYml0IG51bWJl
cnMuDQo+IFRoaXMgaXMgZXJyb3IgcHJvbmUgYXMgc2hvd24gaW4gc29tZSBjYXNlcy4NCg0KV2Ug
YWxsIGtub3cgd2hhdCAweGZmIGFuZCAweDc3IG1lYW4uDQpJdCBpcyBpbmdyYWluZWQgZnJvbSB5
ZWFycyBvZiB3cml0aW5nIHNvZnR3YXJlLg0KDQpOb3cgaXQgbWF5IGJlIHRoYXQgdGhlIDB4Nzcg
aXMgcmVsYXRlZCB0byBtYXNraW5nIG9mZg0Kc29tZSBvdGhlciBiaXQgdmFsdWVzLg0KSW4gdGhh
dCBjYXNlIHlvdSBjb3VsZCBoYXZlIGEgbmFtZWQgY29uc3RhbnQgYmFzZWQgb24gdGhlDQpuYW1l
cyBvZiB0aGUgb3RoZXIgYml0IHZhbHVlcy4NCkJ1dCBpZiB5b3UgYXJlIHB1dHRpbmcgaW4gc2lt
cGxlIGNvbnN0YW50cyB0aGVyZSBpcyBub3RoaW5nDQp3cm9uZyB3aXRoIGhleC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

