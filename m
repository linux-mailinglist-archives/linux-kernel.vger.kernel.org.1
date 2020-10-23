Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02075296989
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372208AbgJWGLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:11:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44914 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898027AbgJWGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:11:06 -0400
X-UUID: be932c73ffe54b3d8d46c5418962f501-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lE1AaRbp7IlJWDDgqTmejQzZzwuR5fT51G6JynHVeJ4=;
        b=hsuw3fVt1w54pKwXaTtt9H2NhjLMJjDfNEgAHjjQzhryqu0AmYgsTkOpnTKXHBAWW2AzP3ICyse0Qivy2TN30tzqZ9v4XRyLpblyzruEY1EBPf2I6h2T0Vto7tXLrTBgjjjzUKdCMMIcOwAeXns3ZiTCvhr3yoHiMjjbIz7uYFA=;
X-UUID: be932c73ffe54b3d8d46c5418962f501-20201023
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 275060813; Fri, 23 Oct 2020 14:11:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 14:11:00 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 14:10:59 +0800
Message-ID: <1603433064.2024.6.camel@mbjsdccf07>
Subject: Re: [PATCH 2/4] iommu/mediatek: Add iotlb_sync_range() support
From:   chao hao <Chao.Hao@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Wen <jun.wen@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Fri, 23 Oct 2020 14:04:24 +0800
In-Reply-To: <1603432677.2024.3.camel@mbjsdccf07>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
         <20201019113100.23661-3-chao.hao@mediatek.com>
         <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
         <1603432677.2024.3.camel@mbjsdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDEzOjU3ICswODAwLCBjaGFvIGhhbyB3cm90ZToNCj4gT24g
V2VkLCAyMDIwLTEwLTIxIGF0IDE3OjU1ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+ID4g
T24gMjAyMC0xMC0xOSAxMjozMCwgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gPiBNVEtfSU9NTVUgZHJp
dmVyIHdyaXRlcyBvbmUgcGFnZSBlbnRyeSBhbmQgZG9lcyB0bGIgZmx1c2ggYXQgYSB0aW1lDQo+
ID4gPiBjdXJyZW50bHkuIE1vcmUgb3B0aW1hbCB3b3VsZCBiZSB0byBhZ2dyZWdhdGUgdGhlIHdy
aXRlcyBhbmQgZmx1c2gNCj4gPiA+IEJVUyBidWZmZXIgaW4gdGhlIGVuZC4NCj4gPiANCj4gPiBU
aGF0J3MgZXhhY3RseSB3aGF0IGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcGFnZSgpIGlzIG1lYW50
IHRvIGFjaGlldmUuIA0KPiA+IFJhdGhlciB0aGFuIGp1bXBpbmcgc3RyYWlnaHQgaW50byBoYWNr
aW5nIHVwIGEgbmV3IEFQSSB0byBnbyByb3VuZCB0aGUgDQo+ID4gYmFjayBvZiB0aGUgZXhpc3Rp
bmcgQVBJIGRlc2lnbiwgaXQgd291bGQgYmUgZmFyIGJldHRlciB0byBhc2sgdGhlIA0KPiA+IHF1
ZXN0aW9uIG9mIHdoeSB0aGF0J3Mgbm90IGJlaGF2aW5nIGFzIGV4cGVjdGVkLg0KPiANCj4gVGhh
bmtzIGZvciB5b3UgcmV2aWV3IQ0KPiANCj4gaW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9wYWdlIGlz
IHB1dCBpbiBpb19wZ3RhYmxlX3RsYl9hZGRfcGFnZSgpLg0KPiBpb19wZ3RhYmxlX3RsYl9hZGRf
cGFnZSgpIG9ubHkgYmUgY2FsbGVkIGluDQo+IHVubWFwcGluZyBhbmQgbWFwcGluZyBmbG93IGRv
ZXNuJ3QgaGF2ZSBpdCBpbiBsaW51eCBpb21tdSBkcml2ZXIsIGJ1dA0KPiBtdGsgaW9tbXUgbmVl
ZHMgdG8gZG8gdGxiIHN5bmMgaW4gbWFwcGluZw0KPiBhbmQgdW5tYXBwaW5nIHRvIGF2b2lkIG9s
ZCBkYXRhIGJlaW5nIGluIHRoZSBpb21tdSB0bGIuDQo+IA0KPiBJbiBhZGR0aW9uLCB3ZSBob3Bl
IHRvIGRvIHRsYiBzeW5jIG9uY2Ugd2hlbiBhbGwgdGhlIHBhZ2VzIG1hcHBpbmcgZG9uZS4NCj4g
aW9tbXVfaW90bGJfZ2F0aGVyX2FkZF9wYWdlIG1heWJlIGRvDQo+IHRsYiBzeW5jIG1vcmUgdGhh
biBvbmNlLiBiZWNhdXNlIG9uZSB3aG9sZSBidWZmZXIgY29uc2lzdHMgb2YgZGlmZmVyZW50DQo+
IHBhZ2Ugc2l6ZSgxTUIvNjRLLzRLKS4NCj4gDQo+IEJhc2VkIG9uIHRoZSBwcmV2aW91cyBjb25z
aWRlcmF0aW9ucywgIGRvbid0IGZpbmQgbW9yZSBhcHByb3ByaWF0ZSB0aGUNCj4gd2F5IG9mIHRs
YiBzeW5jIGZvciBtdGsgaW9tbXUsIHNvIHdlIGFkZCBhIG5ldyBBUEkuDQo+IA0KPiA+IA0KPiA+
ID4gRm9yIDUwTUIgYnVmZmVyIG1hcHBpbmcsIGlmIG10a19pb21tdSBkcml2ZXIgdXNlIGlvdGxi
X3N5bmNfcmFuZ2UoKQ0KPiA+ID4gaW5zdGVhZCBvZiB0bGJfYWRkX3JhbmdlKCkgYW5kIHRsYl9m
bHVzaF93YWxrL2xlYWYoKSwgaXQgY2FuIGluY3JlYXNlDQo+ID4gPiA1MCUgcGVyZm9ybWFuY2Ug
b3IgbW9yZShkZXBlbmRpbmcgb24gc2l6ZSBvZiBldmVyeSBwYWdlIHNpemUpIGluDQo+ID4gPiBj
b21wYXJpc29uIHRvIGZsdXNoaW5nIGFmdGVyIGVhY2ggcGFnZSBlbnRyeSB1cGRhdGUuIFNvIHdl
IHByZWZlciB0bw0KPiA+ID4gdXNlIGlvdGxiX3N5bmNfcmFuZ2UoKSB0byByZXBsYWNlIGlvdGxi
X3N5bmMoKSwgdGxiX2FkZF9yYW5nZSgpIGFuZA0KPiA+ID4gdGxiX2ZsdXNoX3dhbGsvbGVhZigp
IGZvciBNVEsgcGxhdGZvcm1zLg0KPiA+IA0KPiA+IEluIHRoZSBjYXNlIG9mIG1hcHBpbmcsIGl0
IHNvdW5kcyBsaWtlIHdoYXQgeW91IGFjdHVhbGx5IHdhbnQgdG8gZG8gaXMgDQo+ID4gaG9vayB1
cCAuaW90bGJfc3luY19tYXAgYW5kIGdlbmVyYWxseSBtYWtlIElPX1BHVEFCTEVfUVVJUktfVExC
SV9PTl9NQVAgDQo+ID4gY2xldmVyZXIsIGJlY2F1c2UgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gaXMgYXMgZHVtYiBhcyBpdCBjb3VsZCANCj4gPiBwb3NzaWJseSBiZS4gDQo+IA0KPiBpb3Rs
Yl9zeW5jX21hcCBvbmx5IGhhcyBvbmUgcGFyYW1ldGVyKGlvbW11X2RvbWFpbiksIGJ1dCBtdGsN
Cj4gaW9tbXVfZG9tYWluIG1heWJlIGluY2x1ZGUgdGhlIHdob2xlIGlvdmEgc3BhY2UsIGlmIG10
a19pb21tdSB0byBkbyB0bGINCj4gc3luYyBiYXNlZCBvbiBpb21tdV9kb21haW4sIGl0IGlzIGVx
dWl2YWxlbnQgdG8gZG8gdGxiIGZsdXNoIGFsbCBpbg0KPiBmYWN0Lg0KPiBpb21tdSBkcml2ZXIg
d2lsbCBkbyB0bGIgc3luYyBpbiBldmVyeSBtYXBwaW5nIHBhZ2Ugd2hlbiBtdGsgaW9tbXUgc2V0
cw0KPiBJT19QR1RBQkxFX1FVSVJLX1RMQklfT05fTUFQKGlvX3BndGFibGVfdGxiX2ZsdXNoX3dh
bGspLA0KPiBhcyBpcyB0aGUgY29tbWl0IG1lc3NhZ2UgbWVudGlvbmVkLCBpdCB3aWxsIGRyb3Ag
bWFwcGluZyBwZXJmb3JtYW5jZSBpbg0KPiBtdGsgcGxhdGZvcm0uDQo+IA0KPiANCj4gPiBJbiBm
YWN0IGlmIHdlIHNpbXBseSBwYXNzZWQgYW4gYWRkcmVzcyByYW5nZSB0byANCj4gPiAuaW90bGJf
c3luY19tYXAsIGlvLXBndGFibGUgcHJvYmFibHkgd291bGRuJ3QgbmVlZCB0byBiZSBpbnZvbHZl
ZCBhdCBhbGwgDQo+ID4gYW55IG1vcmUuDQpTb3JyeSwgSSBmb3JnZXQgdG8gcmVwbHkgdGhlIHF1
ZXN0aW9uIGluIHByZXZpb3VzIG1haWwuDQpEbyB5b3UgbWVhbiB3ZSBuZWVkIHRvIG1vZGlmeSBp
b3RsYl9zeW5jX21hcCgpIGlucHV0IHBhcmFtZXRlcihleDogYWRkDQpzdGFydC9lbmQgaW92YSk/
DQoNCj4gDQo+IEkga25vdyBpdCBpcyBub3QgYSBnb29kIGlkZWEgcHJvYmFibHkgYnkgYWRkaW5n
IGEgbmV3IGFwaSwgYnV0IEkgZm91bmQNCj4gb3V0IHRoYXQgdGxiIHN5bmMgb25seSB0byBiZSBk
b25lIGFmdGVyIG1hcHBpbmcgb25lIHBhZ2UsIHNvIGlmDQo+IG10a19pb21tdSBob3BlIHRvIGRv
IHRsYiBzeW5jIG9uY2UgYWZ0ZXIgYWxsIHRoZSBwYWdlcyBtYXAgZG9uZSwgY291bGQNCj4geW91
IGdpdmUgbWUgc29tZSBhZHZpY2VzPyB0aGFua3MhDQo+IA0KPiA+IA0KPiA+IFJvYmluLg0KPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNiArKysrKysN
Cj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCj4gPiA+IGluZGV4IDc4NWIyMjhkMzlhNi4uZDM0MDBjMTVmZjdiIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ID4gQEAgLTIyNCw2ICsyMjQsMTEgQEAgc3RhdGljIHZv
aWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6
ZV90IHNpemUsDQo+ID4gPiAgIAl9DQo+ID4gPiAgIH0NCj4gPiA+ICAgDQo+ID4gPiArc3RhdGlj
IHZvaWQgX19tdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWduZWQgbG9uZyBpb3Zh
LCBzaXplX3Qgc2l6ZSkNCj4gPiA+ICt7DQo+ID4gPiArCW10a19pb21tdV90bGJfZmx1c2hfcmFu
Z2Vfc3luYyhpb3ZhLCBzaXplLCAwLCBOVUxMKQ0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICAg
c3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9wYWdlX25vc3luYyhzdHJ1Y3QgaW9tbXVf
aW90bGJfZ2F0aGVyICpnYXRoZXIsDQo+ID4gPiAgIAkJCQkJICAgIHVuc2lnbmVkIGxvbmcgaW92
YSwgc2l6ZV90IGdyYW51bGUsDQo+ID4gPiAgIAkJCQkJICAgIHZvaWQgKmNvb2tpZSkNCj4gPiA+
IEBAIC01MzYsNiArNTQxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lv
bW11X29wcyA9IHsNCj4gPiA+ICAgCS5tYXAJCT0gbXRrX2lvbW11X21hcCwNCj4gPiA+ICAgCS51
bm1hcAkJPSBtdGtfaW9tbXVfdW5tYXAsDQo+ID4gPiAgIAkuZmx1c2hfaW90bGJfYWxsID0gbXRr
X2lvbW11X2ZsdXNoX2lvdGxiX2FsbCwNCj4gPiA+ICsJLmlvdGxiX3N5bmNfcmFuZ2UgPSBfX210
a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYywNCj4gPiA+ICAgCS5pb3RsYl9zeW5jCT0gbXRr
X2lvbW11X2lvdGxiX3N5bmMsDQo+ID4gPiAgIAkuaW92YV90b19waHlzCT0gbXRrX2lvbW11X2lv
dmFfdG9fcGh5cywNCj4gPiA+ICAgCS5wcm9iZV9kZXZpY2UJPSBtdGtfaW9tbXVfcHJvYmVfZGV2
aWNlLA0KPiA+ID4gDQo+IA0KDQo=

