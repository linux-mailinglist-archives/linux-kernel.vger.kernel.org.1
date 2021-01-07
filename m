Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0E2ED2F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbhAGOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:43:10 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2351 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbhAGOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:43:09 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DBTS5012Wz13cwN;
        Thu,  7 Jan 2021 22:40:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 7 Jan 2021 22:42:24 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.002; Thu, 7 Jan 2021 14:42:22 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     wanghuiqiang <wanghuiqiang@huawei.com>,
        'Ard Biesheuvel' <ardb@kernel.org>,
        'Marc Zyngier' <maz@kernel.org>
CC:     "'eric.auger@redhat.com'" <eric.auger@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwOHViTg3pRnhkK4BwcYBC9AoqngmnQAgAABpXCAACfogIAABzIwgAA00gCAAnf7sIAUZ4qAgCKtSgCAAAQuwA==
Date:   Thu, 7 Jan 2021 14:42:22 +0000
Message-ID: <df92dc810896439982bbd2d18c799913@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
 <e93770e46c73413882584ebc3fe732e3@huawei.com>
 <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
 <931f76fa185e488fb9e942b2026ae7be@huawei.com>
 <07084A11A8AB5A40A40B0218FE6F1CCA0F59630F@dggeml510-mbx.china.huawei.com>
 <07084A11A8AB5A40A40B0218FE6F1CCA0F5B3322@dggeml510-mbx.china.huawei.com>
In-Reply-To: <07084A11A8AB5A40A40B0218FE6F1CCA0F5B3322@dggeml510-mbx.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.66.123]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB3YW5naHVpcWlhbmcNCj4gU2Vu
dDogMDYgSmFudWFyeSAyMDIxIDA5OjIyDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2Rp
IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiAnQXJkIEJpZXNoZXV2
ZWwnIDxhcmRiQGtlcm5lbC5vcmc+DQo+IENjOiAnTWFyYyBaeW5naWVyJyA8bWF6QGtlcm5lbC5v
cmc+OyAnZXJpYy5hdWdlckByZWRoYXQuY29tJw0KPiA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsg
J2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcnDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgJ2xpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZycNCj4gPGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IExpbnV4YXJtIDxsaW51eGFybUBodWF3
ZWkuY29tPjsNCj4geHV3ZWkgKE8pIDx4dXdlaTVAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDog562U
5aSNOiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0IGZvciBHSUN2MiBsZWdh
Y3kgc3VwcG9ydA0KPiANCj4gSGkgQXJkIGFuZCBhbGwsDQo+IA0KPiBUaGUgaXNzdWUgaXMgcm9v
dCBjYXVzZWQsIGl0IGlzIGludHJvZHVjZWQgYnkgQklPUyBuZXcgZmVhdHVyZSBpbXBsZW1lbnRl
ZC4NCj4gV2l0aCBvbGQgQklPU++8jHdlIHVzZSBzdGF0aWMgTUFEVCB0YWJsZSBhbmQgdGhlIEdJ
Q1YvR0lDSCBpcyBzZXQgdG8gMCBhbmQNCj4gcmVwb3J0ZWQgdGhpcyB0YWJsZSB0byBPUy4gQnV0
IHdlIGFkZGVkIG5ldyBmZWF0dXJlcyB3aGljaCB3aWxsIGR5bmFtaWMNCj4gdXBkYXRlIE1BRFQg
dGFibGUgYmFzZWQgb24gc29tZSBleHRlcm5hbCBpbnB1dCwgdGhlIGRldmVsb3BlciBpcyBzZXQN
Cj4gR0lDVi9HSUNIIGFzIHdoYXQgd2UgaGF2ZSBkb25lIGxpa2UgcHJldmlvdXMgZ2VuZXJhdGlv
biBjaGlwc2V0IGNvZGUgZGlkLg0KPiBCdXQgaW4gZmFjdCwgdGhlcmUgaXMgZGlmZmVyZW50IGNv
bXBhcmVkIHdpdGggb2xkIGdlbmVyYXRpb24gY2hpcHNldCBjb2RlLg0KPiBJJ2xsIGxldCBteSBp
bnRlcm5hbCB0ZWFtIGtub3cgdGhpcyBhbmQgZml4IHRoaXMgaXNzdWUgaW4gbGF0ZXIgQklPUyBy
ZWxlYXNlLg0KDQpUaGFua3MgV2FuZ2h1aXFpYW5nIGZvciB5b3VyIGVmZm9ydHMgYW5kIGNvbmZp
cm1pbmcgdGhlIGlzc3VlLg0KDQpIaSBNYXJjLA0KDQpDb25zaWRlcmluZyB0aGUgZmFjdCB0aGF0
IHdlIGhhdmUgc3lzdGVtcyBvdXQgdGhlcmUgd2l0aCB0aGUgZmF1bHR5IEJJT1MsIGFuZCBpdCBp
cw0Kbm90IG5lY2Vzc2FyaWx5IGV2ZXJ5b25lIHdpbGwgYmUga2VlbiB0byB1cGRhdGUgdGhlIEJJ
T1MsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvDQphZGRyZXNzIHRoaXMgaW4ga2VybmVsIGFzIHdl
bGwuDQoNCkFzIGRpc2N1c3NlZCBlYXJsaWVyLCBwbGVhc2UgY29uc2lkZXIgdGhlIFNSRSBiaXQg
YmFzZWQgc29sdXRpb24gdG8gbWFrZSB0aGUgbG9naWMNCm1vcmUgcm9idXN0IGlycmVzcGVjdGl2
ZSBvZiB3aGF0IEJJT1MgcHJvdmlkZXMuDQoNCihJIGRvbuKAmXQgaGF2ZSBhbiBlcnJhdHVtIGlk
IGZvciB0aGlzIGFzIEkgYW0gdG9sZCB3ZSBrZWVwIHRoYXQgZm9yIEhhcmR3YXJlIGlzc3Vlcw0K
b25seSwgYnV0IHdlIGFyZSB1c2luZyBEVFMyMDIxMDEwNzBPQUdVSVAxTDAwIHRvIHRyYWNrIHRo
ZSBpc3N1ZSBhbmQgY2FuIGJlDQp1c2VkIGFzIHJlZmVyZW5jZSkuDQoNClRoYW5rcywNClNoYW1l
ZXIgDQoNCj4gVGhhbmtzIQ0KPiANCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bk
uro6IHdhbmdodWlxaWFuZw0KPiDlj5HpgIHml7bpl7Q6IDIwMjDlubQxMuaciDE15pelIDE1OjQ5
DQo+IOaUtuS7tuS6ujogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgQXJkIEJpZXNoZXV2ZWwNCj4gPGFyZGJAa2VybmVs
Lm9yZz4NCj4g5oqE6YCBOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgZXJpYy5hdWdl
ckByZWRoYXQuY29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWku
Y29tPjsgeHV3ZWkgKE8pIDx4dXdlaTVAaHVhd2VpLmNvbT4NCj4g5Li76aKYOiDnrZTlpI06IFtQ
QVRDSF0gaXJxY2hpcC9naWMtdjM6IENoZWNrIFNSRSBiaXQgZm9yIEdJQ3YyIGxlZ2FjeSBzdXBw
b3J0DQo+IA0KPiBTb3JyeSByZXNwb25zZSBsYXRlLg0KPiBIaSBTaGFtZWVyICYgQXJkLA0KPiAN
Cj4gQ291bGQgeW91IGxldCBtZSBrbm93IHdoaWNoIGZpcm13YXJlIHlvdSBhcmUgdXNpbmc/IElm
IHRoZSBkaWZmZXJlbmNlIGlzIE1hZHQNCj4gdGFibGUgdkdJQyB5b3VyIHBvaW50ZWQgLCB0aGV5
IGFyZSB0aGUgc2FtZS4gV2UgY2hhbmdlZCB0aGUgdkdJQyBtZW1vcnkNCj4gYmFzZSBhZGRyZXNz
IGF0IHZlcnkgZWFybHkgZGVzaWduIHN0YWdlLg0KPiANCj4gVGhhbmtz77yBDQo+IA0KPiAtLS0t
LemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9k
aQ0KPiDlj5HpgIHml7bpl7Q6IDIwMjDlubQxMuaciDLml6UgMTY6MjMNCj4g5pS25Lu25Lq6OiBB
cmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiDmioTpgIE6IE1hcmMgWnluZ2llciA8
bWF6QGtlcm5lbC5vcmc+OyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTGlu
dXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyB3YW5naHVpcWlhbmcgPHdhbmdodWlxaWFu
Z0BodWF3ZWkuY29tPjsgeHV3ZWkNCj4gKE8pIDx4dXdlaTVAaHVhd2VpLmNvbT4NCj4g5Li76aKY
OiBSRTogW1BBVENIXSBpcnFjaGlwL2dpYy12MzogQ2hlY2sgU1JFIGJpdCBmb3IgR0lDdjIgbGVn
YWN5IHN1cHBvcnQNCj4gDQo+IFsrXQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIFttYWlsdG86YXJkYkBrZXJuZWwub3JnXQ0KPiA+
IFNlbnQ6IDMwIE5vdmVtYmVyIDIwMjAgMTg6MzINCj4gPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IENjOiBN
YXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiA+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gPiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBpcnFjaGlwL2dpYy12MzogQ2hlY2sgU1JFIGJpdCBmb3IgR0lDdjIg
bGVnYWN5DQo+ID4gc3VwcG9ydA0KPiA+DQo+IC4uLg0KPiANCj4gPg0KPiA+IEFueSBjbHVlIHdo
eSBwcm9kdWN0aW9uIEQwNiBmaXJtd2FyZSBkZXZpYXRlcyBmcm9tIHRoZSBEMDYgcG9ydCB0aGF0
DQo+ID4gZXhpc3RzIGluIFRpYW5vY29yZSdzIGVkazItcGxhdGZvcm1zIHJlcG9zaXRvcnk/IEJl
Y2F1c2UgdGhhdCB2ZXJzaW9uDQo+ID4gZG9lcyBub3QgaGF2ZSB0aGlzIGJ1ZywgYW5kIEkgd29u
ZGVyIHdoeSB0aGF0IGNvZGUgd2FzIHVwc3RyZWFtZWQgYXQNCj4gPiBhbGwgaWYgYSBzdWJzdGFu
dGlhbGx5IGRpZmZlcmVudCB2ZXJzaW9uIGdldHMgc2hpcHBlZCB3aXRoIHByb2R1Y3Rpb24NCj4g
PiBoYXJkd2FyZS4NCj4gDQo+IE9rLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIGhh
dmUgaW5mb3JtZWQgb3VyIFVFRkkgdGVhbSBhYm91dCB0aGlzLg0KPiBUaGV5IHdpbGwgY2hlY2sg
SW50ZXJuYWxseSBhbmQgY2xhcmlmeS4NCj4gDQo+IFJlZ2FyZHMsDQo+IFNoYW1lZXINCg==
