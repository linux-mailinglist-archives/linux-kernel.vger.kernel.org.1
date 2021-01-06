Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB92EB84C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbhAFDEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:04:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2938 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFDEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:04:51 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4D9Z1W1cWhz5DTL;
        Wed,  6 Jan 2021 11:03:11 +0800 (CST)
Received: from dggema713-chm.china.huawei.com (10.3.20.77) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 6 Jan 2021 11:04:06 +0800
Received: from dggema768-chm.china.huawei.com (10.1.198.210) by
 dggema713-chm.china.huawei.com (10.3.20.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 6 Jan 2021 11:04:05 +0800
Received: from dggema768-chm.china.huawei.com ([10.9.48.81]) by
 dggema768-chm.china.huawei.com ([10.9.48.81]) with mapi id 15.01.1913.007;
 Wed, 6 Jan 2021 11:04:04 +0800
From:   "linfeng (M)" <linfeng23@huawei.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Wangjing (Hogan, Cloud Infrastructure Service Product Dept.)" 
        <hogan.wang@huawei.com>,
        "Wangxin (Alexander)" <wangxinxin.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RE: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
Thread-Topic: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
Thread-Index: AQHW40BOPMsRyBicpkWTP4HdZRlWOqoYND8AgADK1ICAANie4A==
Date:   Wed, 6 Jan 2021 03:04:04 +0000
Message-ID: <790039cd9c374a678abcb286d2709d2b@huawei.com>
References: <20210105085346.995-1-linfeng23@huawei.com>
 <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
 <X/TTgYA+C0LjFAo2@rani.riverdale.lan>
In-Reply-To: <X/TTgYA+C0LjFAo2@rani.riverdale.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.88]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ2aW5kIFNhbmthciBb
bWFpbHRvOm5pdmVkaXRhczk4QGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIEFydmluZA0KPiBTYW5r
YXINCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDYsIDIwMjEgNTowMSBBTQ0KPiBUbzogQXJk
IEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbmZlbmcgKE0pIDxsaW5mZW5n
MjNAaHVhd2VpLmNvbT47IEFydmluZCBTYW5rYXINCj4gPG5pdmVkaXRhQGFsdW0ubWl0LmVkdT47
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xuYXINCj4gPG1p
bmdvQHJlZGhhdC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IEh1YW5nd2Vp
ZG9uZyAoQykNCj4gPHdlaWRvbmcuaHVhbmdAaHVhd2VpLmNvbT47IFdhbmdqaW5nIChIb2dhbiwg
Q2xvdWQgSW5mcmFzdHJ1Y3R1cmUNCj4gU2VydmljZSBQcm9kdWN0IERlcHQuKSA8aG9nYW4ud2Fu
Z0BodWF3ZWkuY29tPjsgV2FuZ3hpbiAoQWxleGFuZGVyKQ0KPiA8d2FuZ3hpbnhpbi53YW5nQGh1
YXdlaS5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgRXJpYyBXLiBCaWVkZXJtYW4gPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0geDg2L2thc2xyOiB0cnkgcHJvY2VzcyBlODIwIGVudHJp
ZXMgaWYgY2FuIG5vdCBnZXQgc3VpdGFibGUNCj4gcmVnaW9ucyBmcm9tIGVmaQ0KPiANCj4gT24g
VHVlLCBKYW4gMDUsIDIwMjEgYXQgMDk6NTQ6NTJBTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3Jv
dGU6DQo+ID4gKGNjIEFydmluZCkNCj4gPg0KPiA+IE9uIFR1ZSwgNSBKYW4gMjAyMSBhdCAwOTo1
NCwgTGluIEZlbmcgPGxpbmZlbmcyM0BodWF3ZWkuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBP
biBlZmk2NCB4ODZfNjQgc3lzdGVtLCB0aGUgRUZJX0NPTlZFTlRJT05BTF9NRU1PUlkgcmVnaW9u
cyB3aWxsDQo+IG5vdA0KPiA+ID4gYmUgbWFwcGVkIHdoZW4gbWFraW5nIEVGSSBydW50aW1lIGNh
bGxzLiBTbyBrZXhlYy10b29scyBjYW4gbm90IGdldA0KPiA+ID4gdGhlc2UgZnJvbSAvc3lzL2Zp
cm13YXJlL2VmaS9ydW50aW1lLW1hcC4gVGhlbiBjb21wcmVzc2VkIGJvb3Qgb3MNCj4gPiA+IGNh
biBub3QgZ2V0IHN1aXRhYmxlIHJlZ2lvbnMgaW4gcHJvY2Vzc19lZmlfZW50cmllcyBhbmQgcHJp
bnQgZGVidWcNCj4gPiA+IG1lc3NhZ2UgYXMgZm9sbG93Og0KPiA+ID4gICAgICAgICBQaHlzaWNh
bCBLQVNMUiBkaXNhYmxlZDogbm8gc3VpdGFibGUgbWVtb3J5IHJlZ2lvbiENCj4gPiA+IFRvIGVu
YWJsZSBwaHlzaWNhbCBrYXNsciB3aXRoIGtleGVjLCBjYWxsIHByb2Nlc3NfZTgyMF9lbnRyaWVz
IHdoZW4NCj4gPiA+IG5vIHN1aXRhYmxlIHJlZ2lvbnMgaW4gZWZpIG1lbW1hcHMuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTGluIEZlbmcgPGxpbmZlbmcyM0BodWF3ZWkuY29tPg0KPiA+
ID4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IEkgZmluZCBhIHJlZ3VsYXIgb2YgS2VybmVsIGNv
ZGUgYW5kIGRhdGEgcGxhY2VtZW50IHdpdGgga2V4ZWMuIEl0DQo+ID4gPiBzZWVtcyB1bnNhZmUu
IFRoZSByZWFzb24gaXMgc2hvd2VkIGFib3ZlLg0KPiA+ID4NCj4gPiA+IEknbSBub3QgZmFtaWxp
YXIgd2l0aCBlZmkgZmlybXdhcmUuIEkgd29uZGVyIGlmIHRoZXJlIGFyZSBzb21lIHJpc2tzDQo+
ID4gPiB0byBnZXQgcmVnaW9ucyBhY2NvcmRpbmcgdG8gZTgyMCB3aGVuIHRoZXJlIGlzIG5vIHN1
aXRhYmxlIHJlZ2lvbiBpbg0KPiA+ID4gZWZpIG1lbW1hcHMuDQo+ID4gPiAtLS0NCj4gPiA+ICBh
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQva2FzbHIuYyB8IDQgKysrLQ0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyLmMNCj4gPiA+IGIvYXJjaC94
ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyLmMNCj4gPiA+IGluZGV4IGI5MmZmZmJlNzYxZi4uZGJk
NzI0NGI3MWFhIDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2th
c2xyLmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNsci5jDQo+ID4g
PiBAQCAtNjg1LDYgKzY4NSw3IEBAIHByb2Nlc3NfZWZpX2VudHJpZXModW5zaWduZWQgbG9uZyBt
aW5pbXVtLA0KPiA+ID4gdW5zaWduZWQgbG9uZyBpbWFnZV9zaXplKSAgew0KPiA+ID4gICAgICAg
ICBzdHJ1Y3QgZWZpX2luZm8gKmUgPSAmYm9vdF9wYXJhbXMtPmVmaV9pbmZvOw0KPiA+ID4gICAg
ICAgICBib29sIGVmaV9taXJyb3JfZm91bmQgPSBmYWxzZTsNCj4gPiA+ICsgICAgICAgYm9vbCBl
ZmlfbWVtX3JlZ2lvbl9mb3VuZCA9IGZhbHNlOw0KPiA+ID4gICAgICAgICBzdHJ1Y3QgbWVtX3Zl
Y3RvciByZWdpb247DQo+ID4gPiAgICAgICAgIGVmaV9tZW1vcnlfZGVzY190ICptZDsNCj4gPiA+
ICAgICAgICAgdW5zaWduZWQgbG9uZyBwbWFwOw0KPiA+ID4gQEAgLTc0MiwxMiArNzQzLDEzIEBA
IHByb2Nlc3NfZWZpX2VudHJpZXModW5zaWduZWQgbG9uZyBtaW5pbXVtLA0KPiB1bnNpZ25lZCBs
b25nIGltYWdlX3NpemUpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICEobWQtPmF0dHJpYnV0
ZSAmDQo+IEVGSV9NRU1PUllfTU9SRV9SRUxJQUJMRSkpDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4gPiA+DQo+ID4gPiArICAgICAgICAgICAgICAgZWZpX21lbV9y
ZWdpb25fZm91bmQgPSBmYWxzZTsNCj4gCQkJCQkgICBeXiB0aGlzIHNob3VsZCBiZSB0cnVlLCBu
b3QgZmFsc2UuDQpZb3UncmUgcmlnaHQuIEl0IHNob3VsZCBiZSB0cnVlIGhlcmUuIFRoYW5rcyBm
b3IgcG9pbnRpbmcgb3V0Lg0KPiANCj4gT3RoZXIgdGhhbiB0aGF0LCBJIHRoaW5rIHRoaXMgc2hv
dWxkIGJlIG9rYXkuIFRoZSByZWFzb24gRUZJIG1lbW1hcCBpcw0KPiBwcmVmZXJyZWQgb3ZlciBF
ODIwLCBhY2NvcmRpbmcgdG8gY29tbWl0DQo+IA0KPiAgIDA5ODJhZGM3NDY3MyAoIng4Ni9ib290
L0tBU0xSOiBXb3JrIGFyb3VuZCBmaXJtd2FyZSBidWdzIGJ5IGV4Y2x1ZGluZw0KPiBFRklfQk9P
VF9TRVJWSUNFU18qIGFuZCBFRklfTE9BREVSXyogZnJvbSBLQVNMUidzIGNob2ljZSIpDQo+IA0K
PiB3YXMgdG8gYXZvaWQgYWxsb2NhdGluZyBpbnNpZGUgRUZJX0JPT1RfU0VSVklDRVMvRUZJX0xP
QURFUl9EQVRBIGV0Yy4NCj4gVGhhdCdzIG5vdCBhIGRhbmdlciBkdXJpbmcga2V4ZWMsIGFuZCBJ
IGJlbGlldmUgcnVudGltZSBzZXJ2aWNlcyByZWdpb25zIHNob3VsZA0KPiBiZSBtYXJrZWQgYXMg
cmVzZXJ2ZWQgaW4gdGhlIEU4MjAgbWFwLCByaWdodD8NClllcy4NCj4gDQo+IEFsc28sIHNvbWV0
aGluZyBhIGxpdHRsZSBmaXNoeS1sb29raW5nIGhlcmUgaXMgdGhhdCB0aGUgZmlyc3QgbG9vcCB0
byBzZWUgaWYgdGhlcmUgaXMNCj4gYW55IEVGSV9NRU1PUllfTU9SRV9SRUxJQUJMRSByZWdpb24g
ZG9lcyBub3QgYXBwbHkgYW55IG9mIHRoZSBjaGVja3Mgb24NCj4gdGhlIG1lbW9yeSByZWdpb24g
dHlwZS9hdHRyaWJ1dGVzLiBJZiB0aGVyZSBpcyBhIG1pcnJvciByZWdpb24gYnV0IGl0IGlzbid0
DQo+IGNvbnZlbnRpb25hbCBtZW1vcnksIG9yIGlmIGl0IHdhcyBzb2Z0LXJlc2VydmVkLCB3ZSBz
aG91bGRuJ3QgYmUgc2V0dGluZw0KPiBlZmlfbWlycm9yX2ZvdW5kLg0KSSB0aGluayBzby4gQW5k
IEkgd29uZGVyIGlmIHRoZSBtZW1vcnkgbWlycm9yIGRvZXNuJ3Qgd29yayB3aXRoIGtleGVjIGFu
ZCBrc2Fscg0Kb25seSB0aGlzIHBhdGNoIHVzZWQsIGJlY2F1c2UgYSBsb3Qgb2YgZWZpIGluZm9y
bWF0aW9uIGlzIGxvc3QgYW5kIGU4MjAgZG9uJ3QgaGF2ZSBhbnkNCm1pcnJvciByZWdpb25zIGlu
Zm9ybWF0aW9uLiBEdWUgdG8gcmVzb3VyY2UgY29uc3RyYWludHMsIEkgaGF2ZW4ndCB0ZXN0ZWQg
aXQgeWV0Lg0KQnV0IGl0IHNlZW1zIHNvLg0KPiANCj4gDQo+ID4gPiAgICAgICAgICAgICAgICAg
cmVnaW9uLnN0YXJ0ID0gbWQtPnBoeXNfYWRkcjsNCj4gPiA+ICAgICAgICAgICAgICAgICByZWdp
b24uc2l6ZSA9IG1kLT5udW1fcGFnZXMgPDwgRUZJX1BBR0VfU0hJRlQ7DQo+ID4gPiAgICAgICAg
ICAgICAgICAgaWYgKHByb2Nlc3NfbWVtX3JlZ2lvbigmcmVnaW9uLCBtaW5pbXVtLA0KPiBpbWFn
ZV9zaXplKSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAg
ICAgICB9DQo+ID4gPiAtICAgICAgIHJldHVybiB0cnVlOw0KPiA+ID4gKyAgICAgICByZXR1cm4g
ZWZpX21lbV9yZWdpb25fZm91bmQ7DQo+ID4gPiAgfQ0KPiA+ID4gICNlbHNlDQo+ID4gPiAgc3Rh
dGljIGlubGluZSBib29sDQo+ID4gPiAtLQ0KPiA+ID4gMi4yMy4wDQo+ID4gPg0K
