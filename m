Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187092DAA90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgLOKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:02:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2480 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLOKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:01:43 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CwDJz25x2z52vS;
        Tue, 15 Dec 2020 18:00:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 15 Dec 2020 18:00:55 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.002; Tue, 15 Dec 2020 10:00:53 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     wanghuiqiang <wanghuiqiang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwOHViTg3pRnhkK4BwcYBC9AoqngmnQAgAABpXCAACfogIAABzIwgAA00gCAAnf7sIAUZ4qAgAAjnaA=
Date:   Tue, 15 Dec 2020 10:00:53 +0000
Message-ID: <dbbeca0088fc49ad9554408465b6cb89@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
 <e93770e46c73413882584ebc3fe732e3@huawei.com>
 <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
 <931f76fa185e488fb9e942b2026ae7be@huawei.com>
 <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
In-Reply-To: <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.65.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2FuZ2h1aXFpYW5nLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogd2FuZ2h1aXFpYW5nDQo+IFNlbnQ6IDE1IERlY2VtYmVyIDIwMjAgMDc6NDkNCj4gVG86IFNo
YW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbT47DQo+IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IENjOiBNYXJjIFp5
bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsgeHV3ZWkgKE8pIDx4dXdlaTVA
aHVhd2VpLmNvbT4NCj4gU3ViamVjdDog562U5aSNOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBD
aGVjayBTUkUgYml0IGZvciBHSUN2MiBsZWdhY3kgc3VwcG9ydA0KPiANCj4gU29ycnkgcmVzcG9u
c2UgbGF0ZS4NCj4gSGkgU2hhbWVlciAmIEFyZCwNCj4gDQo+IENvdWxkIHlvdSBsZXQgbWUga25v
dyB3aGljaCBmaXJtd2FyZSB5b3UgYXJlIHVzaW5nPyBJZiB0aGUgZGlmZmVyZW5jZSBpcyBNYWR0
DQo+IHRhYmxlIHZHSUMgeW91ciBwb2ludGVkICwgdGhleSBhcmUgdGhlIHNhbWUuIFdlIGNoYW5n
ZWQgdGhlIHZHSUMgbWVtb3J5DQo+IGJhc2UgYWRkcmVzcyBhdCB2ZXJ5IGVhcmx5IGRlc2lnbiBz
dGFnZS4NCg0KSSBjaGVja2VkIHRoZSBiZWxvdyBvbmVzIGFuZCBhbGwgdGhlc2UgYm9hcmRzIGhh
cyB0aGUgaXNzdWUsDQoNCk9wZW5sYWItQm9hcmQgLSA2OTAwOSwNCg0KRE1JOiBIdWF3ZWkgVGFp
U2hhbiAyMjgwIFYyL0JDODJBTURDLCBCSU9TIDIyODAtVjIgQ1MgVjMuQjI3MC4wMSAwNS8wOC8y
MDIwDQoNCk9wZW5sYWItQm9hcmQtNjkwMDgsDQoNCkRNSTogSHVhd2VpIFRhaVNoYW4gMjI4MCBW
Mi9CQzgyQU1EQywgQklPUyAyMjgwLVYyIENTIFY1LkIwMzAuMDEgMDcvMDMvMjAyMA0KDQpVSy1E
MDZDUy1ib2FyZCwNCg0KQm9vdCBmaXJtd2FyZSAodmVyc2lvbiAyMjgwLVYyIENTIFYzLkIyMjAu
MDEgYnVpbHQgYXQgMDMvMTkvMjAyMCAgMTY6NTIpDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiBU
aGFua3PvvIENCj4gDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBTaGFt
ZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IOWPkemAgeaXtumXtDogMjAyMOW5tDEy5pyIMuaXpSAx
NjoyMw0KPiDmlLbku7bkuro6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IOaK
hOmAgTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IGVyaWMuYXVnZXJAcmVkaGF0LmNv
bTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IHdhbmdo
dWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyB4dXdlaQ0KPiAoTykgPHh1d2VpNUBo
dWF3ZWkuY29tPg0KPiDkuLvpopg6IFJFOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBT
UkUgYml0IGZvciBHSUN2MiBsZWdhY3kgc3VwcG9ydA0KPiANCj4gWytdDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgW21haWx0bzph
cmRiQGtlcm5lbC5vcmddDQo+ID4gU2VudDogMzAgTm92ZW1iZXIgMjAyMCAxODozMg0KPiA+IFRv
OiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb20+DQo+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBlcmljLmF1
Z2VyQHJlZGhhdC5jb207DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IExpbnV4YXJtIDxsaW51eGFybUBo
dWF3ZWkuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVj
ayBTUkUgYml0IGZvciBHSUN2MiBsZWdhY3kNCj4gPiBzdXBwb3J0DQo+ID4NCj4gLi4uDQo+IA0K
PiA+DQo+ID4gQW55IGNsdWUgd2h5IHByb2R1Y3Rpb24gRDA2IGZpcm13YXJlIGRldmlhdGVzIGZy
b20gdGhlIEQwNiBwb3J0IHRoYXQNCj4gPiBleGlzdHMgaW4gVGlhbm9jb3JlJ3MgZWRrMi1wbGF0
Zm9ybXMgcmVwb3NpdG9yeT8gQmVjYXVzZSB0aGF0IHZlcnNpb24NCj4gPiBkb2VzIG5vdCBoYXZl
IHRoaXMgYnVnLCBhbmQgSSB3b25kZXIgd2h5IHRoYXQgY29kZSB3YXMgdXBzdHJlYW1lZCBhdA0K
PiA+IGFsbCBpZiBhIHN1YnN0YW50aWFsbHkgZGlmZmVyZW50IHZlcnNpb24gZ2V0cyBzaGlwcGVk
IHdpdGggcHJvZHVjdGlvbg0KPiA+IGhhcmR3YXJlLg0KPiANCj4gT2suIFRoYW5rcyBmb3IgcG9p
bnRpbmcgdGhpcyBvdXQuIEkgaGF2ZSBpbmZvcm1lZCBvdXIgVUVGSSB0ZWFtIGFib3V0IHRoaXMu
DQo+IFRoZXkgd2lsbCBjaGVjayBJbnRlcm5hbGx5IGFuZCBjbGFyaWZ5Lg0KPiANCj4gUmVnYXJk
cywNCj4gU2hhbWVlcg0K
