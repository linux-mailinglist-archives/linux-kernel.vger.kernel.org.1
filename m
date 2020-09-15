Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C03B26A50B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:23:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbgIOMVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:21:08 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7D30C4CCB3DA760AA892;
        Tue, 15 Sep 2020 20:20:49 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 15 Sep 2020 20:20:48 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.250]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0487.000;
 Tue, 15 Sep 2020 20:20:46 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
Thread-Topic: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
Thread-Index: AQHWgEKzPOJD6Y0rEkK1BVb7XFEfA6lTNUwAgBZ+m2A=
Date:   Tue, 15 Sep 2020 12:20:45 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED4827837E@dggemm526-mbx.china.huawei.com>
References: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
 <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com>
In-Reply-To: <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDAxLCAyMDIwIDg6
NDcgUE0NCj4gVG86IFplbmd0YW8gKEIpDQo+IENjOiBUaG9tYXMgR2xlaXhuZXI7IFZpbmNlbnpv
IEZyYXNjaW5vOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHRpbWU6IEF2b2lkIHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4NCj4gdGltZXNwZWM2NF90
b19ucw0KPiANCj4gT24gVHVlLCBTZXAgMSwgMjAyMCBhdCAxMTozMiBBTSBaZW5nIFRhbyA8cHJp
bWUuemVuZ0BoaXNpbGljb24uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFNpbmNlIGNvbW1pdCBi
ZDQwYTE3NTc2OWQgKCJ5MjAzODogaXRpbWVyOiBjaGFuZ2UNCj4gaW1wbGVtZW50YXRpb24gdG8g
dGltZXNwZWM2NCIpDQo+ID4gd2UgaGF2ZSBicmVhayB0aGUgdGltZSBjbGFtcGluZyB3aGljaCBo
YW5kbGVzIHRoZSBwb3RlbnRpYWwNCj4gb3ZlcmZsb3cuDQo+IA0KPiBJbmRlZWQsIGdvb2QgY2F0
Y2ghDQo+IA0KPiBBbmQgSSBicm9rZSBpdCBkZXNwaXRlIHRoZSBjb21tZW50IHRlbGxpbmcgbWUg
YWJvdXQgdGhlIHByb2JsZW0uDQo+IA0KPiA+IEluIHRoaXMgcGF0Y2gsIHdlIGZpeCBpdCBpbiB0
aGUgdGltZXNwZWM2NF90b19ucyBiZWNhdXNlIHRoZXJlIGlzDQo+ID4gcG9zc2libGl0eSB0byBj
YXVzZSB0aGUgc2FtZSB1bmRlZmluZWQgYmVoYXZpb3VyIG9uIG92ZXJmbG93DQo+IHdoZW5ldmVy
DQo+ID4gdGhlIGZ1bmN0aW9uIGlzIGNhbGxlZC4NCj4gDQo+IEkgY2hlY2tlZCB0aGUgbW9zdCBp
bXBvcnRhbnQgY2FsbGVycyBvZiB0aGlzIGZ1bmN0aW9uLCBhbmQgSSBhZ3JlZQ0KPiB0aGF0IHRy
dW5jYXRpbmcgYXQgdGhlIG1heGltdW0gd291bGQgYmUgc2Vuc2libGUgaW4gbW9zdCBjYXNlcw0K
PiBoZXJlLg0KPiANCj4gSW4gdGltZWtlZXBpbmdfaW5pdCgpLCB0aGVyZSBpcyBhbHJlYWR5IGEg
Y2hlY2sgZm9yDQo+IHRpbWVzcGVjNjRfdmFsaWRfc2V0dG9kKCkgdGhhdCBsaW1pdHMgaXQgZXZl
biBmdXJ0aGVyLCBidXQgdGhhdA0KPiB3b3VsZG4ndCBtYWtlIHNlbnNlIGZvciBtb3N0IGNhbGxl
cnMuDQo+IA0KPiA+IEZpeGVzOiBiZDQwYTE3NTc2OWQgKCJ5MjAzODogaXRpbWVyOiBjaGFuZ2Ug
aW1wbGVtZW50YXRpb24gdG8NCj4gdGltZXNwZWM2NCIpDQo+IA0KPiBUaGlzIG9uZSBjYXVzZWQg
dGhlIHJlZ3Jlc3Npb24sIGJ1dCBpZiB3ZSBhZGQgdGhlIGNoZWNrIGhlcmUsIGl0DQo+IG1heSBi
ZSBiZXN0IHRvIGFsc28gYWRkIGl0IGluIHByaW9yIGtlcm5lbHMgdGhhdCBtYXkgaGF2ZSB0aGUg
c2FtZQ0KPiBidWcgaW4gb3RoZXIgY2FsbGVycyBvZiB0aGUgc2FtZSBmdW5jdGlvbi4gTWF5YmUg
YmFja3BvcnQgYWxsIHRoZQ0KPiB3YXkgdG8gc3RhYmxlIGtlcm5lbHMgdGhhdCBmaXJzdCBhZGRl
ZCB0aW1lc3BlYzY0Pw0KPiANCg0KSSB0aGluayB3ZSBuZWVkIHRvIGRvIHRoZSBiYWNrcG9ydCwg
YnV0IG5vdCBzdXJlIGFib3V0IHRoZSBzdGFydCBwb2ludA0KVGhhbmtzIGZvciB5b3VyIHJldmll
dy4gDQoNCj4gQ2MgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjMuMTcrDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFplbmcgVGFvIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+DQo+IA0KPiBS
ZXZpZXdlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg==
