Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E418297D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762471AbgJXQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:58:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22944 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762464AbgJXQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:58:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-22-YOgp6WC1NdimiQHmmRzXug-1; Sat, 24 Oct 2020 17:58:26 +0100
X-MC-Unique: YOgp6WC1NdimiQHmmRzXug-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 24 Oct 2020 17:58:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 24 Oct 2020 17:58:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Peter Anvin' <hpa@zytor.com>
CC:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'the arch/x86 maintainers' <x86@kernel.org>,
        "'Sean Christopherson'" <sean.j.christopherson@intel.com>,
        'Naresh Kamboju' <naresh.kamboju@linaro.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/uaccess: fix code generation in put_user()
Thread-Topic: [PATCH] x86/uaccess: fix code generation in put_user()
Thread-Index: AQHWqYEb2jCDJax3wEWt3nUPTzGU4qmluWiggAE71BA=
Date:   Sat, 24 Oct 2020 16:58:25 +0000
Message-ID: <1eaa025ba7104edd815c9ac66d5790e4@AcuMS.aculab.com>
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
 <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
 <8820745F-E761-42E6-8A70-7B04EE70692C@zytor.com>
 <CAHk-=wg9L3EZk=cBjt5R3LkE8Y6swwOZ8sxhpQYcJO3Fj1wLbQ@mail.gmail.com>
 <bca28d6e33a3475193478e762214c6ea@AcuMS.aculab.com>
In-Reply-To: <bca28d6e33a3475193478e762214c6ea@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDIzIE9jdG9iZXIgMjAyMCAyMjo1Mg0KLi4uDQo+
IENvdWxkIGRvX3B1dF91c2VyKCkgZG8gYW4gaW5pdGlhbCBjaGVjayBmb3IgNjQgYml0DQo+IHRo
ZW4gZXhwYW5kIGEgZGlmZmVyZW50ICNkZWZpbmUgdGhhdCBjb250YWlucyB0aGUgYWN0dWFsDQo+
IGNvZGUgcGFzc2luZyBlaXRoZXIgImEiIG9yICJBIiBmb3IgdGhlIGNvbnN0cmlhbnQuDQo+IA0K
PiBBcGFydCBmcm9tIGFub3RoZXIgbGV2ZWwgb2YgaW5kaXJlY3Rpb24gbm90aGluZyBpcyBkdXBs
aWNhdGVkLg0KDQpUaGlzIGNvZGUgc2VlbXMgdG8gY29tcGlsZSB0byBzb21ldGhpbmcgc2Vuc2li
bGUuDQpJdCBkb2VzIG5lZWQgY2hhbmdlIHRoZSByZWdpc3RlcnMgdGhhdCBnZXRfdXNlcl9uKCkg
bXVzdA0KdXNlIC0gdGhlIG5vcm1hbCByZXR1cm4gdmFsdWUgaXMgbm93IGluICVheCAoYW5kICVk
eCBmb3INCjY0Yml0IHZhbHVlcyBvbiAzMmJpdCBzeXN0ZW1zLCB3aXRoIHRoZSBlcnJvciBpbiAl
Y3guDQooSSd2ZSBub3QgYWN0dWFsbHkgdGVzdGVkIGl0LikNCg0KI2RlZmluZSBfX2ludHR5cGVf
bWF4KHgsIF9tYXgpIF9fdHlwZW9mX18oICAgICAgXA0KICAgICAgICBfX3R5cGVmaXRzKHgsY2hh
ciwgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgIF9fdHlwZWZpdHMoeCxzaG9ydCwg
ICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgX190eXBlZml0cyh4LGludCwgICAgICAg
ICAgICAgICAgICAgXA0KICAgICAgICAgICAgICBfX3R5cGVmaXRzKHgsbG9uZyxfbWF4KSkpKSkN
Cg0KI2RlZmluZSBfX2ludHR5cGUoeCkgX19pbnR0eXBlX21heCh4LCAwVUxMKQ0KDQojZGVmaW5l
IGdldF91c2VyXzEoeCwgcHRyLCB0eXBlLCBjb25zdHJhaW50KSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQooeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIGludCBfX3JldF9ndTsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIHR5
cGUgX192YWxfZ3U7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQogICAgICAgIGFzbSB2b2xhdGlsZSgiY2FsbCBfX2dldF91c2VyXyVQNCIgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAgICAgICA6ICI9YyIgKF9f
cmV0X2d1KSwgY29uc3RyYWludCAoX192YWxfZ3UpLCAgICAgICAgICBcDQogICAgICAgICAgICAg
ICAgICAgICAgICBBU01fQ0FMTF9DT05TVFJBSU5UICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQogICAgICAgICAgICAgICAgICAgICA6ICJhIiAocHRyKSwgImkiIChzaXplb2YoKihwdHIp
KSkpOyAgICAgICAgICAgICAgICBcDQogICAgICAgICh4KSA9IChfX2ZvcmNlIF9fdHlwZW9mX18o
KihwdHIpKSkgX192YWxfZ3U7ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIF9fYnVpbHRp
bl9leHBlY3QoX19yZXRfZ3UsIDApOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQp9KQ0KDQojZGVmaW5lIGdldF91c2VyKHgsIHB0cikgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQooeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIF9fY2hr
X3VzZXJfcHRyKHB0cik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQogICAgICAgIG1pZ2h0X2ZhdWx0KCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIChzaXplb2YgKihwdHIpID4gc2l6ZW9mKGxv
bmcpKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAgICAgICAg
PyBnZXRfdXNlcl8xKHgsIHB0ciwgbG9uZyBsb25nLCAiPUEiKSAgICAgICAgICAgICAgICAgICBc
DQogICAgICAgICAgICAgICAgOiBnZXRfdXNlcl8xKHgsIHB0ciwgX19pbnR0eXBlX21heCgqKHB0
ciksMHVsKSwgIj1hIik7ICBcDQp9KQ0KDQpUaGUgX19pbnR0eXBlX21heCgpIGlzIG5lZWRlZCAo
SSB0aGluaykgYmVjYXVzZSBjbGFuZyB3aWxsIHRyeSAoYW5kIGZhaWwpDQp0byBnZW5lcmF0ZSB0
aGUgYXNtIGZvciA2NGJpdCB2YWx1ZXMgb24gMzJiaXQgc3lzdGVtcy4NClNvIHRoZSB0eXBlIG5l
ZWRzIGxpbWl0aW5nIHRvIDMyYml0cy4NCkFsd2F5cyB1c2luZyAnbG9uZycgd29ya3MgLSBidXQg
Z2VuZXJhdGVzIGV4dHJhIGNhc3RzLg0KDQpUaGUgIj1BIiBjb25zdHJhaW50ICglcmF4IG9yICVy
ZHgpIGlzIG5ldmVyIHVzZWQgb24gNjRiaXQgYmVjYXVzZQ0KdGhlIHRlc3QgaXMgYWx3YXlzIGZh
bHNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

