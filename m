Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08592784B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIYKGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:06:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgIYKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:06:06 -0400
X-UUID: 357d642f6173461d9e22a29083a61259-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Bph4b89m0n2SvzrQ5y28tD7qLIYsd+I1XIgm6YWOMxg=;
        b=uYdoEsn+gAceZhj9nTI+EJ9/uYegZSglG4cVZiwuPbc+vzLAhzefsG+snIJX4/mz7GY7tZune8HIxGV2S+aSg3XcZx86Ze2sDv4O3dGeY+MZE1g0bP450dNZWEVYRJyUMACVEsgNabpbq307nmEeOTyn5jPRIer+vxJV9M5jhUU=;
X-UUID: 357d642f6173461d9e22a29083a61259-20200925
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 689825253; Fri, 25 Sep 2020 18:06:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Sep
 2020 18:06:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 18:06:00 +0800
Message-ID: <1601028361.1346.38.camel@mtksdaap41>
Subject: Re: [PATCH 00/12] soc: mediatek: pm-domains: Add new driver for
 SCPSYS power domains controller
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        <fparent@baylibre.com>, <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>, <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 25 Sep 2020 18:06:01 +0800
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDE5OjI4ICswMjAwLCBFbnJpYyBCYWxsZXRibyBpIFNlcnJh
IHdyb3RlOg0KPiBEZWFyIGFsbCwNCj4gDQo+IFRoaXMgaXMgYSBuZXcgZHJpdmVyIHdpdGggdGhl
IGFpbSB0byBkZXByZWNhdGUgdGhlIG10ay1zY3BzeXMgZHJpdmVyLg0KPiBUaGUgcHJvYmxlbSB3
aXRoIHRoYXQgZHJpdmVyIGlzIHRoYXQsIGluIG9yZGVyIHRvIHN1cHBvcnQgbW9yZSBNZWRpYXRl
aw0KPiBTb0NzIHlvdSBuZWVkIHRvIGFkZCBzb21lIGxvZ2ljIHRvIGhhbmRsZSBwcm9wZXJseSB0
aGUgcG93ZXItdXANCj4gc2VxdWVuY2Ugb2YgbmV3ZXIgTWVkaWF0ZWsgU29DcywgZG9lc24ndCBo
YW5kbGUgcGFyZW50LWNoaWxkIHBvd2VyDQo+IGRvbWFpbnMgYW5kIG5lZWQgdG8gaGFyZGNvZGUg
YWxsIHRoZSBjbG9ja3MgaW4gdGhlIGRyaXZlciBpdHNlbGYuIFRoZQ0KPiByZXN1bHQgaXMgdGhh
dCB0aGUgZHJpdmVyIGlzIGdldHRpbmcgYmlnZ2VyIGFuZCBiaWdnZXIgZXZlcnkgdGltZSBhDQo+
IG5ldyBTb0MgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLg0KPiANCg0KSGkgRW5yaWMgYW5kIE1hdHRo
aWFzLA0KDQpGaXJzdCBvZiBhbGwsIHRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLiBCdXQgSSdtIHdv
cnJpZWQgdGhlIHByb2JsZW0geW91DQptZW50aW9uZWQgd29uJ3QgYmUgc29sdmVkIGV2ZW4gaWYg
d2Ugd29yayBvbiB0aGlzIG5ldyBkcml2ZXIgaW4gdGhlDQpmdXR1cmUuIE15IHdvcmsgb24gdGhl
IE1UODE4MyBzY3BzeXMobm93IHYxNykgaXMgdG8gaW1wbGVtZW50IHRoZSBuZXcNCmhhcmR3YXJl
IGxvZ2ljLiBIZXJlLCBJIGFsc28gc2VlIHJlbGF0ZWQgcGF0Y2hlcywgd2hpY2ggbWVhbnMgdGhh
dCB0aGVzZQ0KbmV3IGxvZ2ljcyBhcmUgbmVjZXNzYXJ5LiBXaHkgY2FuJ3Qgd2Ugd29yayBvbiB0
aGUgb3JpZ2luYWwgZHJpdmVyPw0KTWVhbndoaWxlLCBJIHRob3VnaHQgbWF5YmUgd2Ugc2hvdWxk
IHNlcGFyYXRlIHRoZSBkcml2ZXIgaW50byBnZW5lcmFsDQpjb250cm9sIGFuZCBwbGF0Zm9ybSBk
YXRhIGZvciBlYWNoIFNvQywgb3RoZXJ3aXNlIGl0J2xsIGtlZXAgZ2V0dGluZw0KYmlnZ2VyIGFu
ZCBiaWdnZXIgaWYgaXQgbmVlZCB0byBiZSBzdXBwb3J0IG5ldyBTb0MuDQoNCkFuZCBjb25zaWRl
ciBEVkZTUkMNCihkeW5hbWljIHZvbHRhZ2UgYW5kIGZyZXF1ZW5jeSBzY2FsaW5nIHJlc291cmNl
IGNvbGxlY3RvciksIHNob3VsZCB3ZQ0Ka2VlcCB0aGUgb3JpZ2luYWwgZHJpdmVyIG5hbWUgInNj
cHN5cyIgaW5zdGVhZCBvZiAicG0tZG9tYWlucyIgYmVjYXVzZQ0KaXQgbWF5IHByb3ZpZGUgbW9y
ZSBmdW5jdGlvbnMgdGhhbiBwb3dlciBkb21haW5zPw0KDQo+IEFsbCB0aGlzIGluZm9ybWF0aW9u
IGNhbiBiZSBnZXR0ZWQgZnJvbSBhIHByb3Blcmx5IGRlZmluZWQgYmluZGluZywgc28NCj4gY2Fu
IGJlIGNsZWFuZXIgYW5kIHNtYWxsZXIsIGhlbmNlLCB3ZSBpbXBsZW1lbnRlZCBhIG5ldyBkcml2
ZXIuIEZvcg0KPiBub3csIG9ubHkgTVQ4MTczIGFuZCBNVDgxODMgaXMgc3VwcG9ydGVkIGJ1dCBz
aG91bGQgYmUgZmFpcmx5IGVhc3kgdG8NCj4gYWRkIHN1cHBvcnQgZm9yIG5ldyBTb0NzLg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiAgIEVucmljDQo+IA0KPiBFbnJpYyBCYWxsZXRibyBpIFNlcnJh
ICg0KToNCj4gICBkdC1iaW5kaW5nczogcG93ZXI6IEFkZCBiaW5kaW5ncyBmb3IgdGhlIE1lZGlh
dGVrIFNDUFNZUyBwb3dlciBkb21haW5zDQo+ICAgICBjb250cm9sbGVyDQo+ICAgc29jOiBtZWRp
YXRlazogQWRkIE1lZGlhVGVrIFNDUFNZUyBwb3dlciBkb21haW5zDQo+ICAgYXJtNjQ6IGR0czog
bWVkaWF0ZWs6IEFkZCBtdDgxNzMgcG93ZXIgZG9tYWluIGNvbnRyb2xsZXINCj4gICBkdC1iaW5k
aW5nczogcG93ZXI6IEFkZCBNVDgxODMgcG93ZXIgZG9tYWlucw0KPiANCj4gTWF0dGhpYXMgQnJ1
Z2dlciAoOCk6DQo+ICAgc29jOiBtZWRpYXRlazogcG0tZG9tYWluczogQWRkIGJ1cyBwcm90ZWN0
aW9uIHByb3RvY29sDQo+ICAgc29jOiBtZWRpYXRlazogcG1fZG9tYWluczogTWFrZSBidXMgcHJv
dGVjdGlvbiBnZW5lcmljDQo+ICAgc29jOiBtZWRpYXRlazogcG0tZG9tYWluczogQWRkIFNNSSBi
bG9jayBhcyBidXMgcHJvdGVjdGlvbiBibG9jaw0KPiAgIHNvYzogbWVkaWF0ZWs6IHBtLWRvbWFp
bnM6IEFkZCBleHRyYSBzcmFtIGNvbnRyb2wNCj4gICBzb2M6IG1lZGlhdGVrOiBwbS1kb21haW5z
OiBBZGQgc3Vic3lzdGVtIGNsb2Nrcw0KPiAgIHNvYzogbWVkaWF0ZWs6IHBtLWRvbWFpbnM6IEFs
bG93IGJ1cyBwcm90ZWN0aW9uIHRvIGlnbm9yZSBjbGVhciBhY2sNCj4gICBzb2M6IG1lZGlhdGVr
OiBwbS1kb21haW5zOiBBZGQgc3VwcG9ydCBmb3IgbXQ4MTgzDQo+ICAgYXJtNjQ6IGR0czogbWVk
aWF0ZWs6IEFkZCBtdDgxODMgcG93ZXIgZG9tYWlucyBjb250cm9sbGVyDQo+IA0KPiAgLi4uL3Bv
d2VyL21lZGlhdGVrLHBvd2VyLWNvbnRyb2xsZXIueWFtbCAgICAgIHwgMTczICsrKysNCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgICAgICB8ICA3OCArLQ0KPiAg
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgIHwgMTYwICsrKw0K
PiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDEzICsN
Cj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstaW5mcmFjZmcuYyAgICAgICAgICAgfCAgIDUg
LQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyAgICAgICAgIHwgOTUy
ICsrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMt
cG93ZXIuaCAgICAgIHwgIDI2ICsNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJh
Y2ZnLmggICAgICAgICB8ICAzOSArDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDE0MzMgaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL21lZGlhdGVrLHBvd2VyLWNvbnRyb2xsZXIueWFt
bA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbS1kb21h
aW5zLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210
ODE4My1wb3dlci5oDQo+IA0KDQo=

