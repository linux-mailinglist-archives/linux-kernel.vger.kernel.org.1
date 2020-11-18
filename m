Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654942B88D5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKRXzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:55:37 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2375 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgKRXzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:55:36 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Cc06p14fXz520J;
        Thu, 19 Nov 2020 07:55:14 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 19 Nov 2020 07:55:33 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 19 Nov 2020 07:55:33 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 19 Nov 2020 07:55:33 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Topic: [PATCH] arm64: mm: add support for memmap kernel parameters
Thread-Index: AQHWvXVLtrpWHgsWH0upIuwmJUX89KnNolcAgAAa/ICAAJI6cP//pm8AgACWN3A=
Date:   Wed, 18 Nov 2020 23:55:33 +0000
Message-ID: <0a1de2555ed2458d97e5c79929f74380@hisilicon.com>
References: <20201118063314.22940-1-song.bao.hua@hisilicon.com>
 <20201118173854.GA8537@kernel.org> <20201118191528.GA2680@willie-the-truck>
 <1d3780422d2648dfa80a6de87585819a@hisilicon.com>
 <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
In-Reply-To: <CAMj1kXE-Ea7K_U9JUp2uq+kpmTEYaiKrqMK1J1DOG-UAA3J6ow@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.226]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwg
W21haWx0bzphcmRiQGtlcm5lbC5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxOSwg
MjAyMCAxMTozOCBBTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8u
aHVhQGhpc2lsaWNvbi5jb20+DQo+IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsg
TWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPjsNCj4gYW5zaHVtYW4ua2hhbmR1YWxAYXJt
LmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3
ZWkuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBtbTogYWRkIHN1cHBvcnQgZm9yIG1lbW1hcCBrZXJuZWwg
cGFyYW1ldGVycw0KPiANCj4gT24gV2VkLCAxOCBOb3YgMjAyMCBhdCAyMToyNywgU29uZyBCYW8g
SHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0K
PiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IFdpbGwgRGVhY29uIFttYWlsdG86d2lsbEBrZXJuZWwub3JnXQ0KPiA+ID4gU2VudDogVGh1
cnNkYXksIE5vdmVtYmVyIDE5LCAyMDIwIDg6MTUgQU0NCj4gPiA+IFRvOiBNaWtlIFJhcG9wb3J0
IDxycHB0QGtlcm5lbC5vcmc+DQo+ID4gPiBDYzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+Ow0KPiA+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5j
b207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBh
bnNodW1hbi5raGFuZHVhbEBhcm0uY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBtbTogYWRkIHN1cHBvcnQgZm9yIG1l
bW1hcCBrZXJuZWwNCj4gcGFyYW1ldGVycw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgTm92IDE4LCAy
MDIwIGF0IDA3OjM4OjU0UE0gKzAyMDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+ID4gPiA+IE9u
IFdlZCwgTm92IDE4LCAyMDIwIGF0IDA3OjMzOjE0UE0gKzEzMDAsIEJhcnJ5IFNvbmcgd3JvdGU6
DQo+ID4gPiA+ID4gbWVtbWFwIHNob3VsZCBiZSBhbiB1c2VmdWwga2VybmVsIHBhcmFtZXRlciB3
aGljaCBoYXMgYmVlbg0KPiBzdXBwb3J0ZWQNCj4gPiA+IGJ5DQo+ID4gPiA+ID4geDg2LCBtaXBz
IGFuZCB4dGVuc2EuDQo+ID4gPiA+DQo+ID4gPiA+IFdoeSBpcyB0aGlzIHBhcmFtZXRlciBzaG91
bGQgYmUgdXNlZnVsIGZvciBBUk02ND8NCj4gPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0
IGl0IGlzIHJlcXVpcmVkIG9ubHkgdG8gd29yayBhcm91bmQgcmVhbGx5DQo+ID4gPiA+IGJyb2tl
biBib290bG9hZGVycywgaXNuJ3QgaXQ/DQo+ID4gPg0KPiA+DQo+ID4gR29vZCBxdWVzdGlvbi4g
T3JpZ2luYWxseSBJIHdyb3RlIHRoaXMgcGF0Y2ggdG8gZGVidWcgYW5kIHZlcmlmeSB0aGUNCj4g
dm1lbW1hcA0KPiA+IGxlYWsgaXNzdWUgcmVwb3J0ZWQgaW4gdGhpcyBwYXRjaDoNCj4gPiBbUEFU
Q0ggdjJdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFwIGZvciBzcGFyc2UgbWVtb3J5IG1v
ZGVsIHRoYXQNCj4gZGVmaW5lIFZNRU1NQVANCj4gPg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1hcm0ta2VybmVsLzIwMjAwODEyMDEwNjU1Ljk2MzM5LTEtbGl3ZWkyMTNADQo+IGh1
YXdlaS5jb20vDQo+ID4gSSBkb24ndCBoYXZlIGEgbWFjaGluZSB3aGljaCByZWFsbHkgaGFzIGhv
bGVzIGluIG1lbW9yeV9zZWN0aW9uIHRvIGRlYnVnLA0KPiBidXQgbWVtbWFwDQo+ID4gY2FuIGhl
bHAuIFdpdGggbWVtbWFwLCBJIGNvdWxkIHNwZWNpZmllZCBhIG1hY2hpbmUgd2l0aCB2YXJpb3Vz
IGhvbGRzIGluDQo+IG1lbV9zZWN0aW9ucy4NCj4gPg0KPiA+IEFmdGVyIHRoYXQsIEkgZmlndXJl
ZCBvdXQgdGhpcyBpcyBub3Qgb25seSB1c2VmdWwgZm9yIGRlYnVnZ2luZyBwdXJwb3NlLiBpdCBj
YW4NCj4gaGF2ZSBzb21lIHJlYWwgdXNlciBjYXNlcy4NCj4gPiBGb3IgZXhhbXBsZToNCj4gPg0K
PiA+IDEuIERBWCBvbiBEUkFNLg0KPiA+IGtlcm5lbCBwYXJhbWV0ZXIgbWVtbWFwPVhHIVlHIHNw
ZWNpZmllcyBhIHJhbmdlIG9mIFJBTSB0byBlbXVsYXRlDQo+IHBtZW0uIFRoZW4gd2UgYXJlIGFi
bGUNCj4gPiB0byBydW4gREFYIGFuZCBmaWxlc3lzdGVtIG9uIHRvcCBvZiBpdC4gRnVydGhlcm1v
cmUsIHRoaXMgd2lsbCBwcm9iYWJseSBhbHNvDQo+IGJlbmVmaXQgdGhlIGNhc2UNCj4gPiB0aGlz
IGJpZyBwYXRjaHNldCB3YW50cyB0byAiZml4IiB2aWEgZGlyZWN0IGFjY2VzcyB0byBtZW1vcnk6
DQo+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNjAyMDkzNzYwLmdp
dC55dWxlaXh6aGFuZ0B0ZW5jZW50LmNvbS9UDQo+IC8jbTFhNzcwNzRiOGUxZGFkYzU5MGE1ZjQ1
YTUyZDljM2NkYTY5YzA3ODANCj4gPiBhcyB0aGUgY29tbWVudHMgaGF2ZSBjbGVhcmx5IHNob3du
Lg0KPiA+DQo+ID4gMi4gcmVzZXJ2ZSBzb21lIG1lbW9yeSBmb3IgdXNlcnNwYWNlIHRvIG1hbmFn
ZSB2aWEgL2Rldi9tZW0NCj4gPg0KPiANCj4gQXBvbG9naWVzIGZvciB0aGUgYmx1bnRuZXNzLCBi
dXQgd2hhdCB5b3UgYXJlIHNheWluZyBoZXJlIGlzIHRoYXQgeW91DQo+IG5lZWQgYSBoYWNrIHRv
IHBpbGUgdGhvc2Ugb3RoZXIgaGFja3Mgb250by4NCj4gDQo+IEN1cnJlbnRseSwgd2UgdXNlIHRo
ZSBOT01BUCBhdHRyaWJ1dGUgaW4gbWVtYmxvY2sgdG8gZGVzY3JpYmUgbWVtb3J5DQo+IHRoYXQg
aXMgb21pdHRlZCBmcm9tIHRoZSBkaXJlY3QgbWFwLiBSZW1vdmluZyBtZW1vcnkgZnJvbSBtZW1i
bG9jaw0KPiBlbnRpcmVseSBhbHNvIHN0cmlwcyBpdCBvZiB0aGlzIGFubm90YXRpb24sIHdoaWNo
IG1lYW5zIHRoYXQNCj4gcGh5c19tZW1fYWNjZXNzX3Byb3QoKSB3aWxsIGlkZW50aWZ5IGl0IGFz
IGRldmljZSBtZW1vcnkgbm90IERSQU0sIGFuZA0KPiB1c2UgdGhlIHdyb25nIGF0dHJpYnV0ZXMg
d2hlbiB1c2luZyAvZGV2L21lbS4NCj4gDQo+IFRoZXJlIGFyZSBsaWtlbHkgb3RoZXIgcGxhY2Vz
IHdoZXJlIHRoaXMgZGlzdGluY3Rpb24gbWF0dGVycywgYW5kIHNvIEkNCj4gYW0gbm90IGJ1eWlu
ZyB0aGUganVzdGlmaWNhdGlvbiB0aGF0IHdlIGNhbiBtYWtlIG1lYW5pbmdmdWwgdXNlIG9mDQo+
IHRoaXMgbWVtb3J5IGluIHRoZSBnZW5lcmFsIGNhc2UsIGFuZCBhbnl0aGluZyB0aGF0IHJlbGll
cyBvbiBpdCB3aWxsDQo+IGJlIGZyYWdpbGUsIGFuZCBwcm9iYWJseSBvbmx5IGxpbWl0ZWQgdG8g
dmVyeSBzcGVjaWZpYyBkZWJ1Zw0KPiBzY2VuYXJpb3MuDQoNClllcC4gb3JpZ2luYWxseSBJIGRp
ZCB0aGF0IGZvciBkZWJ1Z2dpbmcgcHVycG9zZSB0byBlbXVsYXRlIGEgbWFjaGluZSB3aXRoDQpz
b21lIGhvbGVzIGluIG1lbV9zZWN0aW9uLiBJIGd1ZXNzIGl0IHNob3VsZCBiZSBhbHNvIHVzZWZ1
bCB0byBvdGhlciBwZW9wbGUNCmlmIHRoZXkgbmVlZCB0aGUgc2FtZSB0aGluZyBmb3IgZGVidWdn
aW5nLg0KDQo+IA0KPiBTbyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBtZXJnZSB0aGlzLg0KDQpJ
dCBzaG91bGQgYmUgaW4gdGhlIHNhbWUgc2l0dWF0aW9uIGZvciBvdGhlciBwbGF0Zm9ybXMgbGlr
ZSB4ODYsIG1pcHMgYW5kIHh0ZW5zYQ0KYnV0IHRoZXkgaGF2ZSBlbmFibGVkIHRoaXMga2VybmVs
IHBhcmFtZXRlci4NCg0KbWF5YmUgdGhlIGVtdWxhdGVkIHBtZW0gYnkgRFJBTSBpcyBhbiB1c2Vm
dWwgc2NlbmFyaW8gb3RoZXIgdGhhbiBkZWJ1Z2dpbmcuDQoNCkxhdGVyLCBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL2NvdmVyLjE2MDIwOTM3NjAuZ2l0Lnl1bGVpeHpoYW5nQHRlbmNlbnQu
Y29tL1QvI20xYTc3MDc0YjhlMWRhZGM1OTBhNWY0NWE1MmQ5YzNjZGE2OWMwNzgwDQptaWdodCBi
ZSBhYmxlIHRvIHVzZSB0aGlzIHBhcmFtZXRlci4NCg0KQW55d2F5LCBJIGRvbid0IG1pbmQga2Vl
cGluZyBpdCBsb2NhbCBmb3IgZGVidWdnaW5nIGF0IHRoaXMgc3RhZ2UgYW5kIHdhaXRpbmcgZm9y
IGENCm1vcmUgY29udmluY2luZyB1c2UgY2FzZS4NCg0KPiANCj4gDQo+ID4NCj4gPiA+IEFncmVl
ZCwgSSBjYW4ndCBzZWUgdGhpcyBiZWluZyBzb21ldGhpbmcgd2UgcmVhbGx5IHdhbnQgdG8gc3Vw
cG9ydC4gSWYgaXQNCj4gPiA+IHR1cm5zIG91dCB0aGF0IGl0IGlzIGdlbmVyYWxseSB1c2VmdWws
IHRoZW4gdGhlIGltcGxlbWVudGF0aW9uIHNob3VsZA0KPiA+ID4gcHJvYmFibHkgYmUgc29tZXdo
ZXJlIG91dHNpZGUgb2YgYXJjaC8gd2hlcmUgSSBkb24ndCBoYXZlIHRvIGxvb2sgYXQgaXQgOikN
Cj4gPiA+DQo+ID4NCj4gPiBXaGF0IHN0b3BzIHRoaXMgYmVjb21pbmcgY29tbW9uIGNvZGUgaXMg
dGhhdCBlYWNoIHBsYXRmb3JtIGhhcyBkaWZmZXJlbnQNCj4gd2F5cw0KPiA+IGFuZCBib290IHNl
cXVlbmNlcyB0byBwb3B1bGF0ZSBtZW1ibG9jay4NCj4gPiBGb3IgZXhhbXBsZSwgb24gQXJtNjQs
IHdoaWxlIGVhcmx5X3BhcmFtIGlzIHBvcHVsYXRlZCwgZHQgaGFzIHBvcHVsYXRlZA0KPiA+IG1l
bWJsb2NrIGJlZm9yZSB0aGF0LiBPdGhlciBwbGF0Zm9ybXMgbWlnaHQgYmVlbiBtdWNoIGRpZmZl
cmVudC4NCj4gPg0KPiA+ID4gV2lsbA0KPiA+DQoNClRoYW5rcw0KQmFycnkNCg0K
