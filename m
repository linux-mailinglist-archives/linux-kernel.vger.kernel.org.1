Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA42C6008
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 07:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392561AbgK0GXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:23:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28946 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389406AbgK0GXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:23:22 -0500
X-UUID: 1c604bebc27747fa8bfd2f20124312cf-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OMqcICORIcAhhkjnMDt3nLKuOy2OfxolaCABKDolAkc=;
        b=Ug/+xYELIK6kMlj3IIsEmoYCFqKuOLS6MwmyAURs1j9HDn6ltMCkA2jVyMZgFqEJyoN9g226OXa2a5V+TS02GlUMopl2T4iOOXAeFlEyN5khfsfH91I2DE9ILyUIg9ZpJOEYXhPUWgsF1lrUuJHNfsmbZXQL8pL11yy7fLGvL1s=;
X-UUID: 1c604bebc27747fa8bfd2f20124312cf-20201127
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1465978574; Fri, 27 Nov 2020 14:23:16 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 14:23:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:23:13 +0800
Message-ID: <1606458194.26323.193.camel@mhfsdcap03>
Subject: Re: [PATCH v4 12/24] iommu/mediatek: Move hw_init into attach_device
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 27 Nov 2020 14:23:14 +0800
In-Reply-To: <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
         <20201111123838.15682-13-yong.wu@mediatek.com>
         <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8E4E74E78C2C0A3F2DB182D6E5EF394369AE6F486379FA945EA54C8360F9A0862000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDE2OjQzICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTEtMTEgMTI6MzgsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gSW4gYXR0YWNoIGRldmlj
ZSwgaXQgd2lsbCB1cGRhdGUgdGhlIHBhZ2V0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIuDQo+
ID4gTW92ZSB0aGUgaHdfaW5pdCBmdW5jdGlvbiBhbHNvIGhlcmUuIFRoZW4gaXQgb25seSBuZWVk
IGNhbGwNCj4gPiBwbV9ydW50aW1lX2dldC9wdXQgb25lIHRpbWUgaGVyZSBpZiBtNHUgaGFzIHBv
d2VyIGRvbWFpbi4NCj4gDQo+IERvZXNuJ3QgdGhhdCBtZWFuIHlvdSdsbCBlbmQgdXAgd3JpdGlu
ZyBtb3N0IG9mIHRoZSByZWdpc3RlcnMgdHdpY2UgDQo+IGV2ZXJ5IHRpbWU/IChmaXJzdCBmcm9t
IG10a19pb21tdV9yZXN1bWUoKSwgdGhlbiBhZ2FpbiBmcm9tIA0KPiBtdGtfaW9tbXVfaHdfaW5p
dCgpKQ0KDQpJIGhhdmUgc2tpcHBlZCB0aGUgZmlyc3QgcmVzdW1lIGZyb20gbXRrX2lvbW11X3Jl
c3VtZSB3aXRoIHRoZSBjb2RlIGluDQpbMTUvMjRdOg0KDQpAQCAtODI4LDYgKzg0OCw5IEBAIHN0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQNCm10a19pb21tdV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQoNCisvKiBBdm9pZCBmaXJzdCByZXN1bWUgdG8gYWZmZWN0IHRoZSBkZWZh
dWx0IHZhbHVlIG9mIHJlZ2lzdGVycyBiZWxvdy4qLw0KK2lmICghbTR1X2RvbSkNCisgICByZXR1
cm4gMDsNCg0KPiBJdCBtaWdodCBiZSBuZWF0ZXIgdG8gaGF2ZSBtdGtfaW9tbXVfaHdfaW5pdCgp
IHNpbXBseSBwb3B1bGF0ZSB0aGUgDQo+IG10a19pb21tdV9zdXNwZW5kX3JlZyBkYXRhIHdpdGgg
dGhlIGluaXRpYWwgdmFsdWVzIGF0IHByb2JlIHRpbWUgYW5kIA0KPiBtYW51YWxseSBjYWxsIG10
a19pb21tdV9yZXN1bWUoKSBpZiB0aGUgaGFyZHdhcmUgaXMgYWxyZWFkeSBwb3dlcmVkIHVwIA0K
PiBhdCB0aGF0IHBvaW50LiBPciBtYXliZSBqdXN0IGRvbid0IGJvdGhlciBzYXZpbmcgdGhvc2Ug
cmVnaXN0ZXJzIG9uIA0KDQpZZXMuIEFsbCB0aGUgcG93ZXItZG9tYWlucyBhcmUgZW5hYmxlZCBp
biBsayB3aGVuIGJvb3R1cC4NCg0KQWN0dWFsbHkgSSBoYXZlIHBsYW4gdG8gcmVtb3ZlIHRoZSBw
bV9ydW50aW1lX2dldCBpbiB0aGlzIGF0dGFjaF9kZXZpY2UNCmluIHRoZSBsYXRlciBwYXRjaHNl
dC4NCg0KVGhpcyBpcyBmb3IgZml4aW5nIGEgaXNzdWUgdGhhdCB0aGUgc2NyZWVuIGlzIHR1cm5l
ZCBvZmYgd2hlbiBib290dXAuDQpJbiBhbmRyb2lkIHByb2plY3QuIHdlIGFsd2F5cyBzaG93IGJv
b3QgaW1hZ2UuIElmIGlvbW11IGNhbGwNCnBtX3J1bnRpbWVfZ2V0L3B1dCBoZXJlLCB0aGUgZGlz
cGxheSBwb3dlci1kb21haW4gd2lsbCBiZSB0dXJuZWQgb2ZmDQpoZXJlIGdpdmVuIHRoYXQgaW9t
bXUgYWx3YXlzIHByb2JlIGJlZm9yZSBkaXNwbGF5IGRyaXZlcnMgYW5kIGlvbW11J3MNCnBvd2Vy
LWRvbWFpbiBhbHdheXMgaXMgZGlzcGxheSdzIHBvd2VyLWRvbWFpbi4NCg0KRXZlbiBJIHBsYW4g
dG8gbW92ZSB0aGUgZGV2aWNlJ3MgcG1fcnVudGltZV9lbmFibGUgaW50byB0aGlzDQphdHRhY2hf
ZGV2aWNlIGluIHRoZSBjYXNlIGFsbCB0aGUgZHJpdmVycyhpb21tdSBhbmQgZGlzcGxheS4uLikg
YnVpbGQgYXMNCm1vZHVsZXMuIGl0IGlzIGZvciBza2lwcGluZyB0dXJuIG9mZiBkaXNwbGF5J3Mg
cG93ZXItZG9tYWluIGluDQpnZW5wZF9wb3dlcl9vZmZfdW51c2VkLg0KDQpUaGlzIGlzIG9ubHkg
YSBwbGFuLCBJJ20gbm90IHN1cmUgaWYgcG93ZXItZG9tYWluIGNvdWxkIGZpeCBpdCBsaWtlWzFd
Lg0KDQpJbiB0aGlzIHBhdGNoc2V0LCBJJ2QgbGlrZSB0byBrZWVwIGN1cnJlbnQgc3RhdHVzLg0K
DQpbMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1jbGsvcGF0
Y2gvMjAxOTA2MzAxNTAyMzAuNzg3OC0zLXJvYmRjbGFya0BnbWFpbC5jb20vDQoNCj4gc3VzcGVu
ZCBhbmQgcHV0IHRoZSBpbml0aWFsaXNhdGlvbiBkaXJlY3RseSBpbiB0aGUgcmVzdW1lIHBhdGgu
DQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwg
MTAgKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCA1NWY5YjMyOWU2Mzcu
LmNmZGY1Y2U2OTZmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0xMjUsNiArMTI1
LDggQEAgc3RydWN0IG10a19pb21tdV9kb21haW4gew0KPiA+ICAgDQo+ID4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzOw0KPiA+ICAgDQo+ID4gK3N0YXRpYyBp
bnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKTsN
Cj4gPiArDQo+ID4gICAvKg0KPiA+ICAgICogSW4gTTRVIDRHQiBtb2RlLCB0aGUgcGh5c2ljYWwg
YWRkcmVzcyBpcyByZW1hcHBlZCBhcyBiZWxvdzoNCj4gPiAgICAqDQo+ID4gQEAgLTM4MCwxMiAr
MzgyLDE2IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2F0dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluLA0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAq
ZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KPiA+ICAgCXN0cnVjdCBtdGtfaW9tbXVf
ZG9tYWluICpkb20gPSB0b19tdGtfZG9tYWluKGRvbWFpbik7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
ICAgDQo+ID4gICAJaWYgKCFkYXRhKQ0KPiA+ICAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiAgIA0K
PiA+ICAgCS8qIFVwZGF0ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhl
IE00VSBIVyAqLw0KPiA+ICAgCWlmICghZGF0YS0+bTR1X2RvbSkgew0KPiA+ICsJCXJldCA9IG10
a19pb21tdV9od19pbml0KGRhdGEpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiBy
ZXQ7DQo+ID4gICAJCWRhdGEtPm00dV9kb20gPSBkb207DQo+ID4gICAJCXdyaXRlbChkb20tPmNm
Zy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FERFJfTUFTSywNCj4gPiAgIAkJICAgICAgIGRh
dGEtPmJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQo+ID4gQEAgLTcyOSwxMCArNzM1LDYg
QEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPiAgIA0KPiA+ICAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRhdGEpOw0KPiA+
ICAgDQo+ID4gLQlyZXQgPSBtdGtfaW9tbXVfaHdfaW5pdChkYXRhKTsNCj4gPiAtCWlmIChyZXQp
DQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiAtDQo+ID4gICAJcmV0ID0gaW9tbXVfZGV2aWNlX3N5
c2ZzX2FkZCgmZGF0YS0+aW9tbXUsIGRldiwgTlVMTCwNCj4gPiAgIAkJCQkgICAgICJtdGstaW9t
bXUuJXBhIiwgJmlvYWRkcik7DQo+ID4gICAJaWYgKHJldCkNCj4gPiANCg0K

