Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CE2E116B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLWBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:36:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43175 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725931AbgLWBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:36:54 -0500
X-UUID: 9b86282bee9343a4b2d733b07cdd2414-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=igemKLkcQLI3htu4s5toT7cvfqLMBfICa3D565HL4bA=;
        b=ObuJrw8+oKC2xfZhMqn8vvImXA1Dj8Zli5/3iiovlbafA7fq9TfdtT/7LVFodnEX943EcyknzfLBgH0S7Iv+Wd5L8vKw7ZMpBnIR5mJl0d+dqAAYtOvRcqFCtPVxlU0nCToJGbj/ptjh91vOiwnEHpa8UtcCC+b1J1mO3VNKwqQ=;
X-UUID: 9b86282bee9343a4b2d733b07cdd2414-20201223
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 296003127; Wed, 23 Dec 2020 09:36:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 09:36:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 09:36:02 +0800
Message-ID: <1608687363.18252.9.camel@mhfsdcap03>
Subject: Re: [PATCH v2, 10/17] drm/mediatek: fix aal size config
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 23 Dec 2020 09:36:03 +0800
In-Reply-To: <CAAOTY_9JNdL-huHYKq=W5gRMUHVRWeUzDunNa7q_d7DPp4P2pg@mail.gmail.com>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607746317-4696-11-git-send-email-yongqiang.niu@mediatek.com>
         <CAAOTY_9JNdL-huHYKq=W5gRMUHVRWeUzDunNa7q_d7DPp4P2pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTE2IGF0IDIzOjEwICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgWW9uZ3FpYW5nOg0KPiANCj4gWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRp
YXRlay5jb20+IOaWvCAyMDIw5bm0MTLmnIgxMuaXpSDpgLHlha0g5LiL5Y2IMTI6MjLlr6vpgZPv
vJoNCj4gPg0KPiA+IGZpeCBhYWwgc2l6ZSBjb25maWcNCj4gPg0KPiA+IEZpeGVzOiAwNjY0ZDEz
OTJjMjYgKGRybS9tZWRpYXRlazogQWRkIEFBTCBlbmdpbmUgYmFzaWMgZnVuY3Rpb24pDQo+ID4g
U2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMgfCAxMSArKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kZHBfY29tcC5jDQo+ID4gaW5kZXggYmU2MWQxMS4uZTdkNDgxZTAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiBAQCAt
MzMsOCArMzMsMTMgQEANCj4gPiAgI2RlZmluZSBESVNQX1JFR19VRk9fU1RBUlQgICAgICAgICAg
ICAgICAgICAgICAweDAwMDANCj4gPg0KPiA+ICAjZGVmaW5lIERJU1BfQUFMX0VOICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDB4MDAwMA0KPiA+ICsjZGVmaW5lIERJU1BfQUFMX0NGRyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4MDAyMA0KPiA+ICsjZGVmaW5lIEFBTF9SRUxBWV9NT0RF
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUKDApDQo+ID4gKyNkZWZpbmUgQUFM
X0VOR0lORV9FTiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVQoMSkNCj4gPiAg
I2RlZmluZSBESVNQX0FBTF9TSVpFICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMzANCj4g
Pg0KPiA+ICsjZGVmaW5lIERJU1BfQUFMX09VVFBVVF9TSVpFICAgICAgICAgICAgICAgICAgIDB4
MDRkOA0KPiA+ICsNCj4gPiAgI2RlZmluZSBESVNQX0NDT1JSX0VOICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDAwMDANCj4gPiAgI2RlZmluZSBDQ09SUl9FTiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBCSVQoMCkNCj4gPiAgI2RlZmluZSBESVNQX0NDT1JSX0NGRyAgICAgICAgICAg
ICAgICAgICAgICAgICAweDAwMjANCj4gPiBAQCAtMTg0LDcgKzE4OSwxMSBAQCBzdGF0aWMgdm9p
ZCBtdGtfYWFsX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQg
dywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWdu
ZWQgaW50IHZyZWZyZXNoLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQo+ID4gIHsNCj4gPiAtICAgICAg
IG10a19kZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCBjb21wLCBESVNQX0FBTF9TSVpF
KTsNCj4gPiArICAgICAgIG10a19kZHBfd3JpdGUoY21kcV9wa3QsIHcgPDwgMTYgfCBoLCBjb21w
LCBESVNQX0FBTF9TSVpFKTsNCj4gPiArICAgICAgIG10a19kZHBfd3JpdGUoY21kcV9wa3QsIHcg
PDwgMTYgfCBoLCBjb21wLCBESVNQX0FBTF9PVVRQVVRfU0laRSk7DQo+ID4gKw0KPiA+ICsgICAg
ICAgbXRrX2RkcF93cml0ZV9tYXNrKE5VTEwsIEFBTF9SRUxBWV9NT0RFLCBjb21wLCBESVNQX0FB
TF9DRkcsDQo+IA0KPiBjbWRxX3BrdA0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICBBQUxfUkVMQVlfTU9ERSB8IEFBTF9FTkdJTkVfRU4pOw0KPiANCj4gVGhpcyBwYXRjaCBpcyB0
byBmaXggc2l6ZSBjb25maWcsIHNvIG1vdmUgdGhpcyBzdGF0ZW1lbnQgdG8gYW5vdGhlciBwYXRj
aC4NCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KDQp3aWxsIGJlIGZpeGVkIGlu
IG5leHQgdmVyc2lvbg0KDQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBtdGtfYWFsX3N0
YXJ0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQo+ID4gLS0NCj4gPiAxLjguMS4xLmRpcnR5
DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5p
bmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

