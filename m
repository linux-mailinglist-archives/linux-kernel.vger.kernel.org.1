Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F32E6FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL2LZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:25:59 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64519 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgL2LZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:25:58 -0500
X-UUID: baca8fc22ce7428f86fe29ae54de9112-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ldY0xu4Bpq6j4mWxH+e0rb8pjBx8nAg1BnDNDsLOWX4=;
        b=T6h8g+KmaOyIVuuy7UkFGdmixI7BSKDTYjn5Dz157ZZ1x16C5Bwa2LvvZRawo7v+98JYzKV3C4cvBmEFIRuVR89cxe12oOTz9E8qtYuJ8ulMuCsh9Daag/xzd0x8RGcIyjqureR0QDpJydEzzTDccTuEMQAxK4k9PcrKcvRyZpw=;
X-UUID: baca8fc22ce7428f86fe29ae54de9112-20201229
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 959207855; Tue, 29 Dec 2020 19:25:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 19:25:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:25:12 +0800
Message-ID: <1609241112.26323.299.camel@mhfsdcap03>
Subject: Re: [PATCH v5 16/27] iommu/mediatek: Add device link for smi-common
 and m4u
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
Date:   Tue, 29 Dec 2020 19:25:12 +0800
In-Reply-To: <X+L/0E6p9t+a/l5w@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-17-yong.wu@mediatek.com>
         <X+L/0E6p9t+a/l5w@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B7DF2E6AB0CEF4F62DCE00F5D850EE1FFCC5768A5FB62BA86F6C9FE06CF202472000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjI5ICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NTFQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBJbiB0aGUgbGFzdGVzdCBTb0MsIE00VSBoYXMgaXRzIHNwZWNpYWwgcG93ZXIgZG9tYWlu
LiB0aHVzLCBJZiB0aGUgZW5naW5lDQo+ID4gYmVnaW4gdG8gd29yaywgaXQgc2hvdWxkIGhlbHAg
ZW5hYmxlIHRoZSBwb3dlciBmb3IgTTRVIGZpcnN0bHkuDQo+ID4gQ3VycmVudGx5IGlmIHRoZSBl
bmdpbmUgd29yaywgaXQgYWx3YXlzIGVuYWJsZSB0aGUgcG93ZXIvY2xvY2tzIGZvcg0KPiA+IHNt
aS1sYXJicy9zbWktY29tbW9uLiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNlX2xpbmsgZm9yIHNtaS1j
b21tb24gYW5kIE00VS4NCj4gPiB0aGVuLCBpZiBzbWktY29tbW9uIHBvd2VyIGlzIGVuYWJsZWQs
IHRoZSBNNFUgcG93ZXIgYWxzbyBpcyBwb3dlcmVkIG9uDQo+ID4gYXV0b21hdGljYWxseS4NCj4g
PiANCj4gPiBOb3JtYWxseSBNNFUgY29ubmVjdCB3aXRoIHNldmVyYWwgc21pLWxhcmJzIGFuZCB0
aGVpciBzbWktY29tbW9uIGFsd2F5cw0KPiA+IGFyZSB0aGUgc2FtZSwgSW4gdGhpcyBwYXRjaCBp
dCBnZXQgc21pLWNvbW1vbiBkZXYgZnJvbSB0aGUgZmlyc3Qgc21pLWxhcmINCj4gPiBkZXZpY2Uo
aT09MCksIHRoZW4gYWRkIHRoZSBkZXZpY2VfbGluayBvbmx5IHdoaWxlIG00dSBoYXMgcG93ZXIt
ZG9tYWluLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmggfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCAwOWM4YzU4ZmViNzguLjU2
MTQwMTVlNWI5NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+
ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0yMCw2ICsyMCw3IEBA
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29m
X3BsYXRmb3JtLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jl
Z21hcC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvc3BpbmxvY2suaD4NCj4gPiBAQCAtNzA2LDcgKzcwNyw3IEBAIHN0YXRpYyBpbnQgbXRrX2lv
bW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJcmV0dXJuIGxh
cmJfbnI7DQo+ID4gIA0KPiA+ICAJZm9yIChpID0gMDsgaSA8IGxhcmJfbnI7IGkrKykgew0KPiA+
IC0JCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbGFyYm5vZGU7DQo+ID4gKwkJc3RydWN0IGRldmljZV9u
b2RlICpsYXJibm9kZSwgKnNtaWNvbW1fbm9kZTsNCj4gPiAgCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwbGFyYmRldjsNCj4gPiAgCQl1MzIgaWQ7DQo+ID4gIA0KPiA+IEBAIC03MzIsNiArNzMz
LDI2IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gIA0KPiA+ICAJCWNvbXBvbmVudF9tYXRjaF9hZGRfcmVsZWFzZShkZXYsICZt
YXRjaCwgcmVsZWFzZV9vZiwNCj4gPiAgCQkJCQkgICAgY29tcGFyZV9vZiwgbGFyYm5vZGUpOw0K
PiA+ICsJCWlmIChpICE9IDApDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiANCj4gSG93IGFib3V0IHVz
aW5nIHRoZSBsYXN0IGxhcmIgaW5zdGVhZCBhbmQgbW92aW5nIHRoZSBjb2RlIGJlbG93IG91dHNp
ZGUNCj4gb2YgdGhlIGxvb3A/DQoNCk9mIGNvdXJzZSBPSy4gVGhhbmtzLg0KDQo=

