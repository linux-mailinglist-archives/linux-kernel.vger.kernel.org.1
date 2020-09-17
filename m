Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0526D15E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIQC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:59:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIQC7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:59:38 -0400
X-Greylist: delayed 959 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:59:38 EDT
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 35ECDF0861DC7A368510;
        Thu, 17 Sep 2020 10:43:36 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.250]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0487.000;
 Thu, 17 Sep 2020 10:43:35 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
Thread-Topic: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
Thread-Index: AQHWgEKzPOJD6Y0rEkK1BVb7XFEfA6lTNUwAgBZ+m2D//4GbAIADAGmA
Date:   Thu, 17 Sep 2020 02:43:34 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED4827C527@dggemm526-mbx.china.huawei.com>
References: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
 <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com>
 <678F3D1BB717D949B966B68EAEB446ED4827837E@dggemm526-mbx.china.huawei.com>
 <CAK8P3a2WG0DvTyrTkiLg3GW1x2s-oo8BgAyvp7uHvzXhJCiHmQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2WG0DvTyrTkiLg3GW1x2s-oo8BgAyvp7uHvzXhJCiHmQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE1LCAyMDIwIDg6
NDUgUE0NCj4gVG86IFplbmd0YW8gKEIpDQo+IENjOiBUaG9tYXMgR2xlaXhuZXI7IFZpbmNlbnpv
IEZyYXNjaW5vOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHRpbWU6IEF2b2lkIHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4NCj4gdGltZXNwZWM2NF90
b19ucw0KPiANCj4gT24gVHVlLCBTZXAgMTUsIDIwMjAgYXQgMjoyMCBQTSBaZW5ndGFvIChCKQ0K
PiA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPiB3cm90ZToNCj4gDQo+ID4gPiA+IEZpeGVzOiBi
ZDQwYTE3NTc2OWQgKCJ5MjAzODogaXRpbWVyOiBjaGFuZ2UgaW1wbGVtZW50YXRpb24gdG8NCj4g
PiA+IHRpbWVzcGVjNjQiKQ0KPiA+ID4NCj4gPiA+IFRoaXMgb25lIGNhdXNlZCB0aGUgcmVncmVz
c2lvbiwgYnV0IGlmIHdlIGFkZCB0aGUgY2hlY2sgaGVyZSwgaXQNCj4gPiA+IG1heSBiZSBiZXN0
IHRvIGFsc28gYWRkIGl0IGluIHByaW9yIGtlcm5lbHMgdGhhdCBtYXkgaGF2ZSB0aGUgc2FtZQ0K
PiA+ID4gYnVnIGluIG90aGVyIGNhbGxlcnMgb2YgdGhlIHNhbWUgZnVuY3Rpb24uIE1heWJlIGJh
Y2twb3J0IGFsbCB0aGUNCj4gPiA+IHdheSB0byBzdGFibGUga2VybmVscyB0aGF0IGZpcnN0IGFk
ZGVkIHRpbWVzcGVjNjQ/DQo+ID4gPg0KPiA+DQo+ID4gSSB0aGluayB3ZSBuZWVkIHRvIGRvIHRo
ZSBiYWNrcG9ydCwgYnV0IG5vdCBzdXJlIGFib3V0IHRoZSBzdGFydA0KPiBwb2ludA0KPiA+IFRo
YW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QNCj4gDQo+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2My4xNysNCj4gRml4ZXM6IDM2MWEzYmYwMDU4MiAo
InRpbWU2NDogQWRkIHRpbWU2NC5oIGhlYWRlciBhbmQgZGVmaW5lDQo+IHN0cnVjdCB0aW1lc3Bl
YzY0IikNCg0KWWVzLCBtYWtlIHNlbnNlLCBjb21taXQgMzYxYTNiZjAwNTgyIGludHJvZHVjZSBh
IHBvdGVudGlhbCBpc3N1ZSBhbmQNCiBjb21taXQgYmQ0MGExNzU3NjlkIHRyaWdnZXIgdGhlIGlz
c3VlLg0KDQpSZWdhcmRzDQpaZW5ndGFvIA0KDQo+IA0KPiAgICAgICAgQXJuZA0K
