Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8968D2E6FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgL2LDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:03:20 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:15633 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbgL2LDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:03:19 -0500
X-UUID: 68d9bcd55862430491e5a0946e429603-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+tQiRgFVs1ecSRTznh8zWZJajSaxb1w3A0hIkVSyae4=;
        b=n/UI6MboHADW2FQSsUHlHdjWIrXq+Sxe5kdG/k6qclB8szLc/DbiUfqpWOo69QgmuHvy2sCCXdSXRKinxGTlVqIPk80mL0I6yAo/jjvPcJQqn021vwGuKzKOfqBo1eTTDK5YK+Gx68pJ+272vloCV/Lel4XN1p1pARwl/1KmNLY=;
X-UUID: 68d9bcd55862430491e5a0946e429603-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1009512425; Tue, 29 Dec 2020 19:02:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 19:01:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:00:20 +0800
Message-ID: <1609239620.26323.288.camel@mhfsdcap03>
Subject: Re: [PATCH v5 15/27] iommu/mediatek: Add fail handle for sysfs_add
 and device_register
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
Date:   Tue, 29 Dec 2020 19:00:20 +0800
In-Reply-To: <X+L+97OBxC6I5pUv@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-16-yong.wu@mediatek.com>
         <X+L+97OBxC6I5pUv@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9BAE3647D5E474D2917586CBBFB4911DB1B0897182843908B89A805325F57F062000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjI1ICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NTBQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBBZGQgZmFpbCBoYW5kbGUgZm9yIGlvbW11X2RldmljZV9zeXNmc19hZGQgYW5kIGlvbW11
X2RldmljZV9yZWdpc3Rlci4NCj4gPiANCj4gPiBGaXhlczogYjE2YzAxNzBiNTNjICgiaW9tbXUv
bWVkaWF0ZWs6IE1ha2UgdXNlIG9mIGlvbW11X2RldmljZV9yZWdpc3RlciBpbnRlcmZhY2UiKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCAzOTQ3OGNmYmUwZjEuLjA5YzhjNThmZWI3OCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC03NDYsNyArNzQ2LDcgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgDQo+ID4g
IAlyZXQgPSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoJmRhdGEtPmlvbW11KTsNCj4gPiAgCWlmIChy
ZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCQlnb3RvIG91dF9zeXNmc19yZW1vdmU7DQo+
ID4gIA0KPiA+ICAJc3Bpbl9sb2NrX2luaXQoJmRhdGEtPnRsYl9sb2NrKTsNCj4gPiAgCWxpc3Rf
YWRkX3RhaWwoJmRhdGEtPmxpc3QsICZtNHVsaXN0KTsNCj4gPiBAQCAtNzU0LDcgKzc1NCwxNiBA
QCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAJaWYgKCFpb21tdV9wcmVzZW50KCZwbGF0Zm9ybV9idXNfdHlwZSkpDQo+ID4gIAkJ
YnVzX3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsICZtdGtfaW9tbXVfb3BzKTsNCj4gPiAg
DQo+ID4gLQlyZXR1cm4gY29tcG9uZW50X21hc3Rlcl9hZGRfd2l0aF9tYXRjaChkZXYsICZtdGtf
aW9tbXVfY29tX29wcywgbWF0Y2gpOw0KPiA+ICsJcmV0ID0gY29tcG9uZW50X21hc3Rlcl9hZGRf
d2l0aF9tYXRjaChkZXYsICZtdGtfaW9tbXVfY29tX29wcywgbWF0Y2gpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlnb3RvIG91dF9kZXZfdW5yZWc7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArb3V0X2Rldl91bnJlZzoNCj4gDQo+IFNob3VsZG4ndCBvdGhlciBvcGVyYXRpb25zIGJl
IHVuZG9uZSBhcyB3ZWxsPyBJIGNhbiBzZWUgdGhhdCBhYm92ZQ0KPiBidXNfc2V0X2lvbW11KCkg
aXMgc2V0IGFuZCBhbiBlbnRyeSBpcyBhZGRlZCB0byBtNHVsaXN0Lg0KDQpPaC4gWWVzLiBJIHdp
bGwgYWRkIHRoZW0uIGFuZCByZW1vdmUgdGhlIGZpeGVzIHRhZyBzaW5jZSB0aGV5IGFyZSBub3QN
CmludHJvZHVjZWQgYnkgaXQuIHRoZXNlIGVycm9yIGhhbmRsZSBhcmUgbm90IGFkZGVkIGluIHRo
ZSBmaXJzdCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsJaW9tbXVfZGV2aWNlX3VucmVnaXN0ZXIoJmRh
dGEtPmlvbW11KTsNCj4gPiArb3V0X3N5c2ZzX3JlbW92ZToNCj4gPiArCWlvbW11X2RldmljZV9z
eXNmc19yZW1vdmUoJmRhdGEtPmlvbW11KTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gIH0NCj4g
PiAgDQo+ID4gIHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gaW9tbXUgbWFpbGluZyBsaXN0
DQo+ID4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gPiBodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ0KDQo=

