Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2924F2FB6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbhASJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:47:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:49137 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732408AbhASJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:21:14 -0500
X-UUID: 6882229557a9407083bf28f726eeb973-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=giToPo/p/3LJytE3l2ogQIfAO4f4TZp/+5aQlKOr25k=;
        b=Q4PPqmPnYGluQfcENozOFI7ipi/dEF+cpBdSMBJRpT1MvfNM6GQPKN/LpzQwqRQW9w3OPLs3dV02NjDc2kgg1Or0dNjVE9qsA473HidhbMe2i2tS2nBnHwVhhu4oL+CGCUE+saC0SaOQMVgHN3iA8wl6Z4voPXz3JpLXjOfuUPI=;
X-UUID: 6882229557a9407083bf28f726eeb973-20210119
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1959994727; Tue, 19 Jan 2021 17:20:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 17:20:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 17:20:11 +0800
Message-ID: <1611048011.14702.6.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC:     Rob Herring <robh@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <anan.sun@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 19 Jan 2021 17:20:11 +0800
In-Reply-To: <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
         <20210111111914.22211-7-yong.wu@mediatek.com>
         <20210114192732.GA3401278@robh.at.kernel.org>
         <1610688626.4578.1.camel@mhfsdcap03>
         <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 20BEF15089BCBF56838670AF738616419DD03D4DB65FFC4A7D6595AC154756AB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTE4IGF0IDE1OjQ5ICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjEtMDEtMTUgMDU6MzAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIxLTAx
LTE0IGF0IDEzOjI3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPj4gT24gTW9uLCBKYW4g
MTEsIDIwMjEgYXQgMDc6MTg6NDdQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToNCj4gPj4+ICJkZXYt
PmRtYV9yYW5nZV9tYXAiIGNvbnRhaW5zIHRoZSBkZXZpY2VzJyBkbWFfcmFuZ2VzIGluZm9ybWF0
aW9uLA0KPiA+Pj4gVGhpcyBwYXRjaCBtb3ZlcyBkbWFfcmFuZ2VfbWFwIGJlZm9yZSBvZl9pb21t
dV9jb25maWd1cmUuIFRoZSBpb21tdQ0KPiA+Pj4gZHJpdmVyIG1heSBuZWVkIHRvIGtub3cgdGhl
IGRtYV9hZGRyZXNzIHJlcXVpcmVtZW50cyBvZiBpdHMgaW9tbXUNCj4gPj4+IGNvbnN1bWVyIGRl
dmljZXMuDQo+ID4+Pg0KPiA+Pj4gQ0M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
DQo+ID4+PiBDQzogRnJhbmsgUm93YW5kIDxmcm93YW5kLmxpc3RAZ21haWwuY29tPg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4+PiAtLS0N
Cj4gPj4+ICAgZHJpdmVycy9vZi9kZXZpY2UuYyB8IDMgKystDQo+ID4+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9vZi9kZXZpY2UuYyBiL2RyaXZlcnMvb2YvZGV2aWNlLmMNCj4gPj4+IGlu
ZGV4IGFlZGZhYWFmZDNlNy4uMWQ4NDYzNjE0OWRmIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVy
cy9vZi9kZXZpY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9vZi9kZXZpY2UuYw0KPiA+Pj4gQEAg
LTE3MCw5ICsxNzAsMTEgQEAgaW50IG9mX2RtYV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+Pj4gICAJZGV2X2RiZyhkZXYsICJkZXZp
Y2UgaXMlc2RtYSBjb2hlcmVudFxuIiwNCj4gPj4+ICAgCQljb2hlcmVudCA/ICIgIiA6ICIgbm90
ICIpOw0KPiA+Pj4gICANCj4gPj4+ICsJZGV2LT5kbWFfcmFuZ2VfbWFwID0gbWFwOw0KPiA+Pj4g
ICAJaW9tbXUgPSBvZl9pb21tdV9jb25maWd1cmUoZGV2LCBucCwgaWQpOw0KPiA+Pj4gICAJaWYg
KFBUUl9FUlIoaW9tbXUpID09IC1FUFJPQkVfREVGRVIpIHsNCj4gPj4+ICAgCQlrZnJlZShtYXAp
Ow0KPiA+Pj4gKwkJZGV2LT5kbWFfcmFuZ2VfbWFwID0gTlVMTDsNCj4gPj4NCj4gPj4gTm90IHJl
YWxseSBnb2luZyB0byBtYXR0ZXIsIGJ1dCB5b3Ugc2hvdWxkIHByb2JhYmx5IGNsZWFyIGRtYV9y
YW5nZV9tYXANCj4gPj4gYmVmb3JlIHdoYXQgaXQgcG9pbnRzIHRvIGlzIGZyZWVkLg0KPiA+Pg0K
PiA+PiBXaXRoIHRoYXQsDQo+ID4+DQo+ID4+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4gSSB3aWxsIG1v
dmUgaXQgYmVmb3JlICJrZnJlZShtYXApIiBpbiBuZXh0DQo+ID4gdmVyc2lvbi4NCj4gDQo+IFBh
dWwgbm90aWNlZCB0aGF0IHdlIGFscmVhZHkgaGF2ZSBhIGJ1ZyBpbiBhc3NpZ25pbmcgdG8gdGhp
cyANCj4gdW5jb25kaXRpb25hbGx5WzFdIC0gSSdkIHRvdGFsbHkgZm9yZ290dGVuIGFib3V0IHRo
aXMgc2VyaWVzIHdoZW4gSSANCj4gdGhlb3Jpc2VkIGFib3V0IElPTU1VIGRyaXZlcnMgd2FudGlu
ZyB0aGUgaW5mb3JtYXRpb24gZWFybGllciwgYnV0IA0KPiBzd2VlcGluZyBteSBpbmJveCBub3cg
b25seSBnb2VzIHRvIHNob3cgSSB3YXMgcmlnaHQgdG8gdGhpbmsgb2YgaXQgOikNCj4gDQo+IFdl
IHNob3VsZCByZWFsbHkgZ2V0IHNvbWV0aGluZyBpbiBhcyBhIGZpeCBpbmRlcGVuZGVudCBvZiB0
aGlzIHNlcmllcywgDQo+IHRha2luZyBib3RoIGFuZ2xlcyBpbnRvIGFjY291bnQuDQoNClRoYW5r
cyB0aGlzIGluZm8uIEZvbGxvd2luZyB5b3VyIHN1Z2dlc3Rpb24sIE1vdmUgdGhpcyBpbnRvIHRo
ZSAiaWYgKCENCnJldCkiLiBUaGVuIGl0IGlzIGxpa2UgdGhpczoNCg0KDQotLS0gYS9kcml2ZXJz
L29mL2RldmljZS5jDQorKysgYi9kcml2ZXJzL29mL2RldmljZS5jDQpAQCAtMTYzLDggKzE2Mywx
MCBAQCBpbnQgb2ZfZG1hX2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0K
ZGV2aWNlX25vZGUgKm5wLA0KIAlkZXYtPmNvaGVyZW50X2RtYV9tYXNrICY9IG1hc2s7DQogCSpk
ZXYtPmRtYV9tYXNrICY9IG1hc2s7DQogCS8qIC4uLmJ1dCBvbmx5IHNldCBidXMgbGltaXQgaWYg
d2UgZm91bmQgdmFsaWQgZG1hLXJhbmdlcyBlYXJsaWVyICovDQotCWlmICghcmV0KQ0KKwlpZiAo
IXJldCkgew0KIAkJZGV2LT5idXNfZG1hX2xpbWl0ID0gZW5kOw0KKwkJZGV2LT5kbWFfcmFuZ2Vf
bWFwID0gbWFwOw0KKwl9DQogDQogCWNvaGVyZW50ID0gb2ZfZG1hX2lzX2NvaGVyZW50KG5wKTsN
CiAJZGV2X2RiZyhkZXYsICJkZXZpY2UgaXMlc2RtYSBjb2hlcmVudFxuIiwNCkBAIC0xNzIsNiAr
MTc0LDggQEAgaW50IG9mX2RtYV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QNCmRldmljZV9ub2RlICpucCwNCiANCiAJaW9tbXUgPSBvZl9pb21tdV9jb25maWd1cmUoZGV2
LCBucCwgaWQpOw0KIAlpZiAoUFRSX0VSUihpb21tdSkgPT0gLUVQUk9CRV9ERUZFUikgew0KKwkJ
aWYgKCFyZXQpDQorCQkJZGV2LT5kbWFfcmFuZ2VfbWFwID0gTlVMTDsNCiAJCWtmcmVlKG1hcCk7
DQogCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCiAJfQ0KQEAgLTE4MSw3ICsxODUsNiBAQCBpbnQg
b2ZfZG1hX2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KZGV2aWNlX25v
ZGUgKm5wLA0KIA0KIAlhcmNoX3NldHVwX2RtYV9vcHMoZGV2LCBkbWFfc3RhcnQsIHNpemUsIGlv
bW11LCBjb2hlcmVudCk7DQogDQotCWRldi0+ZG1hX3JhbmdlX21hcCA9IG1hcDsNCiAJcmV0dXJu
IDA7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKG9mX2RtYV9jb25maWd1cmVfaWQpOw0KDQoNCklm
IHRoaXMgaXMgb2ssIEkgd2lsbCBzZW5kIHRoaXMgYXMgYSBpbmRlcGVuZGVudCBwYXRjaC4NCg0K
PiANCj4gUm9iaW4uDQo+IA0KPiBbMV0gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWFybS1rZXJuZWwvNWM3OTQ2ZjMtYjU2ZS1kYTAwLWE3NTAtYmUwOTdjN2NlYjMyQGFybS5jb20v
DQo+IA0KPiA+Pg0KPiA+Pj4gICAJCXJldHVybiAtRVBST0JFX0RFRkVSOw0KPiA+Pj4gICAJfQ0K
PiA+Pj4gICANCj4gPj4+IEBAIC0xODEsNyArMTgzLDYgQEAgaW50IG9mX2RtYV9jb25maWd1cmVf
aWQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiA+Pj4gICAN
Cj4gPj4+ICAgCWFyY2hfc2V0dXBfZG1hX29wcyhkZXYsIGRtYV9zdGFydCwgc2l6ZSwgaW9tbXUs
IGNvaGVyZW50KTsNCj4gPj4+ICAgDQo+ID4+PiAtCWRldi0+ZG1hX3JhbmdlX21hcCA9IG1hcDsN
Cj4gPj4+ICAgCXJldHVybiAwOw0KPiA+Pj4gICB9DQo+ID4+PiAgIEVYUE9SVF9TWU1CT0xfR1BM
KG9mX2RtYV9jb25maWd1cmVfaWQpOw0KPiA+Pj4gLS0gDQo+ID4+PiAyLjE4LjANCj4gPj4+DQo+
ID4gDQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gPiBpb21tdSBtYWlsaW5nIGxpc3QNCj4gPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZw0KPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11DQo+ID4gDQoNCg==

