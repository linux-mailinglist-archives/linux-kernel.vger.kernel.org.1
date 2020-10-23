Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056E29791C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756950AbgJWVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:52:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39695 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756849AbgJWVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:52:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-12-QwgdOorUNLe2Ru_w3N1p4w-1; Fri, 23 Oct 2020 22:52:17 +0100
X-MC-Unique: QwgdOorUNLe2Ru_w3N1p4w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 23 Oct 2020 22:52:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Oct 2020 22:52:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/uaccess: fix code generation in put_user()
Thread-Topic: [PATCH] x86/uaccess: fix code generation in put_user()
Thread-Index: AQHWqYEb2jCDJax3wEWt3nUPTzGU4qmluWig
Date:   Fri, 23 Oct 2020 21:52:16 +0000
Message-ID: <bca28d6e33a3475193478e762214c6ea@AcuMS.aculab.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
 <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
 <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com>
 <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgT2N0b2JlciAyMDIwIDIyOjExDQo+IA0K
PiBPbiBGcmksIE9jdCAyMywgMjAyMCBhdCAyOjAwIFBNIDxocGFAenl0b3IuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFRoZXJlIGlzIG5vIHNhbWUgcmVhc29uIHRvIG1lc3MgYXJvdW5kIHdpdGggaGFj
a3Mgd2hlbiB3ZSBhcmUgdGFsa2luZyBhYm91dCBkeDpheCwgdGhvdWdoLg0KPiANCj4gU3VyZSB0
aGVyZSBpcy4NCj4gDQo+ICJBIiBkb2Vzbid0IGFjdHVhbGx5IG1lYW4gJWVkeDolZWF4IGxpa2Ug
eW91IHNlZW0gdG8gdGhpbmsuDQo+IA0KPiBJdCBhY3R1YWxseSBtZWFucyAlZWF4IE9SICVlZHgs
IGFuZCB0aGVuIGlmIGdpdmVuIGEgNjQtYml0IHZhbHVlLCBpdA0KPiB3aWxsIHVzZSB0aGUgY29t
YmluYXRpb24gKHdpdGggJWVkeCBiZWluZyB0aGUgaGlnaCBiaXRzKS4NCj4gDQo+IFNvIHVzaW5n
ICJBIiB1bmNvbmRpdGlvbmFsbHkgZG9lc24ndCB3b3JrIC0gaXQgZ2l2ZXMgcmFuZG9tIGJlaGF2
aW9yDQo+IGZvciAzMi1iaXQgKG9yIHNtYWxsZXIpIHR5cGVzLg0KPiANCj4gT3IgeW91J2QgaGF2
ZSB0byBjYXN0IHRoZSB2YWx1ZSB0byBhbHdheXMgYmUgNjQtYml0LCBhbmQgaGF2ZSB0aGUNCj4g
ZXh0cmEgY29kZSBnZW5lcmF0aW9uLg0KPiANCj4gSU9XLCBhbiB1bmNvbmRpdGlvbmFsICJBIiBp
cyB3cm9uZy4NCj4gDQo+IEFuZCB0aGUgYWx0ZXJuYXRpdmUgaXMgdG8ganVzdCBkdXBsaWNhdGUg
dGhpbmdzLCBhbmQgZ28gYmFjayB0byB0aGUNCj4gZXhwbGljaXQgc2l6ZSB0ZXN0aW5nLCBidXQg
aG9uZXN0bHksIEkgcmVhbGx5IHRoaW5rIHRoYXQncyBtdWNoIHdvcnNlDQo+IHRoYW4gcmVseWlu
ZyBvbiBhIGRvY3VtZW50ZWQgZmVhdHVyZSBvZiAicmVnaXN0ZXIgYXNtKCkiIHRoYXQgZ2NjDQo+
IF9kb2N1bWVudHNfIGlzIGZvciB0aGlzIGtpbmQgb2YgaW5saW5lIGFzbSB1c2UuDQoNCkNvdWxk
IGRvX3B1dF91c2VyKCkgZG8gYW4gaW5pdGlhbCBjaGVjayBmb3IgNjQgYml0DQp0aGVuIGV4cGFu
ZCBhIGRpZmZlcmVudCAjZGVmaW5lIHRoYXQgY29udGFpbnMgdGhlIGFjdHVhbA0KY29kZSBwYXNz
aW5nIGVpdGhlciAiYSIgb3IgIkEiIGZvciB0aGUgY29uc3RyaWFudC4NCg0KQXBhcnQgZnJvbSBh
bm90aGVyIGxldmVsIG9mIGluZGlyZWN0aW9uIG5vdGhpbmcgaXMgZHVwbGljYXRlZC4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

