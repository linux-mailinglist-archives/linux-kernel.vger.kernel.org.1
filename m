Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6AC2EBB9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAFJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:23:12 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4131 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:23:11 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D9kQB0fM5zXwM3;
        Wed,  6 Jan 2021 17:21:38 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 6 Jan 2021 17:22:27 +0800
Received: from DGGEML510-MBX.china.huawei.com ([169.254.2.253]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0487.000;
 Wed, 6 Jan 2021 17:22:18 +0800
From:   wanghuiqiang <wanghuiqiang@huawei.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "'Ard Biesheuvel'" <ardb@kernel.org>
CC:     'Marc Zyngier' <maz@kernel.org>,
        "'eric.auger@redhat.com'" <eric.auger@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0?=
 =?utf-8?Q?_for_GICv2_legacy_support?=
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwN3YOmayqAkS0a1b5qHlXVEh6ngmnQAgAABpXCAACfogIAABzIwgAA00gCAAnf7sIAUZQBAgCKuEbA=
Date:   Wed, 6 Jan 2021 09:22:18 +0000
Message-ID: <07084A11A8AB5A40A40B0218FE6F1CCA0F5B3322@dggeml510-mbx.china.huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
 <e93770e46c73413882584ebc3fe732e3@huawei.com>
 <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
 <931f76fa185e488fb9e942b2026ae7be@huawei.com>
 <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
In-Reply-To: <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.193.81]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJkIGFuZCBhbGwsDQoNClRoZSBpc3N1ZSBpcyByb290IGNhdXNlZCwgaXQgaXMgaW50cm9k
dWNlZCBieSBCSU9TIG5ldyBmZWF0dXJlIGltcGxlbWVudGVkLiANCldpdGggb2xkIEJJT1PvvIx3
ZSB1c2Ugc3RhdGljIE1BRFQgdGFibGUgYW5kIHRoZSBHSUNWL0dJQ0ggaXMgc2V0IHRvIDAgYW5k
IHJlcG9ydGVkIHRoaXMgdGFibGUgdG8gT1MuIEJ1dCB3ZSBhZGRlZCBuZXcgZmVhdHVyZXMgd2hp
Y2ggd2lsbCBkeW5hbWljIHVwZGF0ZSBNQURUIHRhYmxlIGJhc2VkIG9uIHNvbWUgZXh0ZXJuYWwg
aW5wdXQsIHRoZSBkZXZlbG9wZXIgaXMgc2V0IEdJQ1YvR0lDSCBhcyB3aGF0IHdlIGhhdmUgZG9u
ZSBsaWtlIHByZXZpb3VzIGdlbmVyYXRpb24gY2hpcHNldCBjb2RlIGRpZC4gQnV0IGluIGZhY3Qs
IHRoZXJlIGlzIGRpZmZlcmVudCBjb21wYXJlZCB3aXRoIG9sZCBnZW5lcmF0aW9uIGNoaXBzZXQg
Y29kZS4NCkknbGwgbGV0IG15IGludGVybmFsIHRlYW0ga25vdyB0aGlzIGFuZCBmaXggdGhpcyBp
c3N1ZSBpbiBsYXRlciBCSU9TIHJlbGVhc2UuDQoNClRoYW5rcyEgIA0KDQotLS0tLemCruS7tuWO
n+S7ti0tLS0tDQrlj5Hku7bkuro6IHdhbmdodWlxaWFuZyANCuWPkemAgeaXtumXtDogMjAyMOW5
tDEy5pyIMTXml6UgMTU6NDkNCuaUtuS7tuS6ujogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgQXJkIEJpZXNoZXV2ZWwgPGFy
ZGJAa2VybmVsLm9yZz4NCuaKhOmAgTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+DQrkuLvpopg6IOetlOWkjTogW1BB
VENIXSBpcnFjaGlwL2dpYy12MzogQ2hlY2sgU1JFIGJpdCBmb3IgR0lDdjIgbGVnYWN5IHN1cHBv
cnQNCg0KU29ycnkgcmVzcG9uc2UgbGF0ZS4NCkhpIFNoYW1lZXIgJiBBcmQsDQoNCkNvdWxkIHlv
dSBsZXQgbWUga25vdyB3aGljaCBmaXJtd2FyZSB5b3UgYXJlIHVzaW5nPyBJZiB0aGUgZGlmZmVy
ZW5jZSBpcyBNYWR0IHRhYmxlIHZHSUMgeW91ciBwb2ludGVkICwgdGhleSBhcmUgdGhlIHNhbWUu
IFdlIGNoYW5nZWQgdGhlIHZHSUMgbWVtb3J5IGJhc2UgYWRkcmVzcyBhdCB2ZXJ5IGVhcmx5IGRl
c2lnbiBzdGFnZS4NCg0KVGhhbmtz77yBIA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hk
u7bkuro6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCuWPkemAgeaXtumXtDogMjAyMOW5tDEy
5pyIMuaXpSAxNjoyMw0K5pS25Lu25Lq6OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3Jn
Pg0K5oqE6YCBOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgZXJpYy5hdWdlckByZWRo
YXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgd2FuZ2h1
aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdl
aS5jb20+DQrkuLvpopg6IFJFOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0
IGZvciBHSUN2MiBsZWdhY3kgc3VwcG9ydA0KDQpbK10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBBcmQgQmllc2hldXZlbCBbbWFpbHRvOmFyZGJAa2VybmVsLm9yZ10N
Cj4gU2VudDogMzAgTm92ZW1iZXIgMjAyMCAxODozMg0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogTWFy
YyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgDQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0IGZvciBHSUN2MiBsZWdhY3kg
DQo+IHN1cHBvcnQNCj4gDQouLi4NCg0KPiANCj4gQW55IGNsdWUgd2h5IHByb2R1Y3Rpb24gRDA2
IGZpcm13YXJlIGRldmlhdGVzIGZyb20gdGhlIEQwNiBwb3J0IHRoYXQgDQo+IGV4aXN0cyBpbiBU
aWFub2NvcmUncyBlZGsyLXBsYXRmb3JtcyByZXBvc2l0b3J5PyBCZWNhdXNlIHRoYXQgdmVyc2lv
biANCj4gZG9lcyBub3QgaGF2ZSB0aGlzIGJ1ZywgYW5kIEkgd29uZGVyIHdoeSB0aGF0IGNvZGUg
d2FzIHVwc3RyZWFtZWQgYXQgDQo+IGFsbCBpZiBhIHN1YnN0YW50aWFsbHkgZGlmZmVyZW50IHZl
cnNpb24gZ2V0cyBzaGlwcGVkIHdpdGggcHJvZHVjdGlvbiANCj4gaGFyZHdhcmUuDQoNCk9rLiBU
aGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIGhhdmUgaW5mb3JtZWQgb3VyIFVFRkkgdGVh
bSBhYm91dCB0aGlzLg0KVGhleSB3aWxsIGNoZWNrIEludGVybmFsbHkgYW5kIGNsYXJpZnkuDQoN
ClJlZ2FyZHMsDQpTaGFtZWVyDQo=
