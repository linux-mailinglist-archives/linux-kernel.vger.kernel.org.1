Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE329697E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371989AbgJWGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:04:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S371964AbgJWGEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:04:44 -0400
X-UUID: 6385b793c21d44268cae03c3f5b11d68-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lH/fAKl+nvEoU7Skw3vE5YheKD9t/B0oqKliE0vzg1A=;
        b=Gwit8wZryELP+BwrT4Ik4ryyDWTgSvmO9HKnyGjmlgkquglCM42EJFcuUgCOscXbPng+5QtJca10V/v0U1QRmEV12kCgP1H9goRI53zc32xAB6BP5ciGJRXwzJLaQWOn4Oo72dMgIOe436ZngtUKsykkuItvz+pDi0M762lK9+Q=;
X-UUID: 6385b793c21d44268cae03c3f5b11d68-20201023
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 81261952; Fri, 23 Oct 2020 14:04:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 14:04:31 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 14:04:31 +0800
Message-ID: <1603432677.2024.3.camel@mbjsdccf07>
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
Date:   Fri, 23 Oct 2020 13:57:57 +0800
In-Reply-To: <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
         <20201019113100.23661-3-chao.hao@mediatek.com>
         <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC5627839FE2C07D6347EA6BEF454BC7E6659A3C76B307EF4A2A088B5303E3F32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTIxIGF0IDE3OjU1ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjAtMTAtMTkgMTI6MzAsIENoYW8gSGFvIHdyb3RlOg0KPiA+IE1US19JT01NVSBkcml2
ZXIgd3JpdGVzIG9uZSBwYWdlIGVudHJ5IGFuZCBkb2VzIHRsYiBmbHVzaCBhdCBhIHRpbWUNCj4g
PiBjdXJyZW50bHkuIE1vcmUgb3B0aW1hbCB3b3VsZCBiZSB0byBhZ2dyZWdhdGUgdGhlIHdyaXRl
cyBhbmQgZmx1c2gNCj4gPiBCVVMgYnVmZmVyIGluIHRoZSBlbmQuDQo+IA0KPiBUaGF0J3MgZXhh
Y3RseSB3aGF0IGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcGFnZSgpIGlzIG1lYW50IHRvIGFjaGll
dmUuIA0KPiBSYXRoZXIgdGhhbiBqdW1waW5nIHN0cmFpZ2h0IGludG8gaGFja2luZyB1cCBhIG5l
dyBBUEkgdG8gZ28gcm91bmQgdGhlIA0KPiBiYWNrIG9mIHRoZSBleGlzdGluZyBBUEkgZGVzaWdu
LCBpdCB3b3VsZCBiZSBmYXIgYmV0dGVyIHRvIGFzayB0aGUgDQo+IHF1ZXN0aW9uIG9mIHdoeSB0
aGF0J3Mgbm90IGJlaGF2aW5nIGFzIGV4cGVjdGVkLg0KDQpUaGFua3MgZm9yIHlvdSByZXZpZXch
DQoNCmlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcGFnZSBpcyBwdXQgaW4gaW9fcGd0YWJsZV90bGJf
YWRkX3BhZ2UoKS4NCmlvX3BndGFibGVfdGxiX2FkZF9wYWdlKCkgb25seSBiZSBjYWxsZWQgaW4N
CnVubWFwcGluZyBhbmQgbWFwcGluZyBmbG93IGRvZXNuJ3QgaGF2ZSBpdCBpbiBsaW51eCBpb21t
dSBkcml2ZXIsIGJ1dA0KbXRrIGlvbW11IG5lZWRzIHRvIGRvIHRsYiBzeW5jIGluIG1hcHBpbmcN
CmFuZCB1bm1hcHBpbmcgdG8gYXZvaWQgb2xkIGRhdGEgYmVpbmcgaW4gdGhlIGlvbW11IHRsYi4N
Cg0KSW4gYWRkdGlvbiwgd2UgaG9wZSB0byBkbyB0bGIgc3luYyBvbmNlIHdoZW4gYWxsIHRoZSBw
YWdlcyBtYXBwaW5nIGRvbmUuDQppb21tdV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2UgbWF5YmUgZG8N
CnRsYiBzeW5jIG1vcmUgdGhhbiBvbmNlLiBiZWNhdXNlIG9uZSB3aG9sZSBidWZmZXIgY29uc2lz
dHMgb2YgZGlmZmVyZW50DQpwYWdlIHNpemUoMU1CLzY0Sy80SykuDQoNCkJhc2VkIG9uIHRoZSBw
cmV2aW91cyBjb25zaWRlcmF0aW9ucywgIGRvbid0IGZpbmQgbW9yZSBhcHByb3ByaWF0ZSB0aGUN
CndheSBvZiB0bGIgc3luYyBmb3IgbXRrIGlvbW11LCBzbyB3ZSBhZGQgYSBuZXcgQVBJLg0KDQo+
IA0KPiA+IEZvciA1ME1CIGJ1ZmZlciBtYXBwaW5nLCBpZiBtdGtfaW9tbXUgZHJpdmVyIHVzZSBp
b3RsYl9zeW5jX3JhbmdlKCkNCj4gPiBpbnN0ZWFkIG9mIHRsYl9hZGRfcmFuZ2UoKSBhbmQgdGxi
X2ZsdXNoX3dhbGsvbGVhZigpLCBpdCBjYW4gaW5jcmVhc2UNCj4gPiA1MCUgcGVyZm9ybWFuY2Ug
b3IgbW9yZShkZXBlbmRpbmcgb24gc2l6ZSBvZiBldmVyeSBwYWdlIHNpemUpIGluDQo+ID4gY29t
cGFyaXNvbiB0byBmbHVzaGluZyBhZnRlciBlYWNoIHBhZ2UgZW50cnkgdXBkYXRlLiBTbyB3ZSBw
cmVmZXIgdG8NCj4gPiB1c2UgaW90bGJfc3luY19yYW5nZSgpIHRvIHJlcGxhY2UgaW90bGJfc3lu
YygpLCB0bGJfYWRkX3JhbmdlKCkgYW5kDQo+ID4gdGxiX2ZsdXNoX3dhbGsvbGVhZigpIGZvciBN
VEsgcGxhdGZvcm1zLg0KPiANCj4gSW4gdGhlIGNhc2Ugb2YgbWFwcGluZywgaXQgc291bmRzIGxp
a2Ugd2hhdCB5b3UgYWN0dWFsbHkgd2FudCB0byBkbyBpcyANCj4gaG9vayB1cCAuaW90bGJfc3lu
Y19tYXAgYW5kIGdlbmVyYWxseSBtYWtlIElPX1BHVEFCTEVfUVVJUktfVExCSV9PTl9NQVAgDQo+
IGNsZXZlcmVyLCBiZWNhdXNlIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGFzIGR1bWIg
YXMgaXQgY291bGQgDQo+IHBvc3NpYmx5IGJlLiANCg0KaW90bGJfc3luY19tYXAgb25seSBoYXMg
b25lIHBhcmFtZXRlcihpb21tdV9kb21haW4pLCBidXQgbXRrDQppb21tdV9kb21haW4gbWF5YmUg
aW5jbHVkZSB0aGUgd2hvbGUgaW92YSBzcGFjZSwgaWYgbXRrX2lvbW11IHRvIGRvIHRsYg0Kc3lu
YyBiYXNlZCBvbiBpb21tdV9kb21haW4sIGl0IGlzIGVxdWl2YWxlbnQgdG8gZG8gdGxiIGZsdXNo
IGFsbCBpbg0KZmFjdC4NCmlvbW11IGRyaXZlciB3aWxsIGRvIHRsYiBzeW5jIGluIGV2ZXJ5IG1h
cHBpbmcgcGFnZSB3aGVuIG10ayBpb21tdSBzZXRzDQpJT19QR1RBQkxFX1FVSVJLX1RMQklfT05f
TUFQKGlvX3BndGFibGVfdGxiX2ZsdXNoX3dhbGspLA0KYXMgaXMgdGhlIGNvbW1pdCBtZXNzYWdl
IG1lbnRpb25lZCwgaXQgd2lsbCBkcm9wIG1hcHBpbmcgcGVyZm9ybWFuY2UgaW4NCm10ayBwbGF0
Zm9ybS4NCg0KDQo+IEluIGZhY3QgaWYgd2Ugc2ltcGx5IHBhc3NlZCBhbiBhZGRyZXNzIHJhbmdl
IHRvIA0KPiAuaW90bGJfc3luY19tYXAsIGlvLXBndGFibGUgcHJvYmFibHkgd291bGRuJ3QgbmVl
ZCB0byBiZSBpbnZvbHZlZCBhdCBhbGwgDQo+IGFueSBtb3JlLg0KDQpJIGtub3cgaXQgaXMgbm90
IGEgZ29vZCBpZGVhIHByb2JhYmx5IGJ5IGFkZGluZyBhIG5ldyBhcGksIGJ1dCBJIGZvdW5kDQpv
dXQgdGhhdCB0bGIgc3luYyBvbmx5IHRvIGJlIGRvbmUgYWZ0ZXIgbWFwcGluZyBvbmUgcGFnZSwg
c28gaWYNCm10a19pb21tdSBob3BlIHRvIGRvIHRsYiBzeW5jIG9uY2UgYWZ0ZXIgYWxsIHRoZSBw
YWdlcyBtYXAgZG9uZSwgY291bGQNCnlvdSBnaXZlIG1lIHNvbWUgYWR2aWNlcz8gdGhhbmtzIQ0K
DQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFv
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCA2ICsrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IDc4NWIyMjhkMzlhNi4uZDM0MDBjMTVmZjdiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTIyNCw2ICsyMjQsMTEgQEAgc3RhdGljIHZvaWQg
bXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90
IHNpemUsDQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gK3N0YXRpYyB2b2lkIF9fbXRr
X2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IHNp
emUpDQo+ID4gK3sNCj4gPiArCW10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyhpb3ZhLCBz
aXplLCAwLCBOVUxMKQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgbXRrX2lvbW11
X3RsYl9mbHVzaF9wYWdlX25vc3luYyhzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyICpnYXRoZXIs
DQo+ID4gICAJCQkJCSAgICB1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBncmFudWxlLA0KPiA+
ICAgCQkJCQkgICAgdm9pZCAqY29va2llKQ0KPiA+IEBAIC01MzYsNiArNTQxLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lvbW11X29wcyA9IHsNCj4gPiAgIAkubWFwCQk9
IG10a19pb21tdV9tYXAsDQo+ID4gICAJLnVubWFwCQk9IG10a19pb21tdV91bm1hcCwNCj4gPiAg
IAkuZmx1c2hfaW90bGJfYWxsID0gbXRrX2lvbW11X2ZsdXNoX2lvdGxiX2FsbCwNCj4gPiArCS5p
b3RsYl9zeW5jX3JhbmdlID0gX19tdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmMsDQo+ID4g
ICAJLmlvdGxiX3N5bmMJPSBtdGtfaW9tbXVfaW90bGJfc3luYywNCj4gPiAgIAkuaW92YV90b19w
aHlzCT0gbXRrX2lvbW11X2lvdmFfdG9fcGh5cywNCj4gPiAgIAkucHJvYmVfZGV2aWNlCT0gbXRr
X2lvbW11X3Byb2JlX2RldmljZSwNCj4gPiANCg0K

