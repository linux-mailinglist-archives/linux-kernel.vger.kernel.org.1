Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C982E6FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgL2LS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:18:29 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55392 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgL2LS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:18:28 -0500
X-UUID: a265345998e04ca4a2d32d1135c7a17d-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kjdDDsR62/sn1Fub2YpVwLbpjVry+o489WtdnLg/RPA=;
        b=j85CWewiMQm78U7KBaWow+N6gvruv4RDqU5o+zYFjQvgQHlSaobts6499n2kpyUKPLTMCUBZkO/WaE0cJUXtGHhBR7Oej8zqRzafS+7fuhf6srFdh1Z/MJcsyDUk67sR28wkFn6ekgzhhzZO1p8BP6yfFf3ao1z5HePR3bWAKqM=;
X-UUID: a265345998e04ca4a2d32d1135c7a17d-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1139923315; Tue, 29 Dec 2020 19:17:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 19:17:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:17:37 +0800
Message-ID: <1609240657.26323.298.camel@mhfsdcap03>
Subject: Re: [PATCH v5 09/27] iommu/io-pgtable-arm-v7s: Extend PA34 for
 MediaTek
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 29 Dec 2020 19:17:37 +0800
In-Reply-To: <X+L96uZU2aZWfjSP@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-10-yong.wu@mediatek.com>
         <X+L96uZU2aZWfjSP@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D8FBC57831CD7A85616D1A7462D4159D3B98DDE313D42CDF6FB3EC071BE3DD992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjIwICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NDRQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBNZWRpYVRlayBleHRlbmQgdGhlIGJpdDUgaW4gbHZsMSBhbmQgbHZsMiBkZXNjcmlwdG9y
IGFzIFBBMzQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+
ID4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgfCA5ICsrKysrKyst
LQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICAgICAgICAgIHwgMiArLQ0KPiA+ICBp
bmNsdWRlL2xpbnV4L2lvLXBndGFibGUuaCAgICAgICAgIHwgNCArKy0tDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9t
bXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCj4gPiBpbmRleCBlODgwNzQ1YWIxZTguLjRkMGFhMDc5
NDcwZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5j
DQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KPiA+IEBAIC0x
MTIsOSArMTEyLDEwIEBADQo+ID4gICNkZWZpbmUgQVJNX1Y3U19URVhfTUFTSwkJMHg3DQo+ID4g
ICNkZWZpbmUgQVJNX1Y3U19BVFRSX1RFWCh2YWwpCQkoKCh2YWwpICYgQVJNX1Y3U19URVhfTUFT
SykgPDwgQVJNX1Y3U19URVhfU0hJRlQpDQo+ID4gIA0KPiA+IC0vKiBNZWRpYVRlayBleHRlbmQg
dGhlIHR3byBiaXRzIGZvciBQQSAzMmJpdC8zM2JpdCAqLw0KPiA+ICsvKiBNZWRpYVRlayBleHRl
bmQgdGhlIGJpdHMgYmVsb3cgZm9yIFBBIDMyYml0LzMzYml0LzM0Yml0ICovDQo+ID4gICNkZWZp
bmUgQVJNX1Y3U19BVFRSX01US19QQV9CSVQzMglCSVQoOSkNCj4gPiAgI2RlZmluZSBBUk1fVjdT
X0FUVFJfTVRLX1BBX0JJVDMzCUJJVCg0KQ0KPiA+ICsjZGVmaW5lIEFSTV9WN1NfQVRUUl9NVEtf
UEFfQklUMzQJQklUKDUpDQo+ID4gIA0KPiA+ICAvKiAqd2VsbCwgZXhjZXB0IGZvciBURVggb24g
bGV2ZWwgMiBsYXJnZSBwYWdlcywgb2YgY291cnNlIDooICovDQo+ID4gICNkZWZpbmUgQVJNX1Y3
U19DT05UX1BBR0VfVEVYX1NISUZUCTYNCj4gPiBAQCAtMTk0LDYgKzE5NSw4IEBAIHN0YXRpYyBh
cm1fdjdzX2lvcHRlIHBhZGRyX3RvX2lvcHRlKHBoeXNfYWRkcl90IHBhZGRyLCBpbnQgbHZsLA0K
PiA+ICAJCXB0ZSB8PSBBUk1fVjdTX0FUVFJfTVRLX1BBX0JJVDMyOw0KPiA+ICAJaWYgKHBhZGRy
ICYgQklUX1VMTCgzMykpDQo+ID4gIAkJcHRlIHw9IEFSTV9WN1NfQVRUUl9NVEtfUEFfQklUMzM7
DQo+ID4gKwlpZiAocGFkZHIgJiBCSVRfVUxMKDM0KSkNCj4gPiArCQlwdGUgfD0gQVJNX1Y3U19B
VFRSX01US19QQV9CSVQzNDsNCj4gPiAgCXJldHVybiBwdGU7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
QEAgLTIxOCw2ICsyMjEsOCBAQCBzdGF0aWMgcGh5c19hZGRyX3QgaW9wdGVfdG9fcGFkZHIoYXJt
X3Y3c19pb3B0ZSBwdGUsIGludCBsdmwsDQo+ID4gIAkJcGFkZHIgfD0gQklUX1VMTCgzMik7DQo+
ID4gIAlpZiAocHRlICYgQVJNX1Y3U19BVFRSX01US19QQV9CSVQzMykNCj4gPiAgCQlwYWRkciB8
PSBCSVRfVUxMKDMzKTsNCj4gPiArCWlmIChwdGUgJiBBUk1fVjdTX0FUVFJfTVRLX1BBX0JJVDM0
KQ0KPiA+ICsJCXBhZGRyIHw9IEJJVF9VTEwoMzQpOw0KPiA+ICAJcmV0dXJuIHBhZGRyOw0KPiA+
ICB9DQo+ID4gIA0KPiA+IEBAIC03NTQsNyArNzU5LDcgQEAgc3RhdGljIHN0cnVjdCBpb19wZ3Rh
YmxlICphcm1fdjdzX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2ZnICpjZmcsDQo+
ID4gIAlpZiAoY2ZnLT5pYXMgPiBBUk1fVjdTX0FERFJfQklUUykNCj4gPiAgCQlyZXR1cm4gTlVM
TDsNCj4gPiAgDQo+ID4gLQlpZiAoY2ZnLT5vYXMgPiAoYXJtX3Y3c19pc19tdGtfZW5hYmxlZChj
ZmcpID8gMzQgOiBBUk1fVjdTX0FERFJfQklUUykpDQo+ID4gKwlpZiAoY2ZnLT5vYXMgPiAoYXJt
X3Y3c19pc19tdGtfZW5hYmxlZChjZmcpID8gMzUgOiBBUk1fVjdTX0FERFJfQklUUykpDQo+ID4g
IAkJcmV0dXJuIE5VTEw7DQo+ID4gIA0KPiA+ICAJaWYgKGNmZy0+cXVpcmtzICYgfihJT19QR1RB
QkxFX1FVSVJLX0FSTV9OUyB8DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gaW5kZXggNjQ1MWQ4Mzc1M2Ux
Li5lYzNjODdkNGIxNzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBAQCAtMzIwLDcgKzMy
MCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2RvbWFpbl9maW5hbGlzZShzdHJ1Y3QgbXRrX2lv
bW11X2RvbWFpbiAqZG9tKQ0KPiA+ICAJCQlJT19QR1RBQkxFX1FVSVJLX0FSTV9NVEtfRVhULA0K
PiA+ICAJCS5wZ3NpemVfYml0bWFwID0gbXRrX2lvbW11X29wcy5wZ3NpemVfYml0bWFwLA0KPiA+
ICAJCS5pYXMgPSAzMiwNCj4gPiAtCQkub2FzID0gMzQsDQo+ID4gKwkJLm9hcyA9IDM1LA0KPiAN
Cj4gU2hvdWxkbid0IHRoaXMgYmUgc2V0IGFjY29yZGluZyB0byB0aGUgcmVhbCBoYXJkd2FyZSBj
YXBhYmlsaXRpZXMsDQo+IGluc3RlYWQgb2YgYWx3YXlzIHNldHRpbmcgaXQgdG8gMzU/DQoNCkhl
cmUgb25seSBtYWtlIHRoZSBjb2RlIGNsZWFuLiAzNSBpcyBvayBmb3IgYWxsIHRoZSBTb0MuDQpC
dXQgeW91IGFyZSByaWdodCBmcm9tIHRoZSBIVyBwb2ludCwgdGhlIGxvZ2ljIGlzIGxpa2UgdGhp
czoNCg0KaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9E
RSkpDQoJZG9tLT5jZmcub2FzID0gZGF0YS0+ZW5hYmxlXzRHQiA/IDMzIDogMzI7DQplbHNlDQoJ
ZG9tLT5jZmcub2FzID0gMzU7DQoNCkkgd2lsbCB1c2UgdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gVG9tYXN6DQo+IA0KPiA+ICAJCS50bGIgPSAmbXRrX2lv
bW11X2ZsdXNoX29wcywNCj4gPiAgCQkuaW9tbXVfZGV2ID0gZGF0YS0+ZGV2LA0KPiA+ICAJfTsN
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pby1wZ3RhYmxlLmggYi9pbmNsdWRlL2xp
bnV4L2lvLXBndGFibGUuaA0KPiA+IGluZGV4IDRjZGUxMTFlNDI1Yi4uMWFlMDc1N2Y0Zjk0IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaW8tcGd0YWJsZS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9pby1wZ3RhYmxlLmgNCj4gPiBAQCAtNzcsOCArNzcsOCBAQCBzdHJ1Y3QgaW9f
cGd0YWJsZV9jZmcgew0KPiA+ICAJICoJVExCIG1haW50ZW5hbmNlIHdoZW4gbWFwcGluZyBhcyB3
ZWxsIGFzIHdoZW4gdW5tYXBwaW5nLg0KPiA+ICAJICoNCj4gPiAgCSAqIElPX1BHVEFCTEVfUVVJ
UktfQVJNX01US19FWFQ6IChBUk0gdjdzIGZvcm1hdCkgTWVkaWFUZWsgSU9NTVVzIGV4dGVuZA0K
PiA+IC0JICoJdG8gc3VwcG9ydCB1cCB0byAzNCBiaXRzIFBBIHdoZXJlIHRoZSBiaXQzMiBhbmQg
Yml0MzMgYXJlDQo+ID4gLQkgKgllbmNvZGVkIGluIHRoZSBiaXQ5IGFuZCBiaXQ0IG9mIHRoZSBQ
VEUgcmVzcGVjdGl2ZWx5Lg0KPiA+ICsJICoJdG8gc3VwcG9ydCB1cCB0byAzNSBiaXRzIFBBIHdo
ZXJlIHRoZSBiaXQzMiwgYml0MzMgYW5kIGJpdDM0IGFyZQ0KPiA+ICsJICoJZW5jb2RlZCBpbiB0
aGUgYml0OSwgYml0NCBhbmQgYml0NSBvZiB0aGUgUFRFIHJlc3BlY3RpdmVseS4NCj4gPiAgCSAq
DQo+ID4gIAkgKiBJT19QR1RBQkxFX1FVSVJLX05PTl9TVFJJQ1Q6IFNraXAgaXNzdWluZyBzeW5j
aHJvbm91cyBsZWFmIFRMQklzDQo+ID4gIAkgKglvbiB1bm1hcCwgZm9yIERNQSBkb21haW5zIHVz
aW5nIHRoZSBmbHVzaCBxdWV1ZSBtZWNoYW5pc20gZm9yDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+
ID4gDQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gPiBpb21tdSBtYWlsaW5nIGxpc3QNCj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZw0KPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11DQoNCg==

