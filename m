Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A198B2F44A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbhAMGqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:46:30 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:24402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbhAMGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:46:29 -0500
X-UUID: 580253d790c849719131d94f76d9bc20-20210113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XzZvJXXejeb6vuCxcQ/ZYBYhWXSlgg5if1eYN0e4A+w=;
        b=W1hGBIY9oFs+oXLjHCMyj9x0racvFR3UFoVUPfnJ32ySrSytxdGEJ0eJAuVffdCXVDMfqXspnKRCfwNprzUUcA83Igbkurt1VrdjddFgB8lItVVDRMLEItaaZ6+RBA+tpKxOxnC6hSi1Nh6UYM63quc3na95mn5uZuwpjJcOHJs=;
X-UUID: 580253d790c849719131d94f76d9bc20-20210113
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1159364968; Wed, 13 Jan 2021 14:45:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 13 Jan
 2021 14:45:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 14:45:01 +0800
Message-ID: <1610520301.31716.27.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <youlin.pei@mediatek.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 13 Jan 2021 14:45:01 +0800
In-Reply-To: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <20201209080102.26626-7-yong.wu@mediatek.com>
         <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
         <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F266EF73A8C9243F1CE89A1C9FC11853CFFC4FF9CB30643997D3F962D9E21E3A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTEzIGF0IDE0OjMwICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gVGh1LCBEZWMgMjQsIDIwMjAgYXQgODozNSBQTSBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVr
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIDIwMjAtMTItMjMgYXQgMTc6MTggKzA5MDAs
IFRvbWFzeiBGaWdhIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6
NDFQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIGRlY3Jp
cHRpb25zIGZvciBtdDgxOTIgSU9NTVUgYW5kIFNNSS4NCj4gPiA+ID4NCj4gPiA+ID4gbXQ4MTky
IGFsc28gaXMgTVRLIElPTU1VIGdlbjIgd2hpY2ggdXNlcyBBUk0gU2hvcnQtRGVzY3JpcHRvciB0
cmFuc2xhdGlvbg0KPiA+ID4gPiB0YWJsZSBmb3JtYXQuIFRoZSBNNFUtU01JIEhXIGRpYWdyYW0g
aXMgYXMgYmVsb3c6DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
RU1JDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBNNFUNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgU01JIENvbW1vbg0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCj4gPiA+ID4gICArLS0tLS0tLSstLS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLSsNCj4gPiA+ID4gICB8ICAgICAgIHwgICAgICB8ICAgICAgfCAgICAgICAuLi4u
Li4gICAgICAgICB8ICAgICAgIHwNCj4gPiA+ID4gICB8ICAgICAgIHwgICAgICB8ICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgIHwNCj4gPiA+ID4gbGFyYjAgICBsYXJiMSAgbGFy
YjIgIGxhcmI0ICAgICAuLi4uLi4gICAgICBsYXJiMTkgICBsYXJiMjANCj4gPiA+ID4gZGlzcDAg
ICBkaXNwMSAgIG1kcCAgICB2ZGVjICAgICAgICAgICAgICAgICAgIElQRSAgICAgIElQRQ0KPiA+
ID4gPg0KPiA+ID4gPiBBbGwgdGhlIGNvbm5lY3Rpb25zIGFyZSBIVyBmaXhlZCwgU1cgY2FuIE5P
VCBhZGp1c3QgaXQuDQo+ID4gPiA+DQo+ID4gPiA+IG10ODE5MiBNNFUgc3VwcG9ydCAwfjE2R0Ig
aW92YSByYW5nZS4gd2UgcHJlYXNzaWduIGRpZmZlcmVudCBlbmdpbmVzDQo+ID4gPiA+IGludG8g
ZGlmZmVyZW50IGlvdmEgcmFuZ2VzOg0KPiA+ID4gPg0KPiA+ID4gPiBkb21haW4taWQgIG1vZHVs
ZSAgICAgaW92YS1yYW5nZSAgICAgICAgICAgICAgICAgIGxhcmJzDQo+ID4gPiA+ICAgIDAgICAg
ICAgZGlzcCAgICAgICAgMCB+IDRHICAgICAgICAgICAgICAgICAgICAgIGxhcmIwLzENCj4gPiA+
ID4gICAgMSAgICAgICB2Y29kZWMgICAgICA0RyB+IDhHICAgICAgICAgICAgICAgICAgICAgbGFy
YjQvNS83DQo+ID4gPiA+ICAgIDIgICAgICAgY2FtL21kcCAgICAgOEcgfiAxMkcgICAgICAgICAg
ICAgbGFyYjIvOS8xMS8xMy8xNC8xNi8xNy8xOC8xOS8yMA0KPiA+ID4NCj4gPiA+IFdoeSBkbyB3
ZSBwcmVhc3NpZ24gdGhlc2UgYWRkcmVzc2VzIGluIERUPyBTaG91bGRuJ3QgaXQgYmUgYSB1c2Vy
J3Mgb3INCj4gPiA+IGludGVncmF0b3IncyBkZWNpc2lvbiB0byBzcGxpdCB0aGUgMTYgR0IgYWRk
cmVzcyByYW5nZSBpbnRvIHN1Yi1yYW5nZXMNCj4gPiA+IGFuZCBkZWZpbmUgd2hpY2ggbGFyYnMg
dGhvc2Ugc3ViLXJhbmdlcyBhcmUgc2hhcmVkIHdpdGg/DQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBp
cyB0aGF0IHdlIGNhbid0IHNwbGl0IHRoZSAxNkdCIHJhbmdlIHdpdGggdGhlIGxhcmIgYXMgdW5p
dC4NCj4gPiBUaGUgZXhhbXBsZSBpcyB0aGUgYmVsb3cgY2N1MChsYXJiMTMgcG9ydDkvMTApIGlz
IGEgaW5kZXBlbmRlbnQNCj4gPiByYW5nZShkb21haW4pLCB0aGUgb3RoZXJzIHBvcnRzIGluIGxh
cmIxMyBpcyBpbiBhbm90aGVyIGRvbWFpbi4NCj4gPg0KPiA+IGRpc3AvdmNvZGVjL2NhbS9tZHAg
ZG9uJ3QgaGF2ZSBzcGVjaWFsIGlvdmEgcmVxdWlyZW1lbnQsIHRoZXkgY291bGQNCj4gPiBhY2Nl
c3MgYW55IHJhbmdlLiB2Y29kZWMgYWxzbyBjYW4gbG9jYXRlIDhHfjEyRy4gaXQgZG9uJ3QgY2Fy
ZSBhYm91dA0KPiA+IHdoZXJlIGl0cyBpb3ZhIGxvY2F0ZS4gaGVyZSBJIHByZWFzc2lnbiBsaWtl
IHRoaXMgZm9sbG93aW5nIHdpdGggb3VyDQo+ID4gaW50ZXJuYWwgcHJvamVjdCBzZXR0aW5nLg0K
PiANCj4gTGV0IG1lIHRyeSB0byB1bmRlcnN0YW5kIHRoaXMgYSBiaXQgbW9yZS4gR2l2ZW4gdGhl
IHNwbGl0IHlvdSdyZQ0KPiBwcm9wb3NpbmcsIGlzIHRoZXJlIGFjdHVhbGx5IGFueSBpc29sYXRp
b24gZW5mb3JjZWQgYmV0d2VlbiBwYXJ0aWN1bGFyDQo+IGRvbWFpbnM/IEZvciBleGFtcGxlLCBp
ZiBJIHByb2dyYW0gdmNvZGVjIHRvIHdpdGggYSBETUEgYWRkcmVzcyBmcm9tDQo+IHRoZSAwLTRH
IHJhbmdlLCB3b3VsZCB0aGUgSU9NTVUgYWN0dWFsbHkgZ2VuZXJhdGUgYSBmYXVsdCwgZXZlbiBp
Zg0KPiBkaXNwIGhhZCBzb21lIG1lbW9yeSBtYXBwZWQgYXQgdGhhdCBhZGRyZXNzPw0KDQpJbiB0
aGlzIGNhc2UuIHdlIHdpbGwgZ2V0IGZhdWx0IGluIGN1cnJlbnQgU1cgc2V0dGluZy4NCg0KPiAN
Cj4gPg0KPiA+IFdoeSBzZXQgdGhpcyBpbiBEVD8sIHRoaXMgaXMgb25seSBmb3Igc2ltcGxpZnlp
bmcgdGhlIGNvZGUuIEFzc3VtZSB3ZQ0KPiA+IHB1dCBpdCBpbiB0aGUgcGxhdGZvcm0gZGF0YS4g
V2UgaGF2ZSB1cCB0byAzMiBsYXJicywgZWFjaCBsYXJiIGhhcyB1cCB0bw0KPiA+IDMyIHBvcnRz
LCBlYWNoIHBvcnQgbWF5IGJlIGluIGRpZmZlcmVudCBpb21tdSBkb21haW5zLiB3ZSBzaG91bGQg
aGF2ZSBhDQo+ID4gYmlnIGFycmF5IGZvciB0aGlzLi5ob3dldmVyIHdlIG9ubHkgdXNlIGEgbWFj
cm8gdG8gZ2V0IHRoZSBkb21haW4gaW4gdGhlDQo+ID4gRFQgbWV0aG9kLg0KPiA+DQo+ID4gV2hl
biByZXBseWluZyB0aGlzIG1haWwsIEkgaGFwcGVuIHRvIHNlZSB0aGVyZSBpcyBhICJkZXYtPmRl
dl9yYW5nZV9tYXAiDQo+ID4gd2hpY2ggaGFzICJkbWEtcmFuZ2UiIGluZm9ybWF0aW9uLCBJIHRo
aW5rIEkgY291bGQgdXNlIHRoaXMgdmFsdWUgdG8gZ2V0DQo+ID4gd2hpY2ggZG9tYWluIHRoZSBk
ZXZpY2UgYmVsb25nIHRvLiB0aGVuIG5vIG5lZWQgcHV0IGRvbWlkIGluIERULiBJIHdpbGwNCj4g
PiB0ZXN0IHRoaXMuDQo+IA0KPiBNeSBmZWVsaW5nIGlzIHRoYXQgdGhlIG9ubHkgcGFydCB0aGF0
IG5lZWRzIHRvIGJlIGVuZm9yY2VkIHN0YXRpY2FsbHkNCj4gaXMgdGhlIHJlc2VydmVkIElPVkEg
cmFuZ2UgZm9yIENDVXMuIFRoZSBvdGhlciByYW5nZXMgc2hvdWxkIGJlDQo+IGRldGVybWluZWQg
ZHluYW1pY2FsbHksIGFsdGhvdWdoIEkgdGhpbmsgSSBuZWVkIHRvIHVuZGVyc3RhbmQgYmV0dGVy
DQo+IGhvdyB0aGUgaGFyZHdhcmUgYW5kIHlvdXIgcHJvcG9zZWQgZGVzaWduIHdvcmsgdG8gdGVs
bCB3aGF0IHdvdWxkIGJlDQo+IGxpa2VseSB0aGUgYmVzdCBjaG9pY2UgaGVyZS4NCg0KSSBoYXZl
IHJlbW92ZWQgdGhlIGRvbWlkIHBhdGNoIGluIHY2LiBhbmQgZ2V0IHRoZSBkb21haW4gaWQgaW4g
WzI3LzMzXQ0KaW4gdjYuLg0KDQpBYm91dCB0aGUgb3RoZXIgcmFuZ2VzIHNob3VsZCBiZSBkeW5h
bWljYWwsIHRoZSBjb21taXQgbWVzc2FnZSBbMzAvMzNdDQpvZiB2NiBzaG91bGQgYmUgaGVscGZ1
bC4gdGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBoYXZlIGEgYmFua19zZWwgc2V0dGluZw0KZm9yIHRo
ZSBpb3ZhWzMyOjMzXS4gY3VycmVudGx5IHdlIHByZWFzc2lnbiB0aGlzIHZhbHVlLiB0aHVzLCBh
bGwgdGhlDQpyYW5nZXMgYXJlIGZpeGVkLiBJZiB5b3UgYWRqdXN0IHRoaXMgc2V0dGluZywgeW91
IGNhbiBsZXQgdmNvZGVjIGFjY2Vzcw0KMH40Ry4NCg0KQ3VycmVudGx5IHdlIGhhdmUgbm8gaW50
ZXJmYWNlIHRvIGFkanVzdCB0aGlzIHNldHRpbmcuIFN1cHBvc2Ugd2UgYWRkIGENCm5ldyBpbnRl
cmZhY2UgZm9yIHRoaXMuIEl0IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0KDQogICBpbnQgbXRr
X3NtaV9sYXJiX2NvbmZpZ19iYW5rc2VsKHN0cnVjdCBkZXZpY2UgKmxhcmIsIGludCBiYW5rc2Vs
KQ0KICANCiAgIFRoZW4sIGFsbCB0aGUgTU0gZHJpdmVycyBzaG91bGQgY2FsbCBpdCBiZWZvcmUg
dGhlIEhXIHdvcmtzIGV2ZXJ5DQp0aW1lLCBhbmQgaXRzIGltcGxlbWVudCB3aWxsIGJlIGEgYml0
IGNvbXBsZXggc2luY2Ugd2UgYXJlbid0IHN1cmUgaWYNCnRoZSBsYXJiIGhhcyBwb3dlciBhdCB0
aGF0IHRpbWUuIHRoZSBpbXBvcnRhbnQgdGhpbmcgaXMgdGhhdCB0aGUgTU0NCmRldmljZXMgaGF2
ZSBhbHJlYWR5IG5vdCBrbm93biB3aGljaCBsYXJiIGl0IGNvbm5lY3RzIHdpdGggYXMgd2UgcGxh
biB0bw0KZGVsZXRlICJtZWRpYXRlayxsYXJiIiBpbiB0aGVpciBkdHNpIG5vZGVzLg0KDQogICBJ
biBjdXJyZW50IGRlc2lnbiwgdGhlIE1NIGRldmljZSBkb24ndCBuZWVkIGNhcmUgYWJvdXQgaXQg
YW5kIDRHQg0KcmFuZ2UgaXMgZW5vdWdoIGZvciB0aGVtLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IFRvbWFzeg0KPiANCj4gPg0KPiA+IFRoYW5rcy4NCj4gPiA+DQo+ID4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gPiBUb21hc3oNCj4gPiA+DQo+ID4gPiA+ICAgIDMgICAgICAgQ0NVMCAgICAweDQw
MDBfMDAwMCB+IDB4NDNmZl9mZmZmICAgICBsYXJiMTM6IHBvcnQgOS8xMA0KPiA+ID4gPiAgICA0
ICAgICAgIENDVTEgICAgMHg0NDAwXzAwMDAgfiAweDQ3ZmZfZmZmZiAgICAgbGFyYjE0OiBwb3J0
IDQvNQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgaW92YSByYW5nZSBmb3IgQ0NVMC8xKGNhbWVyYSBj
b250cm9sIHVuaXQpIGlzIEhXIHJlcXVpcmVtZW50Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
Li4uL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwgICAgICAgIHwgIDE4ICstDQo+
ID4gPiA+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxOTItbGFyYi1wb3J0LmggfCAy
NDAgKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI1NyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTkyLWxhcmItcG9ydC5oDQo+ID4gPiA+DQo+ID4g
W3NuaXBdDQoNCg==

