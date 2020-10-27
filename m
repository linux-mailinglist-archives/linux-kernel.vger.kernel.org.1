Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAD29AA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899102AbgJ0LSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:18:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39305 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437533AbgJ0LSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:18:47 -0400
X-UUID: e68911411baf450c89990908e0e39228-20201027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CX9QvQnyne8Hpt4VfAuu4sA7J/V8CvxMVl7RhxE/DMU=;
        b=QRDt+h4egqmodeDEPfuM/zQmiCjBEtm6Q3JQ2eJNmmUGxR8yceTTKTge6lrbnvt9KYOONwBktD+8k4cuFkPhooAi9kP9z0Mz9ipEhkYBNRy5uy6yxQfm270KFMqFOwhR//sgM1N9TD0kVCDo0juJievaUJFDLeWMFOLgBtfrq4s=;
X-UUID: e68911411baf450c89990908e0e39228-20201027
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 401951614; Tue, 27 Oct 2020 19:18:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Oct 2020 19:18:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Oct 2020 19:18:36 +0800
Message-ID: <1603797517.25228.3.camel@mtksdaap41>
Subject: Re: [PATCH v3 15/16] soc: mediatek: pm-domains: Add default power
 off flag
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <linux-kernel@vger.kernel.org>, <drinkcat@chromium.org>,
        <hsinyi@chromium.org>, Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 27 Oct 2020 19:18:37 +0800
In-Reply-To: <05be2a94-d6e6-36e5-2c14-6d971e4a7677@gmail.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
         <20201026175526.2915399-16-enric.balletbo@collabora.com>
         <05be2a94-d6e6-36e5-2c14-6d971e4a7677@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: ED58C28063F2386AC2BAD60DEE964D3B242838AD98D89E15AEA1582974FEA3202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDExOjUzICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjYvMTAvMjAyMCAxODo1NSwgRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYSB3cm90
ZToNCj4gPiBGcm9tOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+
IEZvciBzb21lIHBvd2VyIGRvbWFpbiwgbGlrZSBjb25uIG9uIE1UODE5MiwgaXQgc2hvdWxkIGJl
IGRlZmF1bHQgT0ZGLg0KPiA+IEJlY2F1c2UgdGhlIHBvd2VyIG9uL29mZiBjb250cm9sIHJlbGll
cyB0aGUgZnVuY3Rpb24gb2YgY29ubmVjdGl2aXR5IGNoaXANCj4gPiBhbmQgaXRzIGZpcm13YXJl
LiBBbmQgaWYgcHJvamVjdCBjaG9vc2Ugb3RoZXIgY2hpcCB2ZW5kb3Igc29sdXRpb24sDQo+ID4g
dGhvc2UgbmVjZXNzYXJ5IGNvbm5lY3Rpdml0eSBmdW5jdGlvbnMgd2lsbCBub3QgcHJvdmlkZWQu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpYyBCYWxsZXRibyBpIFNlcnJhIDxlbnJpYy5iYWxs
ZXRib0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6IE5v
bmUNCj4gPiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+ID4gDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstcG0tZG9tYWlucy5jIHwgMjMgKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiAg
IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbS1kb21haW5zLmggfCAgMSArDQo+ID4gICAyIGZp
bGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMgYi9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jDQo+ID4gaW5kZXggNjM5OTMwNzZhNTQ0
Li5mZTBlOTU1MDc2YTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXBtLWRvbWFpbnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbS1kb21h
aW5zLmMNCj4gPiBAQCAtMzc4LDEwICszNzgsMTYgQEAgZ2VuZXJpY19wbV9kb21haW4gKnNjcHN5
c19hZGRfb25lX2RvbWFpbihzdHJ1Y3Qgc2Nwc3lzICpzY3BzeXMsIHN0cnVjdCBkZXZpY2Vfbm8N
Cj4gPiAgIAkgKiBzb2Z0d2FyZS4gIFRoZSB1bnVzZWQgZG9tYWlucyB3aWxsIGJlIHN3aXRjaGVk
IG9mZiBkdXJpbmcNCj4gPiAgIAkgKiBsYXRlX2luaXQgdGltZS4NCj4gPiAgIAkgKi8NCj4gPiAt
CXJldCA9IHNjcHN5c19wb3dlcl9vbigmcGQtPmdlbnBkKTsNCj4gPiAtCWlmIChyZXQgPCAwKSB7
DQo+ID4gLQkJZGV2X2VycihzY3BzeXMtPmRldiwgIiVwT0Y6IGZhaWxlZCB0byBwb3dlciBvbiBk
b21haW46ICVkXG4iLCBub2RlLCByZXQpOw0KPiA+IC0JCWdvdG8gZXJyX3VucHJlcGFyZV9jbG9j
a3M7DQo+ID4gKwlpZiAoTVRLX1NDUERfQ0FQUyhwZCwgTVRLX1NDUERfS0VFUF9ERUZBVUxUX09G
RikpIHsNCj4gPiArCQlpZiAoc2Nwc3lzX2RvbWFpbl9pc19vbihwZCkpDQo+ID4gKwkJCWRldl93
YXJuKHNjcHN5cy0+ZGV2LA0KPiA+ICsJCQkJICIlcE9GOiBBIGRlZmF1bHQgb2ZmIHBvd2VyIGRv
bWFpbiBoYXMgYmVlbiBPTlxuIiwgbm9kZSk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXJldCA9
IHNjcHN5c19wb3dlcl9vbigmcGQtPmdlbnBkKTsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+
ICsJCQlkZXZfZXJyKHNjcHN5cy0+ZGV2LCAiJXBPRjogZmFpbGVkIHRvIHBvd2VyIG9uIGRvbWFp
bjogJWRcbiIsIG5vZGUsIHJldCk7DQo+ID4gKwkJCWdvdG8gZXJyX3VucHJlcGFyZV9jbG9ja3M7
DQo+ID4gKwkJfQ0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+ICAgCWlmIChzY3BzeXMtPmRvbWFpbnNb
aWRdKSB7DQo+ID4gQEAgLTM5NSw3ICs0MDEsMTEgQEAgZ2VuZXJpY19wbV9kb21haW4gKnNjcHN5
c19hZGRfb25lX2RvbWFpbihzdHJ1Y3Qgc2Nwc3lzICpzY3BzeXMsIHN0cnVjdCBkZXZpY2Vfbm8N
Cj4gPiAgIAlwZC0+Z2VucGQucG93ZXJfb2ZmID0gc2Nwc3lzX3Bvd2VyX29mZjsNCj4gPiAgIAlw
ZC0+Z2VucGQucG93ZXJfb24gPSBzY3BzeXNfcG93ZXJfb247DQo+ID4gICANCj4gPiAtCXBtX2dl
bnBkX2luaXQoJnBkLT5nZW5wZCwgTlVMTCwgZmFsc2UpOw0KPiA+ICsJaWYgKE1US19TQ1BEX0NB
UFMocGQsIE1US19TQ1BEX0tFRVBfREVGQVVMVF9PRkYpKQ0KPiA+ICsJCXBtX2dlbnBkX2luaXQo
JnBkLT5nZW5wZCwgTlVMTCwgdHJ1ZSk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcG1fZ2VucGRfaW5p
dCgmcGQtPmdlbnBkLCBOVUxMLCBmYWxzZSk7DQo+ID4gKw0KPiA+ICAgCXNjcHN5cy0+ZG9tYWlu
c1tpZF0gPSAmcGQtPmdlbnBkOw0KPiA+ICAgDQo+ID4gICAJcmV0dXJuIHNjcHN5cy0+cGRfZGF0
YS5kb21haW5zW2lkXTsNCj4gPiBAQCAtNDc4LDcgKzQ4OCw4IEBAIHN0YXRpYyB2b2lkIHNjcHN5
c19yZW1vdmVfb25lX2RvbWFpbihzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAqcGQpDQo+ID4gICAJCQki
ZmFpbGVkIHRvIHJlbW92ZSBkb21haW4gJyVzJyA6ICVkIC0gc3RhdGUgbWF5IGJlIGluY29uc2lz
dGVudFxuIiwNCj4gPiAgIAkJCXBkLT5nZW5wZC5uYW1lLCByZXQpOw0KPiA+ICAgDQo+ID4gLQlz
Y3BzeXNfcG93ZXJfb2ZmKCZwZC0+Z2VucGQpOw0KPiA+ICsJaWYgKCFNVEtfU0NQRF9DQVBTKHBk
LCBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGKSkNCj4gPiArCQlzY3BzeXNfcG93ZXJfb2ZmKCZw
ZC0+Z2VucGQpOw0KPiANCj4gT0ssIHNvIHlvdSBtZXJnZWQgV2VpeWkncyBwYXRjaGVzIGluIHRo
aXMgc2VyaWVzIDopDQo+IA0KPiBTbyBzYW1lIGNvbW1lbnQgaGVyZTogRG9lcyBpdCByZWFsbHkg
aHVydCBpZiB3ZSB0dXJuLW9mZiBhIGFscmVhZHkgdHVybmVkLW9mZiANCj4gcG93ZXIgZG9tYWlu
PyBPciBjYW4gd2UgZ2V0IHJpZCBvZiB0aGlzIGNoZWNrPw0KPiANCg0KV2UgZG8gbmVlZCB0aGlz
IGNoZWNrIGhlcmUuIElmIHlvdSB0cnkgdG8gdHVybi1vZmYgdGhpcyBwb3dlciBkb21haW4sDQp5
b3UgbWlnaHQgbWFrZSB0aGUgY2xvY2sgb3IgcmVndWxhdG9yIHJlZmVyZW5jZSBjb3VudCB1bmJh
bGFuY2VkLg0KDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+ICAgDQo+ID4gICAJY2xr
X2J1bGtfdW5wcmVwYXJlKHBkLT5udW1fY2xrcywgcGQtPmNsa3MpOw0KPiA+ICAgCWNsa19idWxr
X3B1dChwZC0+bnVtX2Nsa3MsIHBkLT5jbGtzKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuaCBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1w
bS1kb21haW5zLmgNCj4gPiBpbmRleCAyYWQyMTNiZTg0YTUuLjBmYTZhOTM4YjQwYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5oDQo+ID4gKysr
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuaA0KPiA+IEBAIC02LDYgKzYs
NyBAQA0KPiA+ICAgI2RlZmluZSBNVEtfU0NQRF9BQ1RJVkVfV0FLRVVQCQlCSVQoMCkNCj4gPiAg
ICNkZWZpbmUgTVRLX1NDUERfRldBSVRfU1JBTQkJQklUKDEpDQo+ID4gICAjZGVmaW5lIE1US19T
Q1BEX1NSQU1fSVNPCQlCSVQoMikNCj4gPiArI2RlZmluZSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRf
T0ZGCUJJVCgzKQ0KPiA+ICAgI2RlZmluZSBNVEtfU0NQRF9DQVBTKF9zY3BkLCBfeCkJKChfc2Nw
ZCktPmRhdGEtPmNhcHMgJiAoX3gpKQ0KPiA+ICAgDQo+ID4gICAjZGVmaW5lIFNQTV9WREVfUFdS
X0NPTgkJCTB4MDIxMA0KPiA+IA0KDQo=

