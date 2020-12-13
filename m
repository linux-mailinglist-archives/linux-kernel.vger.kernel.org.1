Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1E2D90C5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 22:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406595AbgLMV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 16:28:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4115 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406401AbgLMV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:28:07 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CvHf04pRKzXmyg;
        Mon, 14 Dec 2020 05:26:48 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 14 Dec 2020 05:27:19 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 14 Dec 2020 05:27:19 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Mon, 14 Dec 2020 05:27:19 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Thread-Topic: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Thread-Index: AQHW0W2iIa3g+8k+H0GczkNg20i1Mqn1hbAg
Date:   Sun, 13 Dec 2020 21:27:19 +0000
Message-ID: <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
In-Reply-To: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.9]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3ZWl0
IFttYWlsdG86aGthbGx3ZWl0MUBnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIg
MTQsIDIwMjAgNTozMyBBTQ0KPiBUbzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBN
YXJlayBTenlwcm93c2tpDQo+IDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+OyBSb2JpbiBNdXJw
aHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgU29uZyBCYW8gSHVhDQo+IChCYXJyeSBTb25nKSA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+DQo+IENjOiBvcGVuIGxpc3Q6QU1EIElPTU1VIChB
TUQtVkkpIDxpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZz47IExpbnV4DQo+IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFtQQVRDSCB2Ml0gZG1hLW1hcHBpbmc6IGFkZCB1bmxpa2VseSBoaW50IGZvciBlcnJvciBwYXRo
IGluDQo+IGRtYV9tYXBwaW5nX2Vycm9yDQo+IA0KPiBaaWxsaW9ucyBvZiBkcml2ZXJzIHVzZSB0
aGUgdW5saWtlbHkoKSBoaW50IHdoZW4gY2hlY2tpbmcgdGhlIHJlc3VsdCBvZg0KPiBkbWFfbWFw
cGluZ19lcnJvcigpLiBUaGlzIGlzIGFuIGlubGluZSBmdW5jdGlvbiBhbnl3YXksIHNvIHdlIGNh
biBtb3ZlDQo+IHRoZSBoaW50IGludG8gdGhpcyBmdW5jdGlvbiBhbmQgcmVtb3ZlIGl0IGZyb20g
ZHJpdmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0
MUBnbWFpbC5jb20+DQoNCm5vdCBzdXJlIGlmIHRoaXMgaXMgcmVhbGx5IG5lY2Vzc2FyeS4gSXQg
c2VlbXMgdGhlIG9yaWdpbmFsIGNvZGUNCmlzIG1vcmUgcmVhZGFibGUuIFJlYWRlcnMgY2FuIG1v
cmUgZWFzaWx5IHVuZGVyc3RhbmQgd2UgYXJlDQpwcmVkaWN0aW5nIHRoZSBicmFuY2ggYmFzZWQg
b24gdGhlIHJldHVybiB2YWx1ZSBvZg0KZG1hX21hcHBpbmdfZXJyb3IoKS4NCg0KQW55d2F5LCBJ
IGRvbid0IG9iamVjdCB0byB0aGlzIG9uZS4gaWYgb3RoZXIgcGVvcGxlIGxpa2UgaXQsIEkgYW0N
CmFsc28gb2sgd2l0aCBpdC4NCg0KPiAtLS0NCj4gdjI6DQo+IFNwbGl0IHRoZSBiaWcgcGF0Y2gg
aW50byB0aGUgY2hhbmdlIGZvciBkbWEtbWFwcGluZy5oIGFuZCBmb2xsb3ctdXANCj4gcGF0Y2hl
cyBwZXIgc3Vic3lzdGVtIHRoYXQgd2lsbCBnbyB0aHJvdWdoIHRoZSB0cmVlcyBvZiB0aGUgcmVz
cGVjdGl2ZQ0KPiBtYWludGFpbmVycy4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2RtYS1tYXBw
aW5nLmggfCAyICstDQo+ICBrZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYyAgfCAyICstDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmggYi9pbmNsdWRlL2xpbnV4L2Rt
YS1tYXBwaW5nLmgNCj4gaW5kZXggMmU0OTk5NmE4Li42MTc3ZTIwYjUgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1t
YXBwaW5nLmgNCj4gQEAgLTk1LDcgKzk1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZG1hX21hcHBp
bmdfZXJyb3Ioc3RydWN0IGRldmljZSAqZGV2LA0KPiBkbWFfYWRkcl90IGRtYV9hZGRyKQ0KPiAg
ew0KPiAgCWRlYnVnX2RtYV9tYXBwaW5nX2Vycm9yKGRldiwgZG1hX2FkZHIpOw0KPiANCj4gLQlp
ZiAoZG1hX2FkZHIgPT0gRE1BX01BUFBJTkdfRVJST1IpDQo+ICsJaWYgKHVubGlrZWx5KGRtYV9h
ZGRyID09IERNQV9NQVBQSU5HX0VSUk9SKSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYyBi
L2tlcm5lbC9kbWEvbWFwX2JlbmNobWFyay5jDQo+IGluZGV4IGIxNDk2ZTc0NC4uOTAxNDIwYTVk
IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYw0KPiArKysgYi9rZXJu
ZWwvZG1hL21hcF9iZW5jaG1hcmsuYw0KPiBAQCAtNzgsNyArNzgsNyBAQCBzdGF0aWMgaW50IG1h
cF9iZW5jaG1hcmtfdGhyZWFkKHZvaWQgKmRhdGEpDQo+IA0KPiAgCQltYXBfc3RpbWUgPSBrdGlt
ZV9nZXQoKTsNCj4gIAkJZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShtYXAtPmRldiwgYnVmLCBQ
QUdFX1NJWkUsIG1hcC0+ZGlyKTsNCj4gLQkJaWYgKHVubGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9y
KG1hcC0+ZGV2LCBkbWFfYWRkcikpKSB7DQo+ICsJCWlmIChkbWFfbWFwcGluZ19lcnJvcihtYXAt
PmRldiwgZG1hX2FkZHIpKSB7DQo+ICAJCQlwcl9lcnIoImRtYV9tYXBfc2luZ2xlIGZhaWxlZCBv
biAlc1xuIiwNCj4gIAkJCQlkZXZfbmFtZShtYXAtPmRldikpOw0KPiAgCQkJcmV0ID0gLUVOT01F
TTsNCj4gLS0NCj4gMi4yOS4yDQoNClRoYW5rcw0KQmFycnkNCg0K
