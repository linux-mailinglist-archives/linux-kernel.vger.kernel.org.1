Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B912C27FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgKXNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:32:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23032 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388349AbgKXNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:31:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-268-_XpbmZMuMe6EpfsWNrm87w-1; Tue, 24 Nov 2020 13:31:55 +0000
X-MC-Unique: _XpbmZMuMe6EpfsWNrm87w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 13:31:49 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 13:31:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Jann Horn <jannh@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] zlib: define get_unaligned16() only when used
Thread-Topic: [PATCH] zlib: define get_unaligned16() only when used
Thread-Index: AQHWwllpnHAMCQpgAEWSudK6othSeqnXR0Dg
Date:   Tue, 24 Nov 2020 13:31:49 +0000
Message-ID: <9e4edaa0061c4de2b3b1a7aa53987b94@AcuMS.aculab.com>
References: <20201124104030.903-1-lukas.bulwahn@gmail.com>
 <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
 <20201124115058.GA32060@infradead.org>
 <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
In-Reply-To: <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyNCBOb3ZlbWJlciAyMDIwIDExOjU3DQo+IA0K
PiBPbiBUdWUsIE5vdiAyNCwgMjAyMCBhdCAxMjo1MSBQTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDEyOjA4
OjQwUE0gKzAxMDAsIEphbm4gSG9ybiB3cm90ZToNCj4gPiA+ID4gU2luY2UgY29tbWl0IGFjYWFi
NzMzNWJkNiAoImxpYi96bGliOiByZW1vdmUgb3V0ZGF0ZWQgYW5kIGluY29ycmVjdA0KPiA+ID4g
PiBwcmUtaW5jcmVtZW50IG9wdGltaXphdGlvbiIpLCBnZXRfdW5hbGlnbmVkMTYoKSBpcyBvbmx5
IHVzZWQgd2hlbg0KPiA+ID4gPiAhQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NF
U1MuDQo+ID4gPiA+DQo+ID4gPiA+IEhlbmNlLCBtYWtlIENDPWNsYW5nIFc9MSB3YXJuczoNCj4g
PiA+ID4NCj4gPiA+ID4gICBsaWIvemxpYl9pbmZsYXRlL2luZmZhc3QuYzoyMDoxOg0KPiA+ID4g
PiAgICAgd2FybmluZzogdW51c2VkIGZ1bmN0aW9uICdnZXRfdW5hbGlnbmVkMTYnIFstV3VudXNl
ZC1mdW5jdGlvbl0NCj4gPiA+ID4NCj4gPiA+ID4gRGVmaW5lIGdldF91bmFsaWduZWQxNigpIG9u
bHkgd2hlbiBpdCBpcyBhY3R1YWxseSB1c2VkLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCj4gPiA+DQo+ID4g
PiBBRkFJQ1MgYSBuaWNlciBvcHRpb24gd291bGQgYmUgdG8gIiNpbmNsdWRlIDxhc20vdW5hbGln
bmVkLmg+IiBhbmQNCj4gPiA+IHRoZW4gdXNlICJnZXRfdW5hbGlnbmVkIiwgd2hpY2ggc2hvdWxk
IGF1dG9tYXRpY2FsbHkgZG8gdGhlIHJpZ2h0DQo+ID4gPiB0aGluZyBldmVyeXdoZXJlIGFuZCBy
ZW1vdmUgdGhlIG5lZWQgZm9yIGRlZmluaW5nIGdldF91bmFsaWduZWQxNigpDQo+ID4gPiBhbmQg
Y2hlY2tpbmcgQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1MgZW50aXJlbHk/
DQo+ID4NCj4gPiBZZXMsIHRoYXQgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLg0KPiANCj4gSXQn
cyBwb3NzaWJsZSB0aGF0IHRoaXMgZGlkbid0IHdvcmsgd2hlbiB0aGUgY29kZSB3YXMgb3JpZ2lu
YWxseSBhZGRlZDoNCj4gVGhlIGRlY29tcHJlc3NvciBmdW5jdGlvbnMgYXJlIGNhbGxlZCBmcm9t
IHRoZSBjb21wcmVzc2VkIGJvb3QgcGF0aCwNCj4gd2hpY2ggaXMgYSBiaXQgbGltaXRlZCByZWdh
cmRpbmcgd2hpY2ggaGVhZGVycyBpdCBjYW4gaW5jbHVkZSwgYXQgbGVhc3QNCj4gb24gc29tZSBh
cmNoaXRlY3R1cmVzLg0KPiANCj4gSSB3b3VsZCByZWNvbW1lbmQgdGVzdC1idWlsZGluZyB0aGlz
IGZvciBhbGwgYXJjaGl0ZWN0dXJlcyB0aGF0IGluY2x1ZGUNCj4gLi4vLi4vLi4vLi4vbGliL2Rl
Y29tcHJlc3NfaW5mbGF0ZS5jIGZyb20gdGhlaXIgYm9vdCBjb2RlLg0KDQpQbGF1c2libHkgaXQg
Y291bGQgaW5jbHVkZSBhIGRpZmZlcmVudCBoZWFkZXIgdGhhdCBkZWZpbmVkIHRoZSByZXF1aXJl
ZA0KaXRlbXMgZm9yIHRob3NlIGJ1aWxkcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

