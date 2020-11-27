Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9A92C63E4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK0LZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:25:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28591 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgK0LZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:25:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-260-gbkyh3AuOmu58dLY9RyzNg-1; Fri, 27 Nov 2020 11:25:54 +0000
X-MC-Unique: gbkyh3AuOmu58dLY9RyzNg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 27 Nov 2020 11:25:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 27 Nov 2020 11:25:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Cooper' <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
Thread-Topic: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
Thread-Index: AQHWxE+DFGTCNd4wOUqkA7q3pMvz06nb06qg
Date:   Fri, 27 Nov 2020 11:25:53 +0000
Message-ID: <b4d2750b3d094aac858118aef611a135@AcuMS.aculab.com>
References: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
 <947b02eb-536f-16a0-fbb1-87b62ab8c13e@citrix.com>
 <CAKXUXMybmC=JE3uDnekAuHfRUZcrzSLJ04xB3nR=3BqHCsNVqA@mail.gmail.com>
 <CALCETrUyoaJyJ8mGpq9bdanKKfHgjg_1B=N0rtmuHCmCP9Q9=g@mail.gmail.com>
 <3d9f41b1-9687-4aae-ad7d-2e38a33132ba@citrix.com>
In-Reply-To: <3d9f41b1-9687-4aae-ad7d-2e38a33132ba@citrix.com>
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

RnJvbTogQW5kcmV3IENvb3Blcg0KPiBTZW50OiAyNiBOb3ZlbWJlciAyMDIwIDIzOjUyDQo+IA0K
PiBPbiAyNi8xMS8yMDIwIDE5OjE1LCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+ID4gT24gVGh1
LCBOb3YgMjYsIDIwMjAgYXQgMTE6MDcgQU0gTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiBUaHUsIE5vdiAyNiwgMjAyMCBhdCA2OjE2IFBNIEFu
ZHJldyBDb29wZXIgPGFuZHJldy5jb29wZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPiA+Pj4gT24g
MjYvMTEvMjAyMCAxMTo1NCwgTHVrYXMgQnVsd2FobiB3cm90ZToNCj4gPj4+PiBDb21taXQgMWU1
ZGUxODI3OGU2ICgieDg2OiBJbnRyb2R1Y2UgR0RUX0VOVFJZX0lOSVQoKSIpIHVuaW50ZW50aW9u
YWxseQ0KPiA+Pj4+IHRyYW5zZm9ybWVkIGEgZmV3IDB4ZmZmZiB2YWx1ZXMgdG8gMHhmZmZmZiAo
bm90ZTogZml2ZSB0aW1lcyAiZiIgaW5zdGVhZCBvZg0KPiA+Pj4+IGZvdXIpIGFzIHBhcnQgb2Yg
dGhlIHJlZmFjdG9yaW5nLg0KPiA+Pj4gVGhlIHRyYW5zZm9ybWF0aW9uIGluIHRoYXQgY2hhbmdl
IGlzIGNvcnJlY3QuDQo+ID4+Pg0KPiA+Pj4gU2VnbWVudCBiYXNlcyBhcmUgMjAgYml0cyB3aWRl
IGluIHg4NiwNCj4gDQo+IEkgb2YgY291cnNlIG1lYW50IHNlZ21lbnQgbGltaXRzIGhlcmUsIHJh
dGhlciB0aGFuIGJhc2VzLg0KPiANCj4gPj4+IERvZXM6DQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Rlc2NfZGVmcy5oDQo+ID4+PiBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2Rlc2NfZGVmcy5oDQo+ID4+PiBpbmRleCBmN2U3MDk5YWY1OTUuLjk1NjFmM2M2
NmU5ZSAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Rlc2NfZGVmcy5o
DQo+ID4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kZXNjX2RlZnMuaA0KPiA+Pj4gQEAg
LTIyLDcgKzIyLDcgQEAgc3RydWN0IGRlc2Nfc3RydWN0IHsNCj4gPj4+DQo+ID4+PiAgI2RlZmlu
ZSBHRFRfRU5UUllfSU5JVChmbGFncywgYmFzZSwgbGltaXQpICAgICAgICAgICAgICAgICAgICAg
XA0KPiA+Pj4gICAgICAgICB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4gPj4+IC0gICAgICAgICAgICAgICAubGltaXQwICAgICAgICAg
PSAodTE2KSAobGltaXQpLCAgICAgICAgICAgICAgICBcDQo+ID4+PiArICAgICAgICAgICAgICAg
LmxpbWl0MCAgICAgICAgID0gKHUxNikgKGxpbWl0KSAmIDB4RkZGRiwgICAgICAgXA0KPiA+Pj4g
ICAgICAgICAgICAgICAgIC5saW1pdDEgICAgICAgICA9ICgobGltaXQpID4+IDE2KSAmIDB4MEYs
ICAgICAgIFwNCj4gPj4+ICAgICAgICAgICAgICAgICAuYmFzZTAgICAgICAgICAgPSAodTE2KSAo
YmFzZSksICAgICAgICAgICAgICAgICBcDQo+ID4+PiAgICAgICAgICAgICAgICAgLmJhc2UxICAg
ICAgICAgID0gKChiYXNlKSA+PiAxNikgJiAweEZGLCAgICAgICAgXA0KPiA+Pj4NCj4gPj4+IGZp
eCB0aGUgd2FybmluZz8NCj4gPj4+DQo+ID4+IFRoYW5rcywgSSB3aWxsIHRyeSB0aGF0IG91dCwg
YW5kIHRyeSBjb21waWxpbmcgYSAzMi1iaXQga2VybmVsIGFzIHdlbGwuDQo+ID4gWW91IHNob3Vs
ZCBhbHNvIHRyeSBjb21wYXJpbmcgdGhlIG9iamR1bXAgb3V0cHV0IGJlZm9yZSBhbmQgYWZ0ZXIg
eW91cg0KPiA+IHBhdGNoLiAgb2JqZHVtcCAtRCB3aWxsIHByb2R1Y2UgYml6YXJyZSBvdXRwdXQg
YnV0IHNob3VsZCB3b3JrLg0KPiANCj4gRXhwYW5kaW5nIG9uIHRoaXMgYSBsaXR0bGUsIGlmIHRo
YXQgZG9lcyBpbmRlZWQgZml4IHRoZSBzcGFyc2Ugd2FybmluZywNCj4gdGhlbiBJJ2QgbWFrZSBh
biBhcmd1bWVudCBmb3IgdGhpcyBiZWluZyBhIGJ1ZyBpbiBzcGFyc2UuwqAgRXhwbGljaXRseQ0K
PiBjYXN0aW5nIHRvIHUxNiBpcyBzZW1hbnRpY2FsbHkgYW5kIGludGVudGlvbmFsbHkgaWRlbnRp
Y2FsIHRvICYgMHhmZmZmLg0KDQpFdmVuIHRoZSAodTE2KSBjYXN0IGlzIHBvaW50bGVzcy4NCkkg
ZG9uJ3QgdGhpbmsgdGhlIGN1cnJlbnQgdmVyc2lvbnMgb2YgZ2NjIGFyZSBhcyBzdHVwaWQgYXMg
b2xkIG9uZXMsDQpidXQgSSBoYXZlIHNlZW46DQoJKmNwID0gKGNoYXIpKHggJiAweGZmKTsNCmdl
bmVyYXRlIGNvZGUgdGhhdCBtYXNrcyB3aXRoIDB4ZmYsIG1hc2tzIHdpdGggMHhmZiBhZ2FpbiwN
CmFuZCB0aGVuIGRvZXMgYSBieXRlIHN0b3JlLg0KDQpJIGhhdmUgYSBzdHJvbmcgZGlzbGlrZSBv
ZiB0aGUgdXNlIG9mIGludGVnZXIgY2FzdHMgdG8gc2lsZW5jZQ0KY29tcGlsZXIgd2FybmluZ3Mu
DQpDYXN0cyBzaG91bGQgYmUgcmFyZSBiZWNhdXNlIHRoZXkgY2FuIGhpZGUgdmVyeSBuYXN0eSBi
dWdzLg0KQWx0aG91Z2ggdGhlICdwb2ludGVyIHRvIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUn
IHdhcm5pbmcNCmRvZXMgcGljayB1cCBtb3N0IG9mIHRoZSBiYWQgb25lcy4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

