Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A52F7234
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbhAOFbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:31:40 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49219 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726019AbhAOFbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:31:39 -0500
X-UUID: 24067ff830cf4529bc716d71bc9e2947-20210115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8Xzi4Jk1vwim8FSqpSrcJwUMLUAt5CxpsEAeeSgDR/A=;
        b=PK0jmoLWR1BxE3osY8lzT6Um7Kk6obLEEprp0Kb//ACrnXkZRBG4wYmCjDanxe0vfxHJrw6xU5RvkZ7UgjHjDI3vQuTiHXrtNVFMfKmp7Zz0waeRwAex8g/AWAUpaxgsW/rRTSzwXQNsRzSv7mE9rsNGDAQZ/kZja+BbEjbP6OA=;
X-UUID: 24067ff830cf4529bc716d71bc9e2947-20210115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 851705744; Fri, 15 Jan 2021 13:30:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Jan
 2021 13:30:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jan 2021 13:30:26 +0800
Message-ID: <1610688626.4578.1.camel@mhfsdcap03>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Fri, 15 Jan 2021 13:30:26 +0800
In-Reply-To: <20210114192732.GA3401278@robh.at.kernel.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
         <20210111111914.22211-7-yong.wu@mediatek.com>
         <20210114192732.GA3401278@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 84A856FA60FFA5913CE06B0A418092BC787D34670283D643131FDFCEE268D07C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTE0IGF0IDEzOjI3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMDc6MTg6NDdQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiAiZGV2LT5kbWFfcmFuZ2VfbWFwIiBjb250YWlucyB0aGUgZGV2aWNlcycgZG1hX3Jhbmdl
cyBpbmZvcm1hdGlvbiwNCj4gPiBUaGlzIHBhdGNoIG1vdmVzIGRtYV9yYW5nZV9tYXAgYmVmb3Jl
IG9mX2lvbW11X2NvbmZpZ3VyZS4gVGhlIGlvbW11DQo+ID4gZHJpdmVyIG1heSBuZWVkIHRvIGtu
b3cgdGhlIGRtYV9hZGRyZXNzIHJlcXVpcmVtZW50cyBvZiBpdHMgaW9tbXUNCj4gPiBjb25zdW1l
ciBkZXZpY2VzLg0KPiA+IA0KPiA+IENDOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
Pg0KPiA+IENDOiBGcmFuayBSb3dhbmQgPGZyb3dhbmQubGlzdEBnbWFpbC5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvb2YvZGV2aWNlLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
b2YvZGV2aWNlLmMgYi9kcml2ZXJzL29mL2RldmljZS5jDQo+ID4gaW5kZXggYWVkZmFhYWZkM2U3
Li4xZDg0NjM2MTQ5ZGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9vZi9kZXZpY2UuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvb2YvZGV2aWNlLmMNCj4gPiBAQCAtMTcwLDkgKzE3MCwxMSBAQCBpbnQg
b2ZfZG1hX2NvbmZpZ3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnAsDQo+ID4gIAlkZXZfZGJnKGRldiwgImRldmljZSBpcyVzZG1hIGNvaGVyZW50XG4iLA0K
PiA+ICAJCWNvaGVyZW50ID8gIiAiIDogIiBub3QgIik7DQo+ID4gIA0KPiA+ICsJZGV2LT5kbWFf
cmFuZ2VfbWFwID0gbWFwOw0KPiA+ICAJaW9tbXUgPSBvZl9pb21tdV9jb25maWd1cmUoZGV2LCBu
cCwgaWQpOw0KPiA+ICAJaWYgKFBUUl9FUlIoaW9tbXUpID09IC1FUFJPQkVfREVGRVIpIHsNCj4g
PiAgCQlrZnJlZShtYXApOw0KPiA+ICsJCWRldi0+ZG1hX3JhbmdlX21hcCA9IE5VTEw7DQo+IA0K
PiBOb3QgcmVhbGx5IGdvaW5nIHRvIG1hdHRlciwgYnV0IHlvdSBzaG91bGQgcHJvYmFibHkgY2xl
YXIgZG1hX3JhbmdlX21hcCANCj4gYmVmb3JlIHdoYXQgaXQgcG9pbnRzIHRvIGlzIGZyZWVkLg0K
PiANCj4gV2l0aCB0aGF0LA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gSSB3aWxsIG1vdmUgaXQgYmVmb3Jl
ICJrZnJlZShtYXApIiBpbiBuZXh0DQp2ZXJzaW9uLg0KDQo+IA0KPiA+ICAJCXJldHVybiAtRVBS
T0JFX0RFRkVSOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiBAQCAtMTgxLDcgKzE4Myw2IEBAIGludCBv
Zl9kbWFfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2Rl
ICpucCwNCj4gPiAgDQo+ID4gIAlhcmNoX3NldHVwX2RtYV9vcHMoZGV2LCBkbWFfc3RhcnQsIHNp
emUsIGlvbW11LCBjb2hlcmVudCk7DQo+ID4gIA0KPiA+IC0JZGV2LT5kbWFfcmFuZ2VfbWFwID0g
bWFwOw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwob2Zf
ZG1hX2NvbmZpZ3VyZV9pZCk7DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQoNCg==

