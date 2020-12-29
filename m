Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9966E2E6FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL2LGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:06:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55379 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgL2LGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:06:51 -0500
X-UUID: 8a05a6fe1c26428b9092d125bb033018-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kBXEFHEYE3UKfnPdFHxODX9PA3xu0wCHnxHyXHF9dIY=;
        b=Si8UijRGBrB9rSlu49RKJzwWB5SjW5u/piNa/3eYvTymuU5/8ji2OKRDc7+uRuPL8S+cQWoRrPZbLdOV6IB46BBGELbQ1D94hMnxCNGZTVwH1N/2mJyiy331L+UJ6azeXcHa64DykBLBw6KKi0rRrFRbCgfUFcbl51JNsFUs+rg=;
X-UUID: 8a05a6fe1c26428b9092d125bb033018-20201229
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1241701737; Tue, 29 Dec 2020 19:06:03 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 19:06:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:06:01 +0800
Message-ID: <1609239960.26323.291.camel@mhfsdcap03>
Subject: Re: [PATCH v5 17/27] iommu/mediatek: Add pm runtime callback
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
Date:   Tue, 29 Dec 2020 19:06:00 +0800
In-Reply-To: <X+MAh87dFsY2p8vF@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-18-yong.wu@mediatek.com>
         <X+MAh87dFsY2p8vF@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6193CBCDE50237FB6220DACC2EDA79262E49C0591F513503724C7571B2EDA9F12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjMyICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NTJQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgcG0gcnVudGltZSBjYWxsYmFjay4NCj4gPiANCj4gPiBJbiBw
bSBydW50aW1lIGNhc2UsIGFsbCB0aGUgcmVnaXN0ZXJzIGJhY2t1cC9yZXN0b3JlIGFuZCBiY2xr
IGFyZQ0KPiA+IGNvbnRyb2xsZWQgaW4gdGhlIHBtX3J1bnRpbWUgY2FsbGJhY2ssIHRoZW4gcG1f
c3VzcGVuZCBpcyBub3QgbmVlZGVkIGluDQo+ID4gdGhpcyBjYXNlLg0KPiA+IA0KPiA+IHJ1bnRp
bWUgUE0gaXMgZGlzYWJsZWQgd2hlbiBzdXNwZW5kLCB0aHVzIHdlIGNhbGwNCj4gPiBwbV9ydW50
aW1lX3N0YXR1c19zdXNwZW5kZWQgaW5zdGVhZCBvZiBwbV9ydW50aW1lX3N1c3BlbmRlZC4NCj4g
PiANCj4gPiBBbmQsIG00dSBkb2Vzbid0IGhhdmUgaXRzIHNwZWNpYWwgcG0gcnVudGltZSBkb21h
aW4gaW4gcHJldmlvdXMgU29DLCBpbg0KPiA+IHRoaXMgY2FzZSBkZXYtPnBvd2VyLnJ1bnRpbWVf
c3RhdHVzIGlzIFJQTV9TVVNQRU5ERUQgZGVmYXVsdGx5LA0KPiANCj4gVGhpcyBzb3VuZHMgd3Jv
bmcgYW5kIGNvdWxkIGxlYWQgdG8gaGFyZCB0byBkZWJ1ZyBlcnJvcnMgd2hlbiB0aGUgZHJpdmVy
DQo+IGlzIGNoYW5nZWQgaW4gdGhlIGZ1dHVyZS4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gbWFr
ZSB0aGUgYmVoYXZpb3INCj4gY29uc2lzdGVudCBhY3Jvc3MgdGhlIFNvQ3MgaW5zdGVhZCwgc28g
dGhhdCBydW50aW1lIFBNIHN0YXR1cyBpcyBBQ1RJVkUNCj4gd2hlbiBuZWVkZWQsIGV2ZW4gb24g
U29DcyB3aXRob3V0IGFuIElPTU1VIFBNIGRvbWFpbj8NCg0KQXBwcmVjaWF0ZSB0aGUgcmV2aWV3
aW5nIHNvIGRldGFpbGx5Lg0KDQpJIGhhdmUgdGVzdGVkIHRoaXMuDQphKSBhbHdheXMgY2FsbCBw
bV9ydW50aW1lX2VuYWJsZS4NCmIpIGFsd2F5cyBhZGQgZGV2aWNlX2xpbmsgd2l0aCBzbWlfY29t
bW9uLg0KDQpUaGVuLCB0aGUgcnVudGltZSBQTSBzdGF0dXMgbWVldCBleHBlY3RhdGlvbi4gDQoN
CldlIGRvbid0IGNhbGwgcG1fcnVudGltZV9nZXRfc3luYyBzbyBvZnRlbiwgdGh1cywgd2UgZG9u
J3QgYWx3YXlzIHRvdWNoDQpkZXYtPnBvd2VyLmxvY2suIHRoaXMgaXMgb2sgZm9yIHVzLg0KDQpJ
IHdpbGwgdXNlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiB0aHVzIGFkZA0K
PiA+IGEgImRldi0+cG1fZG9tYWluIiBjaGVja2luZyBmb3IgdGhlIFNvQyB0aGF0IGhhcyBwbSBy
dW50aW1lIGRvbWFpbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8
IDIyICsrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gaW5kZXgg
NTYxNDAxNWU1Yjk2Li42ZmUzZWUyYjJiZjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBA
QCAtODA4LDcgKzgwOCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
LXN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiA+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9ydW50aW1l
X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXRrX2lv
bW11X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAgCXN0cnVjdCBtdGtf
aW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7DQo+ID4gQEAgLTgyNiw3ICs4MjYs
NyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9ydW50aW1lX3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAq
ZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICAJc3RydWN0IG10a19pb21tdV9zdXNw
ZW5kX3JlZyAqcmVnID0gJmRhdGEtPnJlZzsNCj4gPiBAQCAtODUzLDcgKzg1MywyNSBAQCBzdGF0
aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgX19tYXli
ZV91bnVzZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+
ID4gKwkvKiBydW50aW1lIFBNIGlzIGRpc2FibGVkIHdoZW4gc3VzcGVuZCBpbiBwbV9ydW50aW1l
IGNhc2UuICovDQo+ID4gKwlpZiAoZGV2LT5wbV9kb21haW4gJiYgcG1fcnVudGltZV9zdGF0dXNf
c3VzcGVuZGVkKGRldikpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG10
a19pb21tdV9ydW50aW1lX3N1c3BlbmQoZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gPiArew0KPiA+ICsJaWYgKGRldi0+cG1fZG9tYWluICYmIHBtX3J1bnRpbWVfc3RhdHVzX3N1
c3BlbmRlZChkZXYpKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXJldHVybiBtdGtf
aW9tbXVfcnVudGltZV9yZXN1bWUoZGV2KTsNCj4gPiArfQ0KPiANCj4gV291bGRuJ3QgaXQgYmUg
ZW5vdWdoIHRvIGp1c3QgdXNlIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZCgpIGFuZA0KPiBwbV9y
dW50aW1lX2ZvcmNlX3Jlc3VtZSgpIGFzIHN5c3RlbSBzbGVlcCBvcHM/DQoNCkFmdGVyIGFib3Zl
IHNvbHV0aW9uLCB0aGlzIGlzIG9rLg0KDQpUaGFua3MuDQo+IA0KPiA+ICsNCj4gPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIG10a19pb21tdV9wbV9vcHMgPSB7DQo+ID4gKwlTRVRf
UlVOVElNRV9QTV9PUFMobXRrX2lvbW11X3J1bnRpbWVfc3VzcGVuZCwgbXRrX2lvbW11X3J1bnRp
bWVfcmVzdW1lLCBOVUxMKQ0KPiA+ICAJU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9QTV9PUFMobXRr
X2lvbW11X3N1c3BlbmQsIG10a19pb21tdV9yZXN1bWUpDQo+ID4gIH07DQo+ID4gIA0KPiA+IC0t
IA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+ID4gaW9tbXUgbWFpbGluZyBsaXN0DQo+ID4gaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcNCj4gPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ0KDQo=

