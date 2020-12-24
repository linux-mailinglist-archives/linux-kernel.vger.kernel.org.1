Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533802E266E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgLXLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:36:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64715 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgLXLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:36:26 -0500
X-UUID: d2f4bc1ac7aa4538af11bd7268bde150-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SB6oEobDBkSXNK3qQS8llstfz4w4FiszNJyh08p/o70=;
        b=b4ubeLixjdrOVZuT5ZP0vIQ+pKXyOF/DCoIMil/U8zWo0KD9xDHoaI69tcmsot1NWH6xYsOP5U1e5y6VBnR8wluf0t9VZeIAuDYdiKggZjoJDwWczYan4YWx2jCs+HDYjGm3xPHRANmFZG39+MynBrQiLkLAoPHlandlRIH57tY=;
X-UUID: d2f4bc1ac7aa4538af11bd7268bde150-20201224
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 458351113; Thu, 24 Dec 2020 19:35:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Dec
 2020 19:35:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 19:35:12 +0800
Message-ID: <1608809713.26323.262.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
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
Date:   Thu, 24 Dec 2020 19:35:13 +0800
In-Reply-To: <X+L9XpkoII7tw/tX@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-7-yong.wu@mediatek.com>
         <X+L9XpkoII7tw/tX@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 43E145A43742A33FB0F432294A8D8B05C5B400A4B9E3095EC85B6369A76296B42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjE4ICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NDFQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgZGVjcmlwdGlvbnMgZm9yIG10ODE5MiBJT01NVSBhbmQgU01J
Lg0KPiA+IA0KPiA+IG10ODE5MiBhbHNvIGlzIE1USyBJT01NVSBnZW4yIHdoaWNoIHVzZXMgQVJN
IFNob3J0LURlc2NyaXB0b3IgdHJhbnNsYXRpb24NCj4gPiB0YWJsZSBmb3JtYXQuIFRoZSBNNFUt
U01JIEhXIGRpYWdyYW0gaXMgYXMgYmVsb3c6DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBFTUkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBNNFUNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgU01JIENvbW1vbg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0t
LS0tLS0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICArLS0tLS0tLSst
LS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSsNCj4gPiAgIHwgICAg
ICAgfCAgICAgIHwgICAgICB8ICAgICAgIC4uLi4uLiAgICAgICAgIHwgICAgICAgfA0KPiA+ICAg
fCAgICAgICB8ICAgICAgfCAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8DQo+
ID4gbGFyYjAgICBsYXJiMSAgbGFyYjIgIGxhcmI0ICAgICAuLi4uLi4gICAgICBsYXJiMTkgICBs
YXJiMjANCj4gPiBkaXNwMCAgIGRpc3AxICAgbWRwICAgIHZkZWMgICAgICAgICAgICAgICAgICAg
SVBFICAgICAgSVBFDQo+ID4gDQo+ID4gQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgSFcgZml4ZWQs
IFNXIGNhbiBOT1QgYWRqdXN0IGl0Lg0KPiA+IA0KPiA+IG10ODE5MiBNNFUgc3VwcG9ydCAwfjE2
R0IgaW92YSByYW5nZS4gd2UgcHJlYXNzaWduIGRpZmZlcmVudCBlbmdpbmVzDQo+ID4gaW50byBk
aWZmZXJlbnQgaW92YSByYW5nZXM6DQo+ID4gDQo+ID4gZG9tYWluLWlkICBtb2R1bGUgICAgIGlv
dmEtcmFuZ2UgICAgICAgICAgICAgICAgICBsYXJicw0KPiA+ICAgIDAgICAgICAgZGlzcCAgICAg
ICAgMCB+IDRHICAgICAgICAgICAgICAgICAgICAgIGxhcmIwLzENCj4gPiAgICAxICAgICAgIHZj
b2RlYyAgICAgIDRHIH4gOEcgICAgICAgICAgICAgICAgICAgICBsYXJiNC81LzcNCj4gPiAgICAy
ICAgICAgIGNhbS9tZHAgICAgIDhHIH4gMTJHICAgICAgICAgICAgIGxhcmIyLzkvMTEvMTMvMTQv
MTYvMTcvMTgvMTkvMjANCj4gDQo+IFdoeSBkbyB3ZSBwcmVhc3NpZ24gdGhlc2UgYWRkcmVzc2Vz
IGluIERUPyBTaG91bGRuJ3QgaXQgYmUgYSB1c2VyJ3Mgb3INCj4gaW50ZWdyYXRvcidzIGRlY2lz
aW9uIHRvIHNwbGl0IHRoZSAxNiBHQiBhZGRyZXNzIHJhbmdlIGludG8gc3ViLXJhbmdlcw0KPiBh
bmQgZGVmaW5lIHdoaWNoIGxhcmJzIHRob3NlIHN1Yi1yYW5nZXMgYXJlIHNoYXJlZCB3aXRoPw0K
DQpUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGNhbid0IHNwbGl0IHRoZSAxNkdCIHJhbmdlIHdpdGgg
dGhlIGxhcmIgYXMgdW5pdC4NClRoZSBleGFtcGxlIGlzIHRoZSBiZWxvdyBjY3UwKGxhcmIxMyBw
b3J0OS8xMCkgaXMgYSBpbmRlcGVuZGVudA0KcmFuZ2UoZG9tYWluKSwgdGhlIG90aGVycyBwb3J0
cyBpbiBsYXJiMTMgaXMgaW4gYW5vdGhlciBkb21haW4uDQoNCmRpc3AvdmNvZGVjL2NhbS9tZHAg
ZG9uJ3QgaGF2ZSBzcGVjaWFsIGlvdmEgcmVxdWlyZW1lbnQsIHRoZXkgY291bGQNCmFjY2VzcyBh
bnkgcmFuZ2UuIHZjb2RlYyBhbHNvIGNhbiBsb2NhdGUgOEd+MTJHLiBpdCBkb24ndCBjYXJlIGFi
b3V0DQp3aGVyZSBpdHMgaW92YSBsb2NhdGUuIGhlcmUgSSBwcmVhc3NpZ24gbGlrZSB0aGlzIGZv
bGxvd2luZyB3aXRoIG91cg0KaW50ZXJuYWwgcHJvamVjdCBzZXR0aW5nLg0KDQpXaHkgc2V0IHRo
aXMgaW4gRFQ/LCB0aGlzIGlzIG9ubHkgZm9yIHNpbXBsaWZ5aW5nIHRoZSBjb2RlLiBBc3N1bWUg
d2UNCnB1dCBpdCBpbiB0aGUgcGxhdGZvcm0gZGF0YS4gV2UgaGF2ZSB1cCB0byAzMiBsYXJicywg
ZWFjaCBsYXJiIGhhcyB1cCB0bw0KMzIgcG9ydHMsIGVhY2ggcG9ydCBtYXkgYmUgaW4gZGlmZmVy
ZW50IGlvbW11IGRvbWFpbnMuIHdlIHNob3VsZCBoYXZlIGENCmJpZyBhcnJheSBmb3IgdGhpcy4u
aG93ZXZlciB3ZSBvbmx5IHVzZSBhIG1hY3JvIHRvIGdldCB0aGUgZG9tYWluIGluIHRoZQ0KRFQg
bWV0aG9kLg0KDQpXaGVuIHJlcGx5aW5nIHRoaXMgbWFpbCwgSSBoYXBwZW4gdG8gc2VlIHRoZXJl
IGlzIGEgImRldi0+ZGV2X3JhbmdlX21hcCINCndoaWNoIGhhcyAiZG1hLXJhbmdlIiBpbmZvcm1h
dGlvbiwgSSB0aGluayBJIGNvdWxkIHVzZSB0aGlzIHZhbHVlIHRvIGdldA0Kd2hpY2ggZG9tYWlu
IHRoZSBkZXZpY2UgYmVsb25nIHRvLiB0aGVuIG5vIG5lZWQgcHV0IGRvbWlkIGluIERULiBJIHdp
bGwNCnRlc3QgdGhpcy4NCg0KVGhhbmtzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBUb21hc3oN
Cj4gDQo+ID4gICAgMyAgICAgICBDQ1UwICAgIDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYgICAg
IGxhcmIxMzogcG9ydCA5LzEwDQo+ID4gICAgNCAgICAgICBDQ1UxICAgIDB4NDQwMF8wMDAwIH4g
MHg0N2ZmX2ZmZmYgICAgIGxhcmIxNDogcG9ydCA0LzUNCj4gPiANCj4gPiBUaGUgaW92YSByYW5n
ZSBmb3IgQ0NVMC8xKGNhbWVyYSBjb250cm9sIHVuaXQpIGlzIEhXIHJlcXVpcmVtZW50Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+
ICAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUueWFtbCAgICAgICAgfCAgMTggKy0N
Cj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTkyLWxhcmItcG9ydC5oIHwgMjQw
ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI1NyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJp
bmRpbmdzL21lbW9yeS9tdDgxOTItbGFyYi1wb3J0LmgNCj4gPiANCltzbmlwXQ0K

