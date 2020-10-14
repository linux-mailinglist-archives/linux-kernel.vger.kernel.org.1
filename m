Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C81428DA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgJNHHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:07:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61231 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgJNHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:07:46 -0400
X-UUID: 597ff07714d449a18eed34164f43ca0d-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=liqqNPZ7bhnTmHQkiIXmgSnZuggaH0is3HAOFrjhmfI=;
        b=rJ47ziMLdbDOQz4WrNOmGUq+hrZ/ysAxMX2mxZGu1FikYksj9EtRVM+/pNzT6Lsn0OYVrvm+jySBPKJPYnhlVIQ5fv0TCz0g7DD6k29OSMWQVDSfWz4SdfVJmtqJjJsc6wpwm8QWZZe2spDEwvIo7C8tv4P7MEje4TzBUwDAU5o=;
X-UUID: 597ff07714d449a18eed34164f43ca0d-20201014
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1753992200; Wed, 14 Oct 2020 15:07:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Oct
 2020 15:07:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 15:07:32 +0800
Message-ID: <1602659253.29336.79.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/8] dt-bindings: phy: convert HDMI PHY binding to
 YAML schema
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Wed, 14 Oct 2020 15:07:33 +0800
In-Reply-To: <1602650671.27998.2.camel@mtksdaap41>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
         <20201013085207.17749-4-chunfeng.yun@mediatek.com>
         <1602650671.27998.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7D3A8E0BF2FC977AE7986068420E20580FCD3FFE574376E72318CF014D5E6D432000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTE0IGF0IDEyOjQ0ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIENo
dW5mZW5nOg0KPiANCj4gT24gVHVlLCAyMDIwLTEwLTEzIGF0IDE2OjUyICswODAwLCBDaHVuZmVu
ZyBZdW4gd3JvdGU6DQo+ID4gQ29udmVydCBIRE1JIFBIWSBiaW5kaW5nIHRvIFlBTUwgc2NoZW1h
IG1lZGlhdGVrLHVmcy1waHkueWFtbA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogZml4IGJp
bmRpbmcgY2hlY2sgd2FybmluZyBvZiByZWcgaW4gZXhhbXBsZQ0KPiA+IC0tLQ0KPiA+ICAuLi4v
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxoZG1pLnR4dCAgICAgICAgfCAxNyArLS0tDQo+ID4g
IC4uLi9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbCAgICAgICB8IDkwICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCAx
NiBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssaGRtaS1waHkueWFtbA0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxoZG1pLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGhkbWkudHh0DQo+ID4gaW5kZXggN2IxMjQyNDJi
MGM1Li5lZGFjMTg5NTFhNzUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssaGRtaS50eHQNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxoZG1pLnR4dA0KPiA+IEBAIC01MCwyMiArNTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICANCj4gPiAgSERNSSBQSFkNCj4gPiAgPT09PT09PT0NCj4gPiAtDQo+ID4gLVRoZSBI
RE1JIFBIWSBzZXJpYWxpemVzIHRoZSBIRE1JIGVuY29kZXIncyB0aHJlZSBjaGFubmVsIDEwLWJp
dCBwYXJhbGxlbA0KPiA+IC1vdXRwdXQgYW5kIGRyaXZlcyB0aGUgSERNSSBwYWRzLg0KPiA+IC0N
Cj4gPiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtLSBjb21wYXRpYmxlOiAibWVkaWF0ZWss
PGNoaXA+LWhkbWktcGh5Ig0KPiA+IC0tIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBs
ZW5ndGggb2YgdGhlIG1vZHVsZSdzIHJlZ2lzdGVycw0KPiA+IC0tIGNsb2NrczogUExMIHJlZmVy
ZW5jZSBjbG9jaw0KPiA+IC0tIGNsb2NrLW5hbWVzOiBtdXN0IGNvbnRhaW4gInBsbF9yZWYiDQo+
ID4gLS0gY2xvY2stb3V0cHV0LW5hbWVzOiBtdXN0IGJlICJoZG1pdHhfZGlnX2N0cyIgb24gbXQ4
MTczDQo+ID4gLS0gI3BoeS1jZWxsczogbXVzdCBiZSA8MD4NCj4gPiAtLSAjY2xvY2stY2VsbHM6
IG11c3QgYmUgPDA+DQo+ID4gLQ0KPiA+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+IC0tIG1l
ZGlhdGVrLGliaWFzOiBUWCBEUlYgYmlhcyBjdXJyZW50IGZvciA8MS42NUdicHMsIGRlZmF1bHRz
IHRvIDB4YQ0KPiA+IC0tIG1lZGlhdGVrLGliaWFzX3VwOiBUWCBEUlYgYmlhcyBjdXJyZW50IGZv
ciA+MS42NUdicHMsIGRlZmF1bHRzIHRvIDB4MWMNCj4gPiArU2VlIHBoeS9tZWRpYXRlayxoZG1p
LXBoeS55YW1sDQo+ID4gIA0KPiA+ICBFeGFtcGxlOg0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1p
LXBoeS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjc3ZGY1MDIwNDYwNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCj4gPiBA
QCAtMCwwICsxLDkwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICsjIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRl
aw0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUu
b3JnL3NjaGVtYXMvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiAr
dGl0bGU6IE1lZGlhVGVrIEhpZ2ggRGVmaW5pdGlvbiBNdWx0aW1lZGlhIEludGVyZmFjZSAoSERN
SSkgUEhZIGJpbmRpbmcNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IEkgdGhpbmsgeW91IHNob3VsZCByZW1vdmUgIkNL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+IiBhbmQgYWRkIGxhdGVzdA0KPiBtZWRpYXRlayBkcm0g
bWFpbnRhaW5lcjoNCk9rLCB3aWxsIGRvIGl0LCB0aGFua3MNCg0KPiANCj4gRFJNIERSSVZFUlMg
Rk9SIE1FRElBVEVLDQo+IE06CUNodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3Jn
Pg0KPiBNOglQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBMOglkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFM6CVN1cHBvcnRlZA0KPiBGOglEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay8NCj4gRjoJZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrLw0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCg0K

