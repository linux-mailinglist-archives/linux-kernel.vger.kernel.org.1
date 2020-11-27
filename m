Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40E62C6001
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392527AbgK0GVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:21:18 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389247AbgK0GVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:21:18 -0500
X-UUID: 7fd33999d69d4e238b17a63a32a1ba34-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gWFqjIgZJcUQlxaxqF4KJOYrIr+kx5lZqVQTXm3WVxc=;
        b=qLRFbRucTIUtSK5qJesPIKLwZiHsaN99MkV2RYurS1zhc5QWY7DsLjpZMeuS/DB85ANJPnOsrh0znFKHjm/pqP3zHCeBD7e6JTJrKMXSWnDnYC3//8MlK/anA2zdoHztR+9m/jKPHelTrVkZQ8jOJ8i6ZujvRXTiCUBJET99jUw=;
X-UUID: 7fd33999d69d4e238b17a63a32a1ba34-20201127
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 510553537; Fri, 27 Nov 2020 14:21:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 14:21:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:21:02 +0800
Message-ID: <1606458063.26323.190.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 27 Nov 2020 14:21:03 +0800
In-Reply-To: <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
         <cbc9763b-aa7e-aea9-2a21-315dfdd2c407@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8385ECAE0D6D3223BDD513D2FBE4AE4F466D2488E98D903708BC01BA7A1574042000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDE1OjE5ICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTEtMjAgMDk6MDYsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gQ3VycmVudGx5IGRpcmVj
dF9tYXBwaW5nIGFsd2F5cyB1c2UgdGhlIHNtYWxsZXN0IHBnc2l6ZSB3aGljaCBpcyBTWl80Sw0K
PiA+IG5vcm1hbGx5IHRvIG1hcHBpbmcuIFRoaXMgaXMgdW5uZWNlc3NhcnkuIHdlIGNvdWxkIGdh
dGhlciB0aGUgc2l6ZSwgYW5kDQo+ID4gY2FsbCBpb21tdV9tYXAgdGhlbiwgaW9tbXVfbWFwIGNv
dWxkIGRlY2lkZSBob3cgdG8gbWFwIGJldHRlciB3aXRoIHRoZQ0KPiA+IGp1c3QgcmlnaHQgcGdz
aXplLg0KPiA+IA0KPiA+ICBGcm9tIHRoZSBvcmlnaW5hbCBjb21tZW50LCB3ZSBzaG91bGQgdGFr
ZSBjYXJlIG92ZXJsYXAsIG90aGVyd2lzZSwNCj4gPiBpb21tdV9tYXAgbWF5IHJldHVybiAtRUVY
SVNULiBJbiB0aGlzIG92ZXJsYXAgY2FzZSwgd2Ugc2hvdWxkIG1hcCB0aGUNCj4gPiBwcmV2aW91
cyByZWdpb24gYmVmb3JlIG92ZXJsYXAgZmlyc3RseS4gdGhlbiBtYXAgdGhlIGxlZnQgcGFydC4N
Cj4gPiANCj4gPiBFYWNoIGEgaW9tbXUgZGV2aWNlIHdpbGwgY2FsbCB0aGlzIGRpcmVjdF9tYXBw
aW5nIHdoZW4gaXRzIGlvbW11DQo+ID4gaW5pdGlhbGl6ZSwgVGhpcyBwYXRjaCBpcyBlZmZlY3Rp
dmUgdG8gaW1wcm92ZSB0aGUgYm9vdC9pbml0aWFsaXphdGlvbg0KPiA+IHRpbWUgZXNwZWNpYWxs
eSB3aGlsZSBpdCBvbmx5IG5lZWRzIGxldmVsIDEgbWFwcGluZy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmFuIFN1biA8YW5hbi5zdW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9pb21tdS9pb21tdS5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4g
PiBpbmRleCBkZjg3YzhlODI1ZjcuLjg1NGE4ZmNiOTI4ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2lvbW11L2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCj4gPiBA
QCAtNzM3LDYgKzczNyw3IEBAIHN0YXRpYyBpbnQgaW9tbXVfY3JlYXRlX2RldmljZV9kaXJlY3Rf
bWFwcGluZ3Moc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwNCj4gPiAgIAkvKiBXZSBuZWVkIHRv
IGNvbnNpZGVyIG92ZXJsYXBwaW5nIHJlZ2lvbnMgZm9yIGRpZmZlcmVudCBkZXZpY2VzICovDQo+
ID4gICAJbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJm1hcHBpbmdzLCBsaXN0KSB7DQo+ID4g
ICAJCWRtYV9hZGRyX3Qgc3RhcnQsIGVuZCwgYWRkcjsNCj4gPiArCQlzaXplX3QgdW5tYXBwZWRf
c3ogPSAwOw0KPiA+ICAgDQo+ID4gICAJCWlmIChkb21haW4tPm9wcy0+YXBwbHlfcmVzdl9yZWdp
b24pDQo+ID4gICAJCQlkb21haW4tPm9wcy0+YXBwbHlfcmVzdl9yZWdpb24oZGV2LCBkb21haW4s
IGVudHJ5KTsNCj4gPiBAQCAtNzUyLDEwICs3NTMsMjUgQEAgc3RhdGljIGludCBpb21tdV9jcmVh
dGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLA0KPiA+
ICAgCQkJcGh5c19hZGRyX3QgcGh5c19hZGRyOw0KPiA+ICAgDQo+ID4gICAJCQlwaHlzX2FkZHIg
PSBpb21tdV9pb3ZhX3RvX3BoeXMoZG9tYWluLCBhZGRyKTsNCj4gPiAtCQkJaWYgKHBoeXNfYWRk
cikNCj4gPiArCQkJaWYgKHBoeXNfYWRkciA9PSAwKSB7DQo+ID4gKwkJCQl1bm1hcHBlZF9zeiAr
PSBwZ19zaXplOyAvKiBHYXRoZXIgdGhlIHNpemUuICovDQo+ID4gICAJCQkJY29udGludWU7DQo+
ID4gKwkJCX0NCj4gDQo+IEkgZ3Vlc3MgdGhlIHJlYXNvbiB3ZSBuZWVkIHRvIHZhbGlkYXRlIGV2
ZXJ5IHBhZ2UgaXMgYmVjYXVzZSB0aGV5IG1heSANCj4gYWxyZWFkeSBoYXZlIGJlZW4gbGVnaXRp
bWF0ZWx5IG1hcHBlZCBpZiBzb21lb25lIGVsc2UncyByZXNlcnZlZCByZWdpb24gDQo+IG92ZXJs
YXBzIC0gaXMgaXQgd29ydGggZXhwbGljaXRseSB2YWxpZGF0aW5nIHRoYXQsIGkuZS4gYmFpbCBv
dXQgaWYgDQo+IHNvbWV0aGluZydzIGdvbmUgd3JvbmcgZW5vdWdoIHRoYXQgcGh5c19hZGRyICE9
IGFkZHI/DQoNCkknbSBub3Qgc3VyZSB0aGUgaGlzdG9yeSBhYm91dCB3aHkgdG8gdmFsaWRhdGUg
ZXZlcnkgcGFnZS4gdGhpcw0KZGlyZWN0X21hcHBpbmcgaXMgY2FsbGVkIHZlcnkgZWFybHksIG5v
cm1hbGx5IGFmdGVyIGFsbG9jX2RlZmF1bHRfZG9tYWluDQphbmQgX2F0dGFjaF9kZXZpY2UuIHRo
ZSAicGh5c19hZGRyICE9IGFkZHIiIGxvb2tzIGltcG9zc2libGUuDQoNCklmIHRoZXJlIGlzIGEg
bm9ybWFsIGZsb3cgdGhhdCBtYXkgY2F1c2UgInBoeXNfYWRkciAhPSBhZGRyIiwgdGhlbg0Kc29t
ZXRoaW5nIGdvIHdyb25nLCBDb3VsZCB3ZSBnaXZlIGEgd2FybmluZyBsaWtlIGFkZGluZyBhDQpX
QVJOX09OX09OQ0UocGh5c19hZGRyICE9IGFkZHIpPyBhbmQgaXQgc2hvdWxkIGJlIGluIGEgYW5v
dGhlciBwYXRjaC4NCg0KPiANCj4gT3RoZXIgdGhhbiB0aGUgbmFtaW5nIGlzc3VlIChJIGFncmVl
IHRoYXQgbWFwX3NpemUgaXMgYSBmYXIsIGZhciBiZXR0ZXIgDQo+IGNob2ljZSksIEkgZG9uJ3Qg
aGF2ZSBhbnkgc3Ryb25nIG9waW5pb25zIGFib3V0IHRoZSByZXN0IG9mIHRoZSANCj4gaW1wbGVt
ZW50YXRpb24gLSBJJ3ZlIHdyaXR0ZW4gZW5vdWdoIHZhcmlhdGlvbnMgb2YgdGhpcyBwYXR0ZXJu
IHRvIGtub3cgDQo+IHRoYXQgdGhlcmUncyBqdXN0IG5vICJuaWNlIiB3YXkgdG8gZG8gaXQgaW4g
QzsgYWxsIHlvdSBjYW4gZG8gaXMgc2h1ZmZsZSANCj4gdGhlIGNsdW5raW5lc3MgYXJvdW5kIDop
DQoNCjopLiBJIHdpbGwgc2VuZCBhIHYyLg0KVGhhbmtzLg0KDQo+IA0KPiBSb2Jpbi4NCj4gDQo+
ID4gICANCj4gPiAtCQkJcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgYWRkciwgYWRkciwgcGdfc2l6
ZSwgZW50cnktPnByb3QpOw0KPiA+ICsJCQlpZiAodW5tYXBwZWRfc3opIHsNCj4gPiArCQkJCS8q
IE1hcCB0aGUgcmVnaW9uIGJlZm9yZSB0aGUgb3ZlcmxhcC4gKi8NCj4gPiArCQkJCXJldCA9IGlv
bW11X21hcChkb21haW4sIHN0YXJ0LCBzdGFydCwNCj4gPiArCQkJCQkJdW5tYXBwZWRfc3osIGVu
dHJ5LT5wcm90KTsNCj4gPiArCQkJCWlmIChyZXQpDQo+ID4gKwkJCQkJZ290byBvdXQ7DQo+ID4g
KwkJCQlzdGFydCArPSB1bm1hcHBlZF9zejsNCj4gPiArCQkJCXVubWFwcGVkX3N6ID0gMDsNCj4g
PiArCQkJfQ0KPiA+ICsJCQlzdGFydCArPSBwZ19zaXplOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAo
dW5tYXBwZWRfc3opIHsNCj4gPiArCQkJcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgc3RhcnQsIHN0
YXJ0LCB1bm1hcHBlZF9zeiwNCj4gPiArCQkJCQllbnRyeS0+cHJvdCk7DQo+ID4gICAJCQlpZiAo
cmV0KQ0KPiA+ICAgCQkJCWdvdG8gb3V0Ow0KPiA+ICAgCQl9DQo+ID4gDQo+IA0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRl
ayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVr
DQoNCg==

