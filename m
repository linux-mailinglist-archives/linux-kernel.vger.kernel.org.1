Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62B2CE5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgLDCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:35:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:8034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgLDCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:35:23 -0500
X-UUID: 34378544bbb3419f9d5c6405f4f73293-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ks0giwSuTJtBdXjdEkWwvc1tFrljUySYf/NOC1MuX90=;
        b=f1Gjgy+XFNvSTsfTww8P93GO6oaRbccsxZEQ8nXHtPyUirAn0JmFE8MAK1f6BmMnpamhB66qq2slCEqZRjJrk+UipuXpEB+AjT5Nw5Gie526VQdOGI7ovHRFHCZi29lgu5ntpNMTAFPd+iFepT+nWJu/qUwDtX1aaLHLCa4hlTc=;
X-UUID: 34378544bbb3419f9d5c6405f4f73293-20201204
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1974338625; Fri, 04 Dec 2020 10:34:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Dec
 2020 10:34:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 10:34:23 +0800
Message-ID: <1607049263.14806.69.camel@mhfsdcap03>
Subject: Re: [v6,2/3] reset-controller: ti: introduce a new reset handler
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>, "s-anna@ti.com" <s-anna@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 4 Dec 2020 10:34:23 +0800
In-Reply-To: <20201130103505.GA3019533@chromium.org>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-3-crystal.guo@mediatek.com>
         <20201130103505.GA3019533@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 25E45A4316C76E3EED103E9DBA28B3BC44ABD9990A4FFD7D374985132BAF0C842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE4OjM1ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMTA6MjE6NThBTSArMDgwMCwgQ3J5c3RhbCBHdW8gd3Jv
dGU6DQo+ID4gSW50cm9kdWNlIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQg
YW5kIGRlYXNzZXJ0IHRvZ2V0aGVyLg0KPiA+IElmIHNvbWUgbW9kdWxlcyBuZWVkIGRvIHNlcmlh
bGl6ZWQgYXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRpb25zDQo+ID4gdG8gcmVzZXQgaXRzZWxm
LCByZXNldF9jb250cm9sX3Jlc2V0IGNhbiBiZSBjYWxsZWQgZm9yIGNvbnZlbmllbmNlLg0KPiA+
IA0KPiA+IFN1Y2ggYXMgcmVzZXQtcWNvbS1hb3NzLmMsIGl0IGludGVncmF0ZXMgYXNzZXJ0IGFu
ZCBkZWFzc2VydCB0b2dldGhlcg0KPiA+IGJ5ICdyZXNldCcgbWV0aG9kLiBNVEsgU29jcyBhbHNv
IG5lZWQgdGhpcyBtZXRob2QgdG8gcGVyZm9ybSByZXNldC4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVtLm9yZz4NCj4gDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgfCA0MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC10
aS1zeXNjb24uYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gPiBpbmRleCBh
MjYzNWMyMWRiN2YuLjVkMWY4MzA2Y2Q0ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Jlc2V0
L3Jlc2V0LXRpLXN5c2Nvbi5jDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNj
b24uYw0KPiA+IEBAIC0xNSwxNSArMTUsMjIgQEANCj4gPiAgICogR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gPiAgICovDQo+ID4gIA0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
cGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3Jlc2V0LWNvbnRyb2xsZXIuaD4NCj4gPiAgDQo+ID4gICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9yZXNldC90aS1zeXNjb24uaD4NCj4gPiAgDQo+ID4gK3N0cnVjdCBtZWRp
YXRla19yZXNldF9kYXRhIHsNCj4gPiArCXVuc2lnbmVkIGNoYXIgKnJlc2V0X2JpdHM7DQo+ID4g
Kwl1bnNpZ25lZCBpbnQgcmVzZXRfZHVyYXRpb25fdXM7DQo+ID4gK307DQo+ID4gKw0KPiA+ICAv
KioNCj4gPiAgICogc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9sIC0gcmVzZXQgY29udHJv
bCBzdHJ1Y3R1cmUNCj4gPiAgICogQGFzc2VydF9vZmZzZXQ6IHJlc2V0IGFzc2VydCBjb250cm9s
IHJlZ2lzdGVyIG9mZnNldCBmcm9tIHN5c2NvbiBiYXNlDQo+ID4gQEAgLTU2LDYgKzYzLDcgQEAg
c3RydWN0IHRpX3N5c2Nvbl9yZXNldF9kYXRhIHsNCj4gPiAgCXN0cnVjdCByZWdtYXAgKnJlZ21h
cDsNCj4gPiAgCXN0cnVjdCB0aV9zeXNjb25fcmVzZXRfY29udHJvbCAqY29udHJvbHM7DQo+ID4g
IAl1bnNpZ25lZCBpbnQgbnJfY29udHJvbHM7DQo+ID4gKwljb25zdCBzdHJ1Y3QgbWVkaWF0ZWtf
cmVzZXRfZGF0YSAqcmVzZXRfZGF0YTsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICNkZWZpbmUgdG9f
dGlfc3lzY29uX3Jlc2V0X2RhdGEocmNkZXYpCVwNCj4gPiBAQCAtMTU4LDkgKzE2NiwyOSBAQCBz
dGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9zdGF0dXMoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJf
ZGV2ICpyY2RldiwNCj4gPiAgCQkhKGNvbnRyb2wtPmZsYWdzICYgU1RBVFVTX1NFVCk7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0KHN0cnVjdCByZXNldF9j
b250cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gKwkJCQkgIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCB0aV9zeXNjb25fcmVzZXRfZGF0YSAqZGF0YSA9IHRvX3RpX3N5c2Nv
bl9yZXNldF9kYXRhKHJjZGV2KTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKGRh
dGEtPnJlc2V0X2RhdGEpIHsNCj4gPiArCQlyZXQgPSB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHJj
ZGV2LCBpZCk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl1
c2xlZXBfcmFuZ2UoZGF0YS0+cmVzZXRfZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMsDQo+ID4gKwkJ
CWRhdGEtPnJlc2V0X2RhdGEtPnJlc2V0X2R1cmF0aW9uX3VzICogMik7DQo+ID4gKw0KPiANCj4g
VGhlcmUgYXJlIG1hbnkgdXNlcnMgdXNpbmcgYXNzZXJ0KCkgYW5kIGRlYXNzZXJ0KCkgc2VwZXJh
dGVseQ0KPiB3aXRob3V0IGFueSBkZWxheSBiZXR3ZWVuIHRoZW0uDQo+IA0KPiBJZiB0aGVyZSdz
IGEgdGltaW5nIHJlcXVpcmVtZW50IGJldHdlZW4gYXNzZXJ0aW9uIGFuZCBkZWFzc2VydGlvbiwN
Cj4gc2hvdWxkbid0IHRoZXJlIGJlIGEgc2FtZSBhbW91bnQgb2YgZGVsYXkgaW4gYXNzZXJ0Pw0K
DQpUaGUgInJlc2V0X2R1cmF0aW9uX3VzIiBpcyBhbiBvcHRpb25hbCBjb25maWd1cmF0aW9uIHRv
IG1ha2UgdGhlIHJlc2V0DQpvcGVyYXRpb24gbW9yZSBnZW5lcmljLCB3aGljaCB3YXMgYWRkZWQg
YmFzZWQgb24gUGhpbGlwcCdzIGNvbW1lbnQgaW4NClt2Miw0LzZdLg0KDQpUaGFua3MsDQpDcnlz
dGFsDQo+IA0KPiA+ICsJCXJldHVybiB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQocmNkZXYsIGlk
KTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiArCX0NCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0
aV9zeXNjb25fcmVzZXRfb3BzID0gew0KPiA+ICAJLmFzc2VydAkJPSB0aV9zeXNjb25fcmVzZXRf
YXNzZXJ0LA0KPiA+ICAJLmRlYXNzZXJ0CT0gdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0LA0KPiA+
ICsJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwNCj4gPiAgCS5zdGF0dXMJCT0gdGlfc3lzY29u
X3Jlc2V0X3N0YXR1cywNCj4gPiAgfTsNCj4gPiAgDQo+ID4gQEAgLTE4Miw3ICsyMTAsMTEgQEAg
c3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiAgCWlmIChJU19FUlIocmVnbWFwKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihy
ZWdtYXApOw0KPiA+ICANCj4gPiAtCWxpc3QgPSBvZl9nZXRfcHJvcGVydHkobnAsICJ0aSxyZXNl
dC1iaXRzIiwgJnNpemUpOw0KPiA+ICsJZGF0YS0+cmVzZXRfZGF0YSA9IG9mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gPiArCWlmIChkYXRhLT5yZXNldF9kYXRhKQ0KPiA+
ICsJCWxpc3QgPSBvZl9nZXRfcHJvcGVydHkobnAsIGRhdGEtPnJlc2V0X2RhdGEtPnJlc2V0X2Jp
dHMsICZzaXplKTsNCj4gPiArCWVsc2UNCj4gPiArCQlsaXN0ID0gb2ZfZ2V0X3Byb3BlcnR5KG5w
LCAidGkscmVzZXQtYml0cyIsICZzaXplKTsNCj4gPiAgCWlmICghbGlzdCB8fCAoc2l6ZSAvIHNp
emVvZigqbGlzdCkpICUgNyAhPSAwKSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJpbnZhbGlkIERU
IHJlc2V0IGRlc2NyaXB0aW9uXG4iKTsNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiBAQCAt
MjE3LDggKzI0OSwxNCBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0dXJuIGRldm1fcmVzZXRfY29udHJvbGxl
cl9yZWdpc3RlcihkZXYsICZkYXRhLT5yY2Rldik7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgbWVkaWF0ZWtfcmVzZXRfZGF0YSBtdGtfcmVzZXRfZGF0YSA9IHsNCj4g
PiArCS5yZXNldF9iaXRzID0gIm1lZGlhdGVrLHJlc2V0LWJpdHMiLA0KPiA+ICsJLnJlc2V0X2R1
cmF0aW9uX3VzID0gMTAsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCB0aV9zeXNjb25fcmVzZXRfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNv
bXBhdGlibGUgPSAidGksc3lzY29uLXJlc2V0IiwgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssc3lzY29uLXJlc2V0IiwgLmRhdGEgPSAmbXRrX3Jlc2V0X2RhdGF9LA0KPiA+ICAJ
eyAvKiBzZW50aW5lbCAqLyB9LA0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCB0aV9zeXNjb25fcmVzZXRfb2ZfbWF0Y2gpOw0KDQo=

