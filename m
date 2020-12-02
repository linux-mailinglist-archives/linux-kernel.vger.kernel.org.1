Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965772CB700
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgLBIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:24:11 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2472 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLBIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:24:11 -0500
Received: from dggeme708-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CmBmj6qKqz51KT;
        Wed,  2 Dec 2020 16:23:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Dec 2020 16:23:26 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Wed, 2 Dec 2020 08:23:25 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwOHViTg3pRnhkK4BwcYBC9AoqngmnQAgAABpXCAACfogIAABzIwgAA00gCAAnf7sA==
Date:   Wed, 2 Dec 2020 08:23:25 +0000
Message-ID: <931f76fa185e488fb9e942b2026ae7be@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
 <e93770e46c73413882584ebc3fe732e3@huawei.com>
 <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
In-Reply-To: <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.131.207]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WytdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2
ZWwgW21haWx0bzphcmRiQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDMwIE5vdmVtYmVyIDIwMjAgMTg6
MzINCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBl
cmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTGludXhhcm0NCj4gPGxpbnV4YXJt
QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVj
ayBTUkUgYml0IGZvciBHSUN2MiBsZWdhY3kgc3VwcG9ydA0KPiANCi4uLg0KDQo+IA0KPiBBbnkg
Y2x1ZSB3aHkgcHJvZHVjdGlvbiBEMDYgZmlybXdhcmUgZGV2aWF0ZXMgZnJvbSB0aGUgRDA2IHBv
cnQgdGhhdA0KPiBleGlzdHMgaW4gVGlhbm9jb3JlJ3MgZWRrMi1wbGF0Zm9ybXMgcmVwb3NpdG9y
eT8gQmVjYXVzZSB0aGF0IHZlcnNpb24NCj4gZG9lcyBub3QgaGF2ZSB0aGlzIGJ1ZywgYW5kIEkg
d29uZGVyIHdoeSB0aGF0IGNvZGUgd2FzIHVwc3RyZWFtZWQgYXQNCj4gYWxsIGlmIGEgc3Vic3Rh
bnRpYWxseSBkaWZmZXJlbnQgdmVyc2lvbiBnZXRzIHNoaXBwZWQgd2l0aCBwcm9kdWN0aW9uDQo+
IGhhcmR3YXJlLg0KDQpPay4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gSSBoYXZlIGlu
Zm9ybWVkIG91ciBVRUZJIHRlYW0gYWJvdXQgdGhpcy4NClRoZXkgd2lsbCBjaGVjayBJbnRlcm5h
bGx5IGFuZCBjbGFyaWZ5Lg0KDQpSZWdhcmRzLA0KU2hhbWVlcg0K
