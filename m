Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344212B3EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKPIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:42:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2063 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKPIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:42:29 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CZMxw0d7SzVpND;
        Mon, 16 Nov 2020 16:41:56 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 16 Nov 2020 16:42:17 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 16 Nov 2020 16:42:17 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Mon, 16 Nov 2020 16:42:17 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1h?=
 =?gb2312?Q?p_for_sparse_memory_model_that_define_VMEMMAP?=
Thread-Topic: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWcETlDVvjE2IvJkCQH2P2F6bPZqk7c02AgBr7NwCAdBE4gIAAh5EA
Date:   Mon, 16 Nov 2020 08:42:17 +0000
Message-ID: <f34d3387368a406582bce36627cdc29c@huawei.com>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com> <20200903120558.GB31409@gaia>
 <eacfa2bb19df4126a476566512d93dab@hisilicon.com>
In-Reply-To: <eacfa2bb19df4126a476566512d93dab@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.182.180.136]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhcnJ5DQoNCkkgaGF2ZSBjaGFuZ2VkIFNFQ1RJT05fU0laRV9CSVRTIHRvIDI3IGluIG91
ciBwcm9kdWN0cywgYnV0IEkgZG9uJ3QgaGF2ZSB0byBzdWJtaXQgaXQuDQoNCi0tLS0t08q8/tSt
vP4tLS0tLQ0Kt6K8/sjLOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIA0Kt6LLzcqxvOQ6IDIw
MjDE6jEx1MIxNsjVIDE2OjM0DQrK1bz+yMs6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJp
bmFzQGFybS5jb20+OyBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+OyBsaXdlaSAo
Q00pIDxsaXdlaTIxM0BodWF3ZWkuY29tPg0Ks63LzTogd2lsbEBrZXJuZWwub3JnOyBYaWFxaW5n
IChBKSA8c2FiZXJsaWx5LnhpYUBoaXNpbGljb24uY29tPjsgQ2hlbmZlbmcgKHB1Y2spIDxwdWNr
LmNoZW5AaGlzaWxpY29uLmNvbT47IGJ1dGFvIDxidXRhb0BoaXNpbGljb24uY29tPjsgZmVuZ2Jh
b3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsgbnNhZW56anVsaWVubmVAc3VzZS5k
ZTsgc3RldmUuY2FwcGVyQGFybS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkgPHN1anVuZmVpMkBo
aXNpbGljb24uY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQrW98ziOiBSRTog
W1BBVENIIHYyXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9y
eSBtb2RlbCB0aGF0IGRlZmluZSBWTUVNTUFQDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IENhdGFsaW4gTWFyaW5hcyBbbWFpbHRvOmNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tXQ0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciA0LCAyMDIwIDEyOjA2IEFNDQo+IFRv
OiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+IENjOiBsaXdlaSAoQ00pIDxs
aXdlaTIxM0BodWF3ZWkuY29tPjsgd2lsbEBrZXJuZWwub3JnOyBYaWFxaW5nIChBKSANCj4gPHNh
YmVybGlseS54aWFAaGlzaWxpY29uLmNvbT47IENoZW5mZW5nIChwdWNrKSANCj4gPHB1Y2suY2hl
bkBoaXNpbGljb24uY29tPjsgYnV0YW8gPGJ1dGFvQGhpc2lsaWNvbi5jb20+OyBmZW5nYmFvcGVu
ZyANCj4gPGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsgbnNhZW56anVsaWVubmVAc3VzZS5k
ZTsgDQo+IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIA0K
PiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN1anVuZmVpIDxz
dWp1bmZlaTJAaGlzaWxpY29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gYXJtNjQ6
IG1tOiBmcmVlIHVudXNlZCBtZW1tYXAgZm9yIHNwYXJzZSANCj4gbWVtb3J5IG1vZGVsIHRoYXQg
ZGVmaW5lIFZNRU1NQVANCj4gDQo+IE9uIE1vbiwgQXVnIDE3LCAyMDIwIGF0IDExOjA0OjA1QU0g
KzAzMDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+ID4gT24gV2VkLCBBdWcgMTIsIDIwMjAgYXQg
MDk6MDY6NTVBTSArMDgwMCwgV2VpIExpIHdyb3RlOg0KPiA+ID4gRm9yIHRoZSBtZW1vcnkgaG9s
ZSwgc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZQ0KPiBTUEFSU0VNRU1fVk1FTU1BUA0K
PiA+ID4gZG8gbm90IGZyZWUgdGhlIHJlc2VydmVkIG1lbW9yeSBmb3IgdGhlIHBhZ2UgbWFwLCB0
aGlzIHBhdGNoIGRvIGl0Lg0KPiA+DQo+ID4gSSd2ZSBiZWVuIHRoaW5raW5nIGFib3V0IGl0IGEg
Yml0IG1vcmUgYW5kIGl0IHNlZW1zIHRoYXQgaW5zdGVhZCBvZiANCj4gPiBmcmVlaW5nIHVudXNl
ZCBtZW1vcnkgbWFwIGl0IHdvdWxkIGJlIGJldHRlciB0byBhbGxvY2F0ZSB0aGUgZXhhY3QgDQo+
ID4gbWVtb3J5IG1hcCBmcm9tIHRoZSBiZWdpbm5pbmcuDQo+ID4NCj4gPiBJbiBzcGFyc2VfaW5p
dF9uaWQoKSB3ZSBjYW4gcmVwbGFjZSBQQUdFU19QRVJfU0VDVElPTiBwYXJhbWV0ZXIgdG8NCj4g
PiBfX3BvcHVsYXRlX3NlY3Rpb25fbWVtbWFwKCkgd2l0aCB0aGUgY2FsY3VsYXRlZCB2YWx1ZSBm
b3IgDQo+ID4gYXJjaGl0ZWN0dXJlcyB0aGF0IGRlZmluZSBIQVZFX0FSQ0hfUEZOX1ZBTElELg0K
PiANCj4gT3IganVzdCB1c2UgYSBzbWFsbGVyIFBBR0VTX1BFUl9TRUNUSU9OIGFuZCByZWR1Y2Ug
dGhlIHdhc3RlIDspLg0KPiANCj4gSnVzdCB0byBiZSBjbGVhciwgYXJlIHlvdSBzdWdnZXN0aW5n
IHRoYXQgd2Ugc2hvdWxkIHVzZSBwZm5fdmFsaWQoKSBvbiANCj4gdGhlIHBhZ2VzIHdpdGhpbiBh
IHNlY3Rpb24gdG8gY2FsY3VsYXRlIHRoZSBhY3R1YWwgcmFuZ2U/IFRoZQ0KPiBwZm5fdmFsaWQo
KSBpbXBsZW1lbnRhdGlvbiBvbiBhcm02NCBjaGVja3MgZm9yIHRoZSB2YWxpZGl0eSBvZiBhIA0K
PiBzcGFyc2Ugc2VjdGlvbiwgc28gdGhpcyB3b3VsZCBiZSBjYWxsZWQgZnJvbSB3aXRoaW4gdGhl
IHNwYXJzZV9pbml0KCkgDQo+IGNvZGUgcGF0aC4gSSBob3BlIHRoZXJlJ3Mgbm8gZGVwZW5kZW5j
eSBidXQgSSBoYXZlbid0IGNoZWNrZWQuIElmIGl0IA0KPiB3b3JrcywgaXQncyBmaW5lIGJ5IG1l
LCBpdCBzb2x2ZXMgdGhlIEZMQVRNRU0gbWVtX21hcCBmcmVlaW5nIGFzIHdlbGwuDQo+IA0KPiBX
aXRoIDRLQiBwYWdlcyBvbiBhcm02NCwgdm1lbW1hcF9wb3B1bGF0ZSgpIHN0b3BzIGF0IHRoZSBw
bWQgbGV2ZWwsIHNvIA0KPiBpdCBhbHdheXMgYWxsb2NhdGVzIFBNRF9TSVpFLiBXZWkncyBwYXRj
aCBhbHNvIG9ubHkgZnJlZXMgaW4gUE1EX1NJWkUgDQo+IGFtb3VudHMuIFNvLCB3aXRoIGEgc2l6
ZW9mKHN0cnVjdCBwYWdlKSBvZiA2NCAoMl42KSwgYSBQTURfU0laRSANCj4gbWVtX21hcCBzZWN0
aW9uIHdvdWxkIGNvdmVyIDJeKDIxLTYpIHBhZ2VzLCBzbyB0aGF0J3MgZXF1aXZhbGVudCB0byBh
IA0KPiBTRUNUSU9OX1NJWkVfQklUUyBvZiAyMS02KzEyID0gMjcuDQo+IA0KPiBJZiB3ZSByZWR1
Y2UgU0VDVElPTl9TSVpFX0JJVFMgdG8gMjcgb3IgbGVzcywgdGhpcyBwYXRjaCBpcyBhIG5vLW9w
Lg0KDQpJdCB3b3VsZCBiZSB0aGUgc2ltcGxlc3Qgd2F5IHRvIGZpeCB0aGlzIGlzc3VlLiBJdCBz
ZWVtcyBYODZfNjQgaXMgYWxzbyB1c2luZyAyNy4NCg0KQHdlaSwgaGFzIHlvdSBldmVyIHRyaWVk
IHRvIHNlbmQgYSBwYXRjaCB0byBjaGFuZ2UgU0VDVElPTl9TSVpFX0JJVFMgdG8gMjcgZm9yIEFS
TTY0Pw0KDQo+IA0KPiAtLQ0KPiBDYXRhbGluDQoNClRoYW5rcw0KQmFycnkNCg==
